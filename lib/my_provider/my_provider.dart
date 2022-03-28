import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/Auth/auth_helper.dart';
import 'package:facebook_app/Auth/fire_store.dart';
import 'package:facebook_app/modules/add_photo.dart';
import 'package:facebook_app/modules/chat.dart';
import 'package:facebook_app/modules/comments.dart';
import 'package:facebook_app/modules/message.dart';
import 'package:facebook_app/modules/new_user.dart';
import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/modules/user_story.dart';
import 'package:facebook_app/pages/fav_page.dart';
import 'package:facebook_app/pages/home_page.dart';
import 'package:facebook_app/pages/login.dart';
import 'package:facebook_app/pages/main_screen.dart';
import 'package:facebook_app/pages/open_story.dart';
import 'package:facebook_app/pages/save_page.dart';
import 'package:facebook_app/pages/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';

class MyProvider extends ChangeNotifier {
  NewUser loggedUser;
  File file;
  File addPhoto;
  File Story;
  String StoryX;
  String addPhotoX;
  List<AddPhoto> addPhotoToProfile = [];
  List<UserStory> storyList = [];
  List<AddPhoto> addPhotoToHome = [];
  List<AddPhoto> favPostsList = [];
  List<AddPhoto> savePostsList = [];
  List<Comments> commentsList = [];
  List<String> userStory = [];
  String imgUrl;
  AddPhoto newPost;
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController pronounsController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController caption = TextEditingController();
  TextEditingController city = TextEditingController();


  //////////////Auth and firebase /////////////

  createUser(NewUser newUser) async {
    try {
      String userId =
          await AuthHelper.authHelper.Register(newUser.email, newUser.password);
      newUser.id = userId;
      await FireStore.fireStore.createNewUser(newUser);
      this.loggedUser = newUser;
      await getUserFromFirebase(userId);
      if (userId != null) {
        RouterClass.routerClass.pushToSpecificScreenUsingWidget(MainScreen());
        // navigate to home
      } else {
        log('error occured');
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  login(String email, String password) async {
    try {
      UserCredential userCredential =
          await AuthHelper.authHelper.Login(email, password);
      String userId = userCredential.user.uid;
      log(userId.toString());
      await getUserFromFirebase(userId);
      RouterClass.routerClass.pushToSpecificScreenUsingWidget(MainScreen());
    } on Exception catch (e) {
      // TODO
    }
  }

  logOut() async {
    this.loggedUser = null;
    await AuthHelper.authHelper.logout();
    RouterClass.routerClass.pushToSpecificScreenUsingWidget(Login());
  }

  forgetPassword(String email) async {
    AuthHelper.authHelper.forgetPassword(email);
  }

  getUserFromFirebase(String userId) async {
    this.loggedUser = await FireStore.fireStore.getUserFromFs(userId);
    notifyListeners();
  }
  getUsers() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> queries =
    await FireStore.fireStore.getUsersFromFirestore();
    List<NewUser> userList =
    queries.map((e) => NewUser.fromMap(e.data())).toList();
    String myId = FirebaseAuth.instance.currentUser.uid;

    userList.where((element) => element.id == myId).first;
    userList.removeWhere((element) => element.id == myId);
    this.users = userList;
    notifyListeners();
  }

  /////////////////////// edit profile
  pickNewImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(file.path);
    loggedUser.imgUrl = await FireStore.fireStore.uploadImage(this.file);
    notifyListeners();
  }

  editUser(String userId) async {
    log(userId ?? 'null');
    if (file != null) {
      this.imgUrl = await FireStore.fireStore.uploadImage(this.file);
      getUserFromFirebase(userId);
    }
    NewUser newUser = NewUser(
      imgUrl: loggedUser.imgUrl,
      email: loggedUser.email,
      password: loggedUser.password,
      mobile: loggedUser.mobile,
      id: userId,
      name: nameController.text,
      userName: loggedUser.userName,
      pronouns: pronounsController.text,
      webSite: websiteController.text,
      bio: bioController.text,
    );
    newUser.imgUrl = imgUrl;
    this.loggedUser = newUser;
    await FireStore.fireStore.editUser(newUser);
    RouterClass.routerClass.popFunction();
    notifyListeners();
  }

  //////////////////// add and get post

  pickAddImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.addPhoto = File(file.path);
    notifyListeners();
  }

  AddPhotoToProfile(String userId) async {
    DateTime time = DateTime.now();
    if (addPhoto != null) {
      this.addPhotoX = await FireStore.fireStore.uploadPostImage(this.addPhoto);
      AddPhoto addPhoto = AddPhoto(
        id: loggedUser.id + '^$time',
        comment: this.caption.text,
        newPhoto: this.addPhotoX,
        city: this.city.text,
        imgUser: loggedUser.imgUrl,
        nameUser: loggedUser.userName,
      );
      GetPhotoToProfile(userId);
      GetPhotoToHome(userId);
      FireStore.fireStore.enterPhotoUser(addPhoto);
      notifyListeners();
    }
  }

  GetPhotoToProfile(String userId) async {
    List<AddPhoto> listPosts = await FireStore.fireStore.getAllPosts();
    this.addPhotoToProfile = listPosts
        .where((element) => element.id.split('^').first == userId)
        .toList();
    notifyListeners();
  }

  GetPhotoToHome(String userId) async {
    List<AddPhoto> listPosts = await FireStore.fireStore.getAllPosts();
    this.addPhotoToHome = listPosts
        .where((element) => element.id.split('^').first != userId)
        .toList();
    notifyListeners();
  }

  /////////////////////////// fav post
  GetFavPost(String userId) async {
    this.favPostsList = await FireStore.fireStore.getFavPosts(userId);
    notifyListeners();
  }

  Widget x;

  ShowBigLike(AddPhoto addPhoto) {
    Timer(Duration(milliseconds: 1200), () {
      this.x = null;
      notifyListeners();
    });
    return x = Lottie.asset('assets/animations/love.json');
  }

  bool isLike = false;
  changeLike(AddPhoto addPhoto) {
    this.isLike = !addPhoto.Likes.contains(loggedUser.id);
    notifyListeners();
  }

  PressLike(AddPhoto addPhoto) {
    FireStore.fireStore.addPostToFav(addPhoto, loggedUser.id);
    FireStore.fireStore.addPeopleLike(addPhoto, loggedUser.id);
    GetFavPost(loggedUser.id);
    this.isLike ? ShowBigLike(addPhoto) : null;
    notifyListeners();
  }

  PressDisLike(
    AddPhoto addPhoto,
  ) {
    FireStore.fireStore.removePostFromFav(addPhoto, loggedUser.id);
    FireStore.fireStore.deletePeopleDisLike(addPhoto, loggedUser.id);
    GetFavPost(loggedUser.id);
    this.isLike ? ShowBigLike(addPhoto) : null;
    notifyListeners();
  }

  /////////////////////////save post

  GetSavePost(String userId) async {
    this.savePostsList = await FireStore.fireStore.getSavePosts(userId);
    notifyListeners();
  }

  bool isSave = false;
  changeSave(AddPhoto addPhoto) {
    this.isSave = !addPhoto.Saves.contains(loggedUser.id);
    notifyListeners();
  }

  PressSave(AddPhoto addPhoto) {
    FireStore.fireStore.addPostToSave(addPhoto, loggedUser.id);
    FireStore.fireStore.addPeopleSave(addPhoto, loggedUser.id);
    GetSavePost(loggedUser.id);
    changeSave(addPhoto);
    notifyListeners();
  }

  PressUnSave(
    AddPhoto addPhoto,
  ) {
    FireStore.fireStore.removePostFromSave(addPhoto, loggedUser.id);
    FireStore.fireStore.deletePeopleUnSave(addPhoto, loggedUser.id);
    GetSavePost(loggedUser.id);
    changeSave(addPhoto);
    notifyListeners();
  }

  /////////////////////////// comment
  TextEditingController commentControl = TextEditingController();
  PressComment(
    AddPhoto addPhoto,
  ) {
    String date = DateFormat("yy-MM-dd hh:mm").format(DateTime.now());
    DateTime time = DateTime.now();
    Comments comments = Comments(
      id: loggedUser.id + '^$time',
      name: loggedUser.userName,
      imgUser: loggedUser.imgUrl,
      comment: this.commentControl.text,
      time: date,
    );
    FireStore.fireStore.addComments(addPhoto, comments);
    GetComments(addPhoto);
    notifyListeners();
  }

  GetComments(AddPhoto addPhoto) async {
    this.commentsList = await FireStore.fireStore.getComments(addPhoto);
    notifyListeners();
  }

  //////////////Story/////////////////

  AddImageStory() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.Story = File(file.path);
    notifyListeners();
  }

  AddStory() async {

    if (Story != null) {
      this.StoryX = await FireStore.fireStore.uploadPostImage(this.Story);
      UserStory userStory = UserStory(
        id: loggedUser.id ,
        imgStory:[this.StoryX],
        imgUser: loggedUser.imgUrl,
        userName: loggedUser.userName,
      );
      GetStory();
      FireStore.fireStore.AddStory(userStory);
      notifyListeners();
    }
  }

  GetStory() async {
    this.storyList = await FireStore.fireStore.getStory();
    notifyListeners();
  }

  AddNewPhotoToStory() async {
    if (Story != null) {
      this.StoryX = await FireStore.fireStore.uploadPostImage(this.Story);
    }
    FireStore.fireStore.addPhotoToStory(loggedUser.id,this.StoryX);
    GetStory();
    notifyListeners();
  }



  OpenStoryMethod(UserStory userStory, int index) {
    RouterClass.routerClass
        .pushToSpecificScreenUsingWidget(OpenStory(userStory,index));

    notifyListeners();
  }


  /////////////////Bottom nav Bar //////////////////

  int currentIndex = 0;
  List<Widget> screens = [
    HomePage(),
    FavoritePage(),
    SavePage(),
    UserPage(),
  ];

  ChangePage(value) {
    this.currentIndex = value;
    this.screens[value];
    notifyListeners();
  }
////////////////////////////////////////// chat

  List<Chat> allMyChats;
  List<NewUser> users;

  getChats() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> list =
    await FireStore.fireStore.getChats();
    List<Chat> chats = list.map((e) {
      String chatId = e.id;
      Map<String, dynamic> map = e.data();
      map['chatId'] = chatId;
      return Chat.fromJson(map);
    }).toList();
    this.allMyChats = chats;
    notifyListeners();
  }

  sendMessage(Message message, [NewUser otherUser]) async {
    String chatId = message.chatId;
    bool x =
    await FireStore.fireStore.checkCollectionExists(chatId);
    if (otherUser == null) {
      FireStore.fireStore.sendMessage(message);
    } else {
      if (!x) {
        await createChat(chatId, otherUser);
        FireStore.fireStore.sendMessage(message);
      } else {
        FireStore.fireStore.sendMessage(message);
      }
    }
  }

  createChat(String chatId, NewUser otherUser) async {
    FireStore.fireStore.createChat(chatId, this.loggedUser, otherUser);
  }


}
