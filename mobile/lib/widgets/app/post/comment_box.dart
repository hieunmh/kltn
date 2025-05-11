import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/models/comment.dart';
import 'dart:async';
import 'package:get/get.dart';

class CommentBox extends StatefulWidget {
  final Comment comment;
  final String userid;
  final String supabaseUrl;
  final String currentUserImage;
  final String currentUserName;

  const CommentBox({
    super.key, 
    required this.comment, 
    required this.userid, 
    required this.supabaseUrl, 
    required this.currentUserImage, 
    required this.currentUserName
  });

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  late final Rx<String> timeAgo;
  Timer? _timer;
  final commentTime = Rx<DateTime>(DateTime.now());

  @override
  void initState() {
    super.initState();
    commentTime.value = DateTime.parse(widget.comment.createdAt);
    timeAgo = _getTimeAgo(commentTime.value).obs;
    
    // Quyết định tần suất cập nhật dựa trên độ cũ của bình luận
    final difference = DateTime.now().difference(commentTime.value);
    
    // Nếu comment mới hơn 1 giờ, cập nhật mỗi phút
    // Nếu comment từ 1 giờ đến 1 ngày, cập nhật mỗi giờ
    // Nếu comment cũ hơn 1 ngày, không cần cập nhật
    if (difference.inHours < 1) {
      _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        timeAgo.value = _getTimeAgo(commentTime.value);
      });
    } else if (difference.inDays < 1) {
      _timer = Timer.periodic(const Duration(hours: 1), (timer) {
        timeAgo.value = _getTimeAgo(commentTime.value);
      });
    }
    // Không tạo timer cho comments cũ hơn 1 ngày
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.currentUserImage.isNotEmpty && widget.userid == widget.comment.user.id ? Container(
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
                    widget.supabaseUrl + widget.currentUserImage,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ) : (widget.comment.user.imageUrl ?? '').isNotEmpty ? 
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
                    widget.supabaseUrl + widget.comment.user.imageUrl!, 
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
                        widget.comment.userid == widget.userid ? widget.currentUserName : widget.comment.user.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14
                        )
                      ),
                      SizedBox(width: 5),

                      Obx(() => Text(
                        timeAgo.value,
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ))
                    ],
                  ),
                  Text(widget.comment.content),
                ],
              ),
            ],
          ),    
          widget.comment.user.id == widget.userid ? Icon(BoxIcons.bx_chevron_left) : Container()     
        ],
      ),
    );
  }
}

String _getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 365) {
    return '${(difference.inDays / 365).floor()} năm trước';
  } else if (difference.inDays > 7) {
    return '${(difference.inDays / 7).floor()} tuần trước';
  } else if (difference.inDays > 0) {
    return '${difference.inDays} ngày trước';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} giờ trước';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} phút trước';
  } else {
    return 'Vừa xong';
  }
}
