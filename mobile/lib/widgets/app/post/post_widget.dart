import 'package:flutter/material.dart';
import 'package:mobile/models/post.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final Color color;
  final Function ontap;
  final String supabaseUrl;

  const PostWidget({
    super.key, 
    required this.post, 
    required this.color, 
    required this.ontap,
    required this.supabaseUrl
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
              children: [
                (post.user.imageUrl ?? '').isNotEmpty ? 
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                      supabaseUrl + post.user.imageUrl!, 
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
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black, // Hoặc màu chữ phù hợp
                      ),
                      children: [
                        (post.imageUrl ?? '').isNotEmpty ? TextSpan(
                          text: '${post.user.name} ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ) : const TextSpan(),
                        

                        TextSpan(
                          text: post.content,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
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