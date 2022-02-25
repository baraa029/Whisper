import 'package:facebook_app/modules/add_photo.dart';
import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/widget/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatelessWidget {

  AddPhoto addPhoto;
  CommentPage(this.addPhoto);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MyProvider>(builder: (context, provider, x) {
        return Padding(
          padding: const EdgeInsets.only(
              top: 16.0, left: 16.0, right: 16, bottom: 5),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        RouterClass.routerClass.popFunction();
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    Spacer(),
                    Text(
                      'Comments',
                      style: TextStyle(
                        fontSize: 70.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        addPhoto.imgUser,
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
                                '${addPhoto.nameUser}  ${addPhoto.comment}',
                                style: TextStyle(
                                  fontSize: 42.sp,
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
                              '1d',
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
                SizedBox(  height: 20.h,),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 0),
                      itemBuilder: (context, index) {
                        return CommentWidget(addPhoto,index);
                      },
                      separatorBuilder: (context, index) => Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey,
                          ),
                      itemCount: provider.commentsList.length,
                         ),
                ),

                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            provider.loggedUser.imgUrl),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        height: 140.h,
                        width: 820.w,
                        alignment: Alignment.center,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: provider.commentControl,
                          scrollController: ScrollController(),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.5),
                              hintText: 'Add a comment...',
                              suffix: TextButton(
                                  onPressed: () {
                                  provider.PressComment(addPhoto);
                                  provider.commentControl.clear();
                                  },
                                  child: Text(
                                    'Post',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(75.r))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
