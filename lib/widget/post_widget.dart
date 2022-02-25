import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/Auth/fire_store.dart';
import 'package:facebook_app/modules/add_photo.dart';
import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/pages/comment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatelessWidget {
  AddPhoto addPhoto;
  bool isLike = false;
  PostWidget(this.addPhoto);
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(builder: (context, provider, x) {
      return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(addPhoto.imgUser),
                    radius: 70.r,
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        addPhoto.nameUser,
                        style: TextStyle(
                          fontSize: 43.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        addPhoto.city,
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.more_horiz),
                ],
              ),
              SizedBox(
                height: 30.w,
              ),
              GestureDetector(
                onDoubleTap: () {
                  provider.changeLike(addPhoto);
                  provider.isLike
                      ? provider.PressLike(
                          addPhoto,
                        )
                      : provider.PressDisLike(addPhoto);
                  log(provider.isLike.toString());
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 850.w,
                      height: 850.h,
                      child: Image.network(
                        addPhoto.newPhoto,
                        fit: BoxFit.cover,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      child: provider.isLike ? provider.x : null,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.w,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        provider.changeLike(addPhoto);
                        provider.isLike
                            ? provider.PressLike(
                                addPhoto,
                              )
                            : provider.PressDisLike(addPhoto);
                        provider.GetFavPost(provider.loggedUser.id);
                        provider.GetSavePost(provider.loggedUser.id);
                        provider.GetPhotoToHome(provider.loggedUser.id);
                      },
                      icon: Icon(
                        Icons.favorite,
                        size: 30,
                        color: (addPhoto.Likes.contains(
                                    provider.loggedUser.id) ==
                                null)
                            ? Colors.grey
                            : addPhoto.Likes.contains(provider.loggedUser.id)
                                ? Colors.red
                                : Colors.grey[500],
                      )),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    ' ${addPhoto.Likes.length - 1}'.toString(),
                    style: TextStyle(
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        provider.GetComments(addPhoto);
                        RouterClass.routerClass.pushToSpecificScreenUsingWidget(CommentPage(addPhoto));
                      },
                      icon: Icon(
                        Icons.messenger_outline,
                        color: Colors.grey[500],
                      )),
                  SizedBox(
                    width: 5.w,
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send,
                        color: Colors.grey[500],
                      )),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        provider.changeSave(addPhoto);
                        provider.isSave
                            ? provider.PressSave(
                                addPhoto,
                              )
                            : provider.PressUnSave(addPhoto);
                        provider.GetPhotoToHome(provider.loggedUser.id);
                        provider.GetSavePost(provider.loggedUser.id);
                        provider.GetFavPost(provider.loggedUser.id);
                      },
                      icon: Icon(
                        Icons.bookmark,
                        color: (addPhoto.Saves.contains(
                                    provider.loggedUser.id) ==
                                null)
                            ? Colors.grey
                            : addPhoto.Saves.contains(provider.loggedUser.id)
                                ? Colors.blueAccent
                                : Colors.grey[500],
                      )),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(
                    '${addPhoto.nameUser}: ',
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    width: 300.w,
                    child: Text(
                      addPhoto.comment,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 37.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    width: 130.w,
                    height: 70.h,
                    child: Text(
                      ' More ',
                      style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
