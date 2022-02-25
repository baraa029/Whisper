import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/widget/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UiPost extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
        builder: (context,provider,x){
          return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              itemBuilder: (context, index){
                return PostWidget(provider.addPhotoToHome[index]) ;
              },
              separatorBuilder: (context , index)=> SizedBox(height: 50.h,),
              itemCount: provider.addPhotoToHome.length
          );
        }
    ) ;
  }

}