import 'package:facebook_app/modules/new_user.dart';
import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/pages/login.dart';
import 'package:facebook_app/pages/main_screen.dart';
import 'package:facebook_app/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  String nullValidator(String value) {
    if (value.isEmpty) {
      return 'Required Field';
    }
    return null;
  }

  RegisterVal() {
    registerKey.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: registerKey,
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Whisper',
                      style: GoogleFonts.pacifico(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 125.sp,
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
                        controller: userNameController,
                        decoration: InputDecoration(
                          hoverColor: Colors.pink,
                          focusColor: Colors.pink,
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                          hintText: 'User Name',
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
                        controller: emailController,
                        decoration: InputDecoration(
                          hoverColor: Colors.pink,
                          focusColor: Colors.pink,
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                          hintText: 'Email address',
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
                          hoverColor: Colors.pink,
                          focusColor: Colors.pink,
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                          hintText: 'Password',
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
                        controller: mobileNumberController,
                        decoration: InputDecoration(
                          hoverColor: Colors.deepOrange,
                          focusColor: Colors.amberAccent,
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                          hintText: 'Phone number',
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
                      height: 160.h,
                      width: 900.w,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepOrange),
                          ),
                          onPressed: () {
                            NewUser newUser = NewUser(
                                email: emailController.text,
                                password: passwordController.text,
                                userName: userNameController.text,
                                mobile: mobileNumberController.text
                            ) ;
                            Provider.of<MyProvider>(context, listen: false)
                                .createUser(newUser);
                            RouterClass.routerClass.pushToSpecificScreenUsingWidget(Login());

                            RegisterVal();
                          },
                          child: Text('Sing Up')),
                    ),
                    TextButton(onPressed: (){
                      RouterClass.routerClass.pushToSpecificScreenUsingWidget(Login());
                    },
                      child: Text('I have already an account',
                        style: TextStyle(
                          color: Colors.white,
                        ),),),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
