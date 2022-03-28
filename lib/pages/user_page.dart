import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app/modules/add_photo.dart';
import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/modules/user_story.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/pages/edit_profile.dart';
import 'package:facebook_app/pages/page_add_post.dart';
import 'package:facebook_app/pages/page_add_story.dart';
import 'package:facebook_app/ui/chats/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  UserStory userStory;
  bool isPressed;
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(builder: (context, provider, x) {
      int index = provider.storyList
          .indexWhere((element) => element.id == provider.loggedUser.id);
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Image.asset(
                          'assets/img/add1.png',
                          height: 70.h,
                          width: 70.w,
                        ),
                        onTap: () {
                          RouterClass.routerClass
                              .pushToSpecificScreenUsingWidget(PageAddPhoto());
                        },
                      ),
                      Spacer(),
                      Text(
                        provider.loggedUser.userName == null
                            ? ''
                            : provider.loggedUser.userName,
                        style: TextStyle(
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        child: Image.asset(
                          'assets/img/chat.png',
                          height: 80.h,
                          width: 80.w,
                        ),
                        onTap: () {
                          provider.getUsers();
                          RouterClass.routerClass.pushToSpecificScreenUsingWidget(MainPage());
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    provider.storyList.any(
                            (element) => element.id == provider.loggedUser.id)
                        ? GestureDetector(
                            onTap: () {
                              provider.OpenStoryMethod(userStory, index);
                            },
                            child: CircleAvatar(
                              radius: 120.r,
                              backgroundColor: Colors.deepOrange,
                              child: CircleAvatar(
                                radius: 110.r,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(provider.loggedUser.imgUrl),
                                  radius: 105.r,
                                ),
                              ),
                            ),
                          )
                        : Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundImage: provider.loggedUser.imgUrl ==
                                        null
                                    ? NetworkImage(
                                        'https://images.unsplash.com/photo-1504593811423-6dd665756598?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80')
                                    : NetworkImage(provider.loggedUser.imgUrl),
                                radius: 120.r,
                              ),
                              GestureDetector(
                                child: Image.asset(
                                  'assets/img/add2.png',
                                  height: 55.h,
                                  width: 55.w,
                                ),
                                onTap: () {
                                  RouterClass.routerClass
                                      .pushToSpecificScreenUsingWidget(
                                          PageAddStory());
                                },
                              ),
                            ],
                          ),
                    Spacer(),
                    Column(
                      children: [
                        provider.addPhotoToProfile.length == null
                            ? Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 45.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              )
                            : Text(
                                provider.addPhotoToProfile.length.toString(),
                                style: TextStyle(
                                  fontSize: 45.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Posts',
                          style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          '8',
                          style: TextStyle(
                            fontSize: 45.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Followers',
                          style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          '8',
                          style: TextStyle(
                            fontSize: 45.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Following',
                          style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Visibility(
                  visible: (provider.loggedUser.name != ''),
                  child: Text(
                    provider.loggedUser.name == null
                        ? ''
                        : provider.loggedUser.name,
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Visibility(
                  visible: (provider.loggedUser.pronouns != ''),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        provider.loggedUser.pronouns == null
                            ? ''
                            : provider.loggedUser.pronouns,
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: (provider.loggedUser.bio != ''),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        provider.loggedUser.bio == null
                            ? ''
                            : provider.loggedUser.bio,
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: (provider.loggedUser.webSite != ''),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        provider.loggedUser.webSite == null
                            ? ''
                            : provider.loggedUser.webSite,
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 100.h,
                        color: Colors.grey[600].withOpacity(0.4),
                        child: TextButton(
                          onPressed: () {
                            RouterClass.routerClass
                                .pushToSpecificScreenUsingWidget(EditProfile());
                          },
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 100.h,
                      color: Colors.grey[600].withOpacity(0.4),
                      child: TextButton(
                        onPressed: () {
                          print(provider.favPostsList.toString());
                        },
                        child: Icon(
                          Icons.person_add_alt,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Spacer(),
                    Icon(Icons.image_outlined),
                    Spacer(),
                    Icon(Icons.slow_motion_video_outlined),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
                Expanded(
                    child: provider.addPhotoToProfile.length == 0
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.only(top: 0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 1,
                                    crossAxisSpacing: 7.5.w),
                            itemCount: provider.addPhotoToProfile.length,
                            itemBuilder: (context, index) {
                              AddPhoto addPhoto =
                                  provider.addPhotoToProfile[index];
                              return Container(
                                height: 340.h,
                                width: 340.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.white),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: addPhoto.newPhoto,
                                      height: 335.h,
                                      width: 340.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
              ],
            ),
          ),
        ),
      );
    });
  }
}
