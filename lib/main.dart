import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/pages/edit_profile.dart';
import 'package:facebook_app/pages/login.dart';
import 'package:facebook_app/pages/page_add_post.dart';
import 'package:facebook_app/pages/splash_screen.dart';
import 'package:facebook_app/pages/user_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,

  ));
  runApp( ScreenUtilInit(
    designSize: Size(1080, 2280),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: () => MultiProvider(
      providers: [
        ChangeNotifierProvider<MyProvider>(
          create: (context){
            return MyProvider();
          },
        ),
      ],
      child: MaterialApp(
        navigatorKey: RouterClass.routerClass.navKey,
        debugShowCheckedModeBanner: false,
        home:SplashScreen(),
      ),
    ),
  ));
}


