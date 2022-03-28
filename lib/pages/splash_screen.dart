import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/pages/main_screen.dart';
import 'package:facebook_app/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    Future.delayed(Duration(seconds: 20)).then((v) {
      if (user == null) {
        RouterClass.routerClass.pushWithReplacementToSpecificScreenUsingWidget(Register());
      } else {
        String userId = user.uid;
        Provider.of<MyProvider>(context, listen: false)
            .getUserFromFirebase(userId);
        Provider.of<MyProvider>(context, listen: false)
            .GetPhotoToProfile(userId);
        Provider.of<MyProvider>(context, listen: false).GetPhotoToHome(userId);
        Provider.of<MyProvider>(context, listen: false).GetFavPost(userId);
        Provider.of<MyProvider>(context, listen: false).GetSavePost(userId);
        Provider.of<MyProvider>(context, listen: false).GetStory();
        Provider.of<MyProvider>(context, listen: false).getUsers();
        Provider.of<MyProvider>(context, listen: false).getChats();


        RouterClass.routerClass.pushWithReplacementToSpecificScreenUsingWidget(MainScreen());
      }
    });
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                child: Image.asset(
                  'assets/img/bg.jpg',
                  fit: BoxFit.fill,
                  height: double.infinity,
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/w.png',
                  height: 350.h,
                  width: 350.w,
                ),
                Text(
                  'Whisper',
                  style: GoogleFonts.pacifico(
                    textStyle: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 20.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(
                          blurRadius: 20.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                      color: Colors.deepOrange,
                      fontSize: 150.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
