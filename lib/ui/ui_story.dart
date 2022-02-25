import 'package:facebook_app/modules/user_story.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/widget/story_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UiStory extends StatelessWidget {
  UserStory userStory;
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(builder: (context, provider, x) {
      return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8.0),
          itemBuilder: (context,index){
            return StoryWidget(userStory, index);
          },
          separatorBuilder: (context,index)=> SizedBox(width: 30.w,),
          itemCount: provider.storyList.length ,
        scrollDirection: Axis.horizontal,
      );
    });
  }
}
