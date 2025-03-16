import 'package:flutter/material.dart';
import 'package:mobile/models/post.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class PostWidget extends StatelessWidget {
  final Post post;


  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: (post.imageUrl ?? '').isNotEmpty 
                  ? Image.network(
                      post.imageUrl!, 
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                      // ...
                    )
                  : Image.network('https://placehold.co/400', 
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
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

          Image.network(
            post.imageUrl ?? 'https://placehold.co/400',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      BoxIcons.bx_message_rounded,
                      size: 24
                    ),
                    SizedBox(width: 5),
                    Text(
                      '90',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
            
                Icon(
                  BoxIcons.bx_tag,
                  // Iconsax.save_2_outline,
                  size: 24
                )
              ],
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      post.user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),
                    ),
                    const SizedBox(width: 5),
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

          const SizedBox(height: 1),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              DateFormat('EEEE, MMMM dd, yyyy').format(DateTime.parse(post.createdAt)),
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