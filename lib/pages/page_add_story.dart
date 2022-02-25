import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/modules/user_story.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PageAddStory extends StatelessWidget {
  UserStory userStory;
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
                              .pushToSpecificScreenUsingWidget(MainScreen());
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
                      'Add Story',
                      style: TextStyle(
                        fontSize: 60.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                         provider.storyList.any((element) => element.id == provider.loggedUser.id) ?
                          provider.AddNewPhotoToStory() : provider.AddStory() ;
                          provider.GetStory();
                          print( provider.storyList.contains(provider.loggedUser.id));
                           print(provider.userStory);

                          RouterClass.routerClass
                              .pushToSpecificScreenUsingWidget(MainScreen());
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
                          provider.AddImageStory();
                        },
                        child: Text(
                          'Add Story',
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
                        provider.AddImageStory();
                      },
                      child: provider.Story == null
                          ? Container(
                              child:
                                  Center(child: Icon(Icons.add_box_outlined)),
                            )
                          : Container(
                              height: 600.h,
                              width: 600.w,
                              child: Image.file(provider.Story),
                            ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: Colors.grey[400],
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
