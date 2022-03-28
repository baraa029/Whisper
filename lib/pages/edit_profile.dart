import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/pages/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {


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
                      'Edit profile',
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
                          provider.editUser(userId);
                          RouterClass.routerClass.popFunction();
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
                GestureDetector(
                  onTap: () {
                    provider.pickNewImage();
                  },
                  child: provider.loggedUser.imgUrl == null
                      ? CircleAvatar(
                          radius: 150.r,
                        )
                      : CircleAvatar(
                          radius: 150.r,
                          backgroundImage: NetworkImage(provider.loggedUser.imgUrl)),
                ),
                SizedBox(
                  height: 25.h,
                ),
                TextButton(
                    onPressed: () {
                      provider.pickNewImage();
                    },
                    child: Text(
                      'Change profile photo',
                      style: TextStyle(
                        fontSize: 43.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    )),
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
                          'Name',
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 75.h,
                        ),
                        Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 75.h,
                        ),
                        Text(
                          'Pronouns',
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 75.h,
                        ),
                        Text(
                          'Website',
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 75.h,
                        ),
                        Text(
                          'Bio',
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
                            controller: provider.nameController,
                            decoration: InputDecoration(
                              hintText: 'Name',
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
                            controller: provider.userNameController,
                            decoration: InputDecoration(
                              hintText: 'Username',
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
                            controller:provider.pronounsController,
                            decoration: InputDecoration(
                              hintText: 'Pronouns',
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
                            controller: provider.websiteController,
                            decoration: InputDecoration(
                              hintText: 'Website',
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
                            controller: provider.bioController,
                            decoration: InputDecoration(
                              hintText: 'Bio',
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
