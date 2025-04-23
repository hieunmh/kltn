import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/models/comment.dart';

class CommentBox extends StatelessWidget {
  final Comment comment;
  final String userid;
  final String supabaseUrl;
  final String currentUserImage;

  const CommentBox({super.key, required this.comment, required this.userid, required this.supabaseUrl, required this.currentUserImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              currentUserImage.isNotEmpty && userid == comment.user.id ? Container(
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
                    ) : (comment.user.imageUrl ?? '').isNotEmpty ? 
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
                          supabaseUrl + comment.user.imageUrl!, 
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

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        comment.user.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14
                        )
                      ),
                      SizedBox(width: 5),

                      Text(
                        _getTimeAgo(DateTime.parse(comment.createdAt)),
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      )
                    ],
                  ),
                  Text(comment.content),
                ],
              ),
            ],
          ),    


          comment.user.id == userid ? IconButton(
            icon: Icon(BoxIcons.bx_chevron_left),
            onPressed: () {

            },
          ) : Container()     
        ],
      ),
    );
  }
}

String _getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 365) {
    return '${(difference.inDays / 365).floor()}y ago';
  } else if (difference.inDays > 7) {
    return '${(difference.inDays / 7).floor()}w ago';
  } else if (difference.inDays > 0) {
    return '${difference.inDays}d ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}m ago';
  } else {
    return 'Just now';
  }
}
