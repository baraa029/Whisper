import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/pages/main_screen.dart';
import 'package:facebook_app/pages/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PageAddPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(builder: (context, provider, x) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 70.h,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          RouterClass.routerClass
                              .popFunction();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        )),
                    Spacer(),
                    Text(
                      'Add New Post',
                      style: TextStyle(
                        fontSize: 60.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          User user = FirebaseAuth.instance.currentUser;
                          String userId = user.uid;
                          provider.AddPhotoToProfile(userId);
                          RouterClass.routerClass.pushToSpecificScreenUsingWidget(MainScreen());
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        )),
                  ],
                ),
                Container(
                  height: 1,
                  color: Colors.grey[400],
                ),
                SizedBox(
                  height: 60.h,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          provider.pickAddImage();
                        },
                        child: Text(
                          'Add Photo',
                          style: TextStyle(
                            fontSize: 43.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        )),
                    SizedBox(
                      width: 25.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        provider.pickAddImage();
                      },
                      child: provider.addPhoto == null
                          ? Container(
                            child:
                                Center(child: Icon(Icons.add_box_outlined)),
                          )
                          : Container(
                             height:400.h ,
                              width: 400.w,
                              child: Image.file(provider.addPhoto),
                            ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: Colors.grey[400],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 75.h,
                        ),
                        Text(
                          'Add caption',
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 75.h,
                        ),
                        Text(
                          'Add location',
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        SizedBox(
                          height: 75.h,
                        ),
                        Container(
                          height: 150.h,
                          width: 650.w,
                          child: TextFormField(
                            controller: provider.caption,
                            decoration: InputDecoration(
                              hintText: 'Write caption',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 50.sp,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[400],
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 150.h,
                          width: 650.w,
                          child: TextFormField(
                            controller: provider.city,
                            decoration: InputDecoration(
                              hintText: 'City,Street',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 50.sp,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[400],
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Lottie.asset(
                  'assets/animations/story.json',
                  width: 750.w,
                  height: 750.h,
                ),

              ],
            ),
          ),
        ),
      );
    });
  }
}
