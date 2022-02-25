import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/modules/user_story.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class OpenStory extends StatelessWidget {
  UserStory userStory;
  int index ;
  OpenStory(this.userStory, this.index);
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider ,x ) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Swiper(
                    loop: false,
                    itemCount: provider.storyList[index].imgStory.length,
                    layout: SwiperLayout.DEFAULT,
                    pagination: SwiperPagination(
                      builder: SwiperPagination.dots,
                    ),
                    itemBuilder: (BuildContext context, int x) {
                    return Image.network(
                      provider.storyList[index].imgStory[x],
                      fit: BoxFit.cover,
                    );
                  }

                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(provider.storyList[index].imgUser),
                          radius: 70.r,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Stack(
                          children: [
                            Text(
                              provider.storyList[index].userName,
                              style: TextStyle(
                                fontSize: 45.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.deepOrange,
                              ),
                            ),
                            Text(
                              provider.storyList[index].userName,
                              style: TextStyle(
                                fontSize: 45.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                              RouterClass.routerClass.popFunction();
                            },
                            child: Image.asset('assets/img/cancel.png',
                            height: 80.h,
                              width: 80.w,
                            )),
                        SizedBox(width: 20.w,)
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 175.h,
                          width: 720.w,
                          child: TextFormField(
                            scrollController: ScrollController(),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black.withOpacity(0.5),
                                hintText: 'Send message',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(75.r))),
                          ),
                        ),
                        SizedBox(width: 60.w,),
                        Container(
                          height: 175.h,
                          width: 175.w,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius:BorderRadius.circular(75.r) ,
                          ),
                          child: Icon(Icons.send,
                          color: Colors.white,) ,
                        ),
                      ],
                    ),
                  ),
                ],
              ),


            ],
          ),
        );
      }
    );
  }
}
