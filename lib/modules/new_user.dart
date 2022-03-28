import 'dart:io';

import 'package:flutter/material.dart';

class NewUser {
  String id;
  String userName;
  String name;
  String pronouns;
  String webSite;
  String bio;
  String email;
  String password;
  String mobile;
  String imgUrl;
  File imgUpload;
  List <String> photoList;
  List <File> xPhotoList;


  NewUser({
    @required this.email,
    @required this.password,
    this.id,
    @required this.userName,
    @required this.mobile,
    this.imgUrl,
    this.imgUpload,
    this.name,
    this.bio,
    this.pronouns,
    this.webSite,

  });
  NewUser.fromMap(Map map) {
    this.id = map['id'];
    this.password = map['password'];
    this.email = map['email'];
    this.mobile = map['mobile'];
    this.userName = map['userName'];
    this.imgUrl = map['imgUrl'];
    this.name = map['name'];
    this.bio = map['bio'];
    this.pronouns = map['pronouns'];
    this.webSite = map['webSite'];

  }
  toMap() {
    return {
      'userName': this.userName,
      'email': this.email,
      'password': this.password,
      'mobile': this.mobile,
      'imgUrl': this.imgUrl,
      'name': this.name,
      'bio': this.bio,
      'pronouns': this.pronouns,
      'webSite': this.webSite,
      'id' : this.id,
    };
  }
}
