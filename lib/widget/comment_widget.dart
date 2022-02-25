import 'package:facebook_app/modules/add_photo.dart';
import 'package:facebook_app/modules/comments.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CommentWidget extends StatelessWidget{
  AddPhoto addPhoto;
  int index;
  CommentWidget(this.addPhoto,this.index);
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context , provider , x) {
        return Column(
          children: [
            SizedBox(height: 40.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    provider.commentsList[index].imgUser,
                  ),
                  radius: 70.r,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 820.w,
                          child: Text(
                            '${provider.commentsList[index].name} ${provider.commentsList[index].comment}  ',
                            style: TextStyle(
                              fontSize: 38.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Text(
                         provider.commentsList[index].time,
                          style: TextStyle(
                            fontSize: 33.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(
                          width: 25.w,
                        ),
                        Text(
                          'See Translation',
                          style: TextStyle(
                            fontSize: 33.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),
            SizedBox(height: 40.h,),
          ],
        );
      }
    ) ;
  }

}