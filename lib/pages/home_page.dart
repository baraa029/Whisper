import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/pages/page_add_story.dart';
import 'package:facebook_app/ui/ui_post.dart';
import 'package:facebook_app/ui/ui_story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(builder: (context, provider, x) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
          
              Row(
                children: [
                  GestureDetector(
                    child: Image.asset('assets/img/add.png',
                    height: 80.h,
                      width: 80.w,
                    ),
                    onTap: (){  RouterClass.routerClass
                        .pushToSpecificScreenUsingWidget(PageAddStory());},
                  ),

                  Spacer(),
                  Text(
                    'Whisper',
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(

                        color: Colors.deepOrange,
                        fontSize: 100.sp,
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    child: Image.asset('assets/img/logout.png',
                      height: 80.h,
                      width: 80.w,
                    ),
                    onTap: (){ Provider.of<MyProvider>(context, listen: false).logOut();
                    Provider.of<MyProvider>(context, listen: false)
                        .addPhotoToProfile = [];
                    Provider.of<MyProvider>(context, listen: false)
                        .addPhotoToHome = [];
                    Provider.of<MyProvider>(context, listen: false)
                        .favPostsList = []; },
                  ),

                ],
              ),
              Container(
                height: 350.h,
                child: UiStory(),
              ),
              Flexible(
                child: UiPost(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
