import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/modules/comments.dart';


class AddPhoto {
  String id;
  String comment;
  String newPhoto;
  String city;
  File xNewPhoto;
  String imgUser;
  String nameUser;
  List<dynamic> Likes = ['1'];
  List<dynamic> Saves = ['1'];


  AddPhoto({
    this.id,
    this.newPhoto,
    this.xNewPhoto,
    this.comment,
    this.city,
    this.imgUser,
    this.nameUser,
    this.Likes,
    this.Saves,
  });
  AddPhoto.fromMap(Map map) {
    this.id = map['id'];
    this.comment = map['comment'];
    this.newPhoto = map['newPhoto'];
    this.city = map['city'];
    this.imgUser = map['imgUser'];
    this.nameUser = map['nameUser'];
    this.Likes = map ['Likes'];
    this.Saves = map ['Saves'];

  }
  toMap() {
    return {
      'id': this.id,
      'newPhoto': this.newPhoto,
      'city': this.city,
      'comment': this.comment,
      'nameUser': this.nameUser,
      'imgUser': this.imgUser,
      'Likes' :  FieldValue.arrayUnion(['0']),
      'Saves' :  FieldValue.arrayUnion(['0']),

    };
  }


}



