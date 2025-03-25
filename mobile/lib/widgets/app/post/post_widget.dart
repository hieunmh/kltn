import 'package:flutter/material.dart';
import 'package:mobile/models/post.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final Color color;
  final Function ontap;

  const PostWidget({super.key, required this.post, required this.color, required this.ontap});

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
              children: [
                (post.user.imageUrl ?? '').isNotEmpty ? 
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                      post.imageUrl!, 
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                      // ...
                    )
          
                ) : Container(
                  width: 40, 
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, 
                    border: Border.all( 
                      color: Colors.grey.shade400, 
                      width: 1.5,
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
            ),
          ),

          const SizedBox(height: 10),

          (post.imageUrl ?? '').isNotEmpty ? Image.network(
            post.imageUrl!,
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
                            post.commentCount.toString(),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    (post.imageUrl ?? '').isNotEmpty ? Row(
                      children: [
                        Text(
                          post.user.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ): SizedBox(),

                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: 14
                      ),
                    ),
                  ],
                ),

                Text(
                  post.content,
                  style: TextStyle(
                    fontSize: 14
                  ),
                ),
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
                            post.commentCount.toString(),
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