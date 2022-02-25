

import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/pages/register.dart';
import 'package:facebook_app/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String nullValidator(String value) {
    if (value.isEmpty) {
      return 'Required Field';
    }
    return null;
  }
  loginVal() {
    bool isSuccess = loginKey.currentState.validate();
    if (isSuccess) {
      loginKey.currentState.save();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provide , x) {
        return Scaffold(
          body: Form(
            key: loginKey ,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.deepOrange,
                        Colors.orangeAccent,
                      ],
                    )),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text ('Whisper',
                        style: GoogleFonts.pacifico(
                           textStyle: TextStyle(
                             color: Colors.white ,
                             fontSize: 125.sp ,
                           ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        height: 200.h,
                        width: 900.w,
                        child: TextFormField(
                          validator: nullValidator,
                          controller: emailController,
                          decoration: InputDecoration(
                              hoverColor: Colors.deepOrange,
                              focusColor: Colors.deepOrange,
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.3),
                              hintText: 'User Name or Email',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        height: 200.h,
                        width: 900.w,
                        child: TextFormField(
                          validator: nullValidator,
                          controller: passwordController,
                          decoration: InputDecoration(

                            hoverColor: Colors.deepOrange,
                            focusColor: Colors.deepOrange,
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.3),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                                width: 2.0,
                              ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        height: 160.h,
                        width: 900.w,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.deepOrange),
                            ),
                            onPressed: () {

                              provide.login(emailController.text,passwordController.text);
                              RouterClass.routerClass.pushToSpecificScreenUsingWidget(SplashScreen());
                              loginVal();

                            },
                            child: Text('Login')),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        height: 400.h,
                        width: 900.w,
                        child: Column(
                          children: [
                            TextButton(onPressed: (){
                              RouterClass.routerClass.pushToSpecificScreenUsingWidget(Register());
                            },
                                child: Text('You don\'t have account',
                                style: TextStyle(
                                  color: Colors.white,
                                ),),),
                            TextButton(onPressed: (){
                              Provider.of<MyProvider>(context).forgetPassword(emailController.text);
                            },
                              child: Text('Forget password',
                                style: TextStyle(
                                  color: Colors.white,
                                ),),),
                          ],
                        )),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
