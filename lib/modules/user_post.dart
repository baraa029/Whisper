import 'package:facebook_app/modules/comments.dart';

class UserPost {
  String userName;
  String city;
  String state;
  String imgUser;
  List<String> imgPost;
  int likes;
  int comment;
  bool isLike;
  bool isSaved;
  List<Comments> userList = [Comments(name: '', comment: '', imgUser: '')];
  UserPost({
    this.userName,
    this.imgUser,
    this.city,
    this.comment,
    this.imgPost,
    this.likes,
    this.state,
    this.isLike = false,
    this.isSaved = false,
    this.userList,
  });

}
