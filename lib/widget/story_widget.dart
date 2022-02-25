import 'package:facebook_app/modules/user_story.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StoryWidget extends StatelessWidget{
  bool isPressed = true;
  UserStory userStory;
  int index ;
  StoryWidget(this.userStory, this.index);
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, x) {
        return
        Column(
          children: [
            GestureDetector(
              onTap: (){
                provider.OpenStoryMethod(userStory,index);
                this.isPressed = false;
              },
              child: CircleAvatar(
                radius: 105.r,
                backgroundColor: isPressed ? Colors.deepOrange : Colors.grey ,
                child: CircleAvatar(
                  radius: 95.r,
                  backgroundColor: Colors.white ,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(provider.storyList[index].imgUser),
                    radius: 90.r,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              alignment: Alignment.center,
              width: 200.w,
              child: Text(provider.storyList[index].userName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 37.sp,
                fontWeight:FontWeight.w700,
              ),
              ),
            ),
          ],
        );
      }
    ) ;
  }

}