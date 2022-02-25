import 'package:cloud_firestore/cloud_firestore.dart';

class UserStory {
  String id;
  String imgUser;
  List<dynamic> imgStory;
  String userName;
  UserStory({this.imgStory,this.imgUser,this.userName,this.id});
  UserStory.fromMap(Map map) {
    this.imgUser = map['imgUser'];
    this.userName = map['userName'];
    this.imgStory = map ['imgStory'];
    this.id = map ['id'];
  }
  toMap() {
    return {
      'id': this.id,
      'imgUser': this.imgUser,
      'userName': this.userName,
      'imgStory' : this.imgStory,
    };
  }

}