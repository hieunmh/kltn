import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/models/post.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:mobile/theme/theme_controller.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final Color color;
  final Function ontap;
  final String supabaseUrl;
  final String userid;
  final ThemeController themeController;
  final Function(String) deletePost;
  final String currentUserImage;


  const PostWidget({
    super.key, 
    required this.post, 
    required this.color, 
    required this.ontap,
    required this.supabaseUrl,
    required this.userid,
    required this.themeController,
    required this.deletePost,
    required this.currentUserImage
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    currentUserImage.isNotEmpty && userid == post.user.id ? Container(
                      width: 40, 
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, 
                        border: Border.all( 
                          color: Colors.grey.shade400, 
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          supabaseUrl + currentUserImage,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ) : (post.user.imageUrl ?? '').isNotEmpty ? 
                    Container(
                      width: 40, 
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, 
                        border: Border.all( 
                          color: Colors.grey.shade400, 
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          supabaseUrl + post.user.imageUrl!, 
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        )
                      ),
                    ) : Container(
                      width: 40, 
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, 
                        border: Border.all( 
                          color: Colors.grey.shade400, 
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/image/user-placeholder.png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(width: 10),

                    Text(
                      post.user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                  ],
                )
,
                userid == post.user.id ? PopupMenuButton(
                  color: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400,
                        width: 0.5
                      )
                    ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(BoxIcons.bx_pencil),
                            SizedBox(width: 5),
                            Text(
                              'Edit',
                            ),
                          ],
                        ),
                      ),

                      PopupMenuItem(
                        onTap: () {
                          Get.dialog(
                            CupertinoAlertDialog(
                              content: Text('Are you sure to delete this post?'),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.blue.shade600,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onPressed: () {
                                    deletePost(post.id);
                                    Get.back();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Delete post successfully!'),
                                        duration: Duration(seconds: 1),
                                      )
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        value: 'delete',
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(BoxIcons.bx_trash, color: Colors.red),
                            SizedBox(width: 5),
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.red
                              ),
                            ),
                          ],
                        ),
                      )
                    ];
                  },
                  child:  Icon(
                    BoxIcons.bx_dots_horizontal_rounded,
                    size: 24, 
                  ),
                ) : SizedBox(),
              ],
            ),
          ),

          const SizedBox(height: 10),

          (post.imageUrl ?? '').isNotEmpty ? Image.network(
            supabaseUrl + post.imageUrl!,
            width: double.infinity,
            fit: BoxFit.cover,
          ) : Container(),


          (post.imageUrl ?? '').isNotEmpty ? Column(
            children: [
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ontap();
                      },
                      child: Row(
                        children: [
                          Icon(
                            BoxIcons.bx_message_rounded,
                            size: 24
                          ),
                          SizedBox(width: 5),
                          Text(
                            post.comments.length.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    Icon(
                      BoxIcons.bx_bookmark,
                      // Iconsax.save_2_outline,
                      size: 24
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
            ],
          ) : SizedBox(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        (post.imageUrl ?? '').isNotEmpty ? TextSpan(
                          text: '${post.user.name} ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: themeController.isDark.value ? Colors.white : Colors.black,
                          ),
                        ) : const TextSpan(),
                        
                        TextSpan(
                          text: post.content,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: themeController.isDark.value ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ), 
                  ),
                )
              ],
            ),
          ),

          (post.imageUrl ?? '').isEmpty ? Column(
            children: [
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ontap();
                      },
                      child: Row(
                        children: [
                          Icon(
                            BoxIcons.bx_message_rounded,
                            size: 24
                          ),
                          SizedBox(width: 5),
                          Text(
                            post.comments.length.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    Icon(
                      BoxIcons.bx_bookmark,
                      // Iconsax.save_2_outline,
                      size: 24
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
            ],
          ) : SizedBox(),

          const SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${DateFormat('EEEE, MMMM dd, yyyy').format(DateTime.parse(post.createdAt))} at ${DateFormat('HH:mm').format(DateTime.parse(post.createdAt))}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey
              ),
            ),
          ),
        ],
      ),
    );
  }
}