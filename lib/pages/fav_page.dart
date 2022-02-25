import 'package:facebook_app/modules/user_post.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/widget/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget{
  UserPost userPost;
  FavoritePage({this.userPost});
  @override
  Widget build(BuildContext context) {
   return Consumer<MyProvider>(
     builder: (context, provider, x) {
       return   Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.white,

           title: Center(
             child: Row(
               children: [
                 Text('My Favorite',
                   style: TextStyle(
                     color: Colors.deepOrange,
                     fontSize: 80.sp ,
                     fontWeight: FontWeight.w900 ,
                   ),
                 ),
               ],
             ),
           ),
         ),
         body: provider.favPostsList.length == 0 ?  Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [

               Lottie.asset('assets/animations/emptylike.json',
               width: 650.w ,
               height: 650.h,
               ),
               Text('No post liked yet',
               style: TextStyle(fontSize: 70.sp,
               color: Colors.grey[500] ,
               ),
               ),
             ],
           ),
         )  :  Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16.0),
           child: Column(
             children: [
               Flexible(
                 child: ListView.separated(
                     padding: EdgeInsets.symmetric(vertical: 8.0),
                     itemBuilder: (context, index){
                       return PostWidget(provider.favPostsList[index]) ;
                     },
                     separatorBuilder: (context , index)=> SizedBox(height: 50.h,),
                     itemCount: provider.favPostsList.length
                 ),
               ),
             ],
           ),
         ),
       );
       },
   ) ;
  }

}