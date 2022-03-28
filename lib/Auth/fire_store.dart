import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/modules/add_photo.dart';
import 'package:facebook_app/modules/comments.dart';
import 'package:facebook_app/modules/message.dart';
import 'package:facebook_app/modules/new_user.dart';
import 'package:facebook_app/modules/user_story.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStore {
  FireStore._();
  static FireStore fireStore = FireStore._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
////////////////// AUTH
  createNewUser(NewUser newUser) async {
    await firebaseFirestore
        .collection('users')
        .doc(newUser.id)
        .set(newUser.toMap());
  }

  Future<NewUser> getUserFromFs(String id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await firebaseFirestore.collection('users').doc(id).get();
    Map<String, dynamic> userData = document.data();
    userData['id'] = document.id;
    NewUser newUser = NewUser.fromMap(userData);
    return newUser;
  }

  editUser(NewUser newUser) async {
    await firebaseFirestore
        .collection('users')
        .doc(newUser.id)
        .update(newUser.toMap());
  }
/////////////////// upload user img
  Future<String> uploadImage(File file) async {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    Reference reference = firebaseStorage.ref('profiles img/$fileName');
    await reference.putFile(file);
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }
//////////////// upload post img
  Future<String> uploadPostImage(File file) async {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    Reference reference = firebaseStorage.ref('postImage/$fileName');
    await reference.putFile(file);
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }
///////////////// add and get post
  enterPhotoUser(AddPhoto addPhoto) async {
    await firebaseFirestore
        .collection('post')
        .doc(addPhoto.id)
        .set(addPhoto.toMap());
  }

  Future<List<AddPhoto>> getAllPosts() async {
    QuerySnapshot<Map<String, dynamic>> PostsSnapshot =
        await firebaseFirestore.collection('post').get();

    List<AddPhoto> Posts = PostsSnapshot.docs
        .map((e) {
          Map documentMap = e.data();
          documentMap['id'] = e.id;
          AddPhoto addPhoto = AddPhoto.fromMap(documentMap);
          return addPhoto;
        })
        .toList()
        .reversed
        .toList();
    return Posts;
  }

 /////////////////////// fav post
  addPostToFav(AddPhoto addPhoto, String userId) async {
    firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('FavPost')
        .doc(addPhoto.id)
        .set(addPhoto.toMap());
  }
  removePostFromFav(AddPhoto addPhoto, String userId) async {
    firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('FavPost')
        .doc(addPhoto.id)
        .delete();
  }


  Future<List<AddPhoto>> getFavPosts(String userId) async {
    QuerySnapshot<Map<String, dynamic>> FavPostsSnapshot =
    await firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('FavPost')
        .get();

    List<AddPhoto> Posts = FavPostsSnapshot.docs
        .map((e) {
      Map documentMap = e.data();
      documentMap['id'] = e.id;
      AddPhoto addPhoto = AddPhoto.fromMap(documentMap);
      return addPhoto;
    })
        .toList()
        .reversed
        .toList();
    return Posts;
  }



  addPeopleLike(
    AddPhoto addPhoto,
    String userId,
  ) {
    FirebaseFirestore.instance.collection('post').doc(addPhoto.id).update({
      "Likes": FieldValue.arrayUnion([userId])

    });
    FirebaseFirestore.instance.collection('users').doc(userId).collection('FavPost').doc(addPhoto.id).update({
      "Likes": FieldValue.arrayUnion([userId])

    });
FirebaseFirestore.instance.collection('users').doc(userId).collection('SavePost').doc(addPhoto.id).update({
      "Likes": FieldValue.arrayUnion([userId])

    });

  }

  deletePeopleDisLike(
    AddPhoto addPhoto,
    String userId,
  ) {
    FirebaseFirestore.instance.collection('post').doc(addPhoto.id).update({
      "Likes": FieldValue.arrayRemove([userId])
    });
    FirebaseFirestore.instance.collection('users').doc(userId).collection('FavPost').doc(addPhoto.id).update({
      "Likes": FieldValue.arrayRemove([userId])

    });
 FirebaseFirestore.instance.collection('users').doc(userId).collection('SavePost').doc(addPhoto.id).update({
      "Likes": FieldValue.arrayRemove([userId])

    });

  }


  ////////////////////////// save post

  addPostToSave(AddPhoto addPhoto, String userId) async {
    firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('SavePost')
        .doc(addPhoto.id)
        .set(addPhoto.toMap());
  }


  removePostFromSave(AddPhoto addPhoto, String userId) async {
    firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('SavePost')
        .doc(addPhoto.id)
        .delete();
  }
  Future<List<AddPhoto>> getSavePosts(String userId) async {
    QuerySnapshot<Map<String, dynamic>> SavePostsSnapshot =
    await firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('SavePost')
        .get();

    List<AddPhoto> Posts = SavePostsSnapshot.docs
        .map((e) {
      Map documentMap = e.data();
      documentMap['id'] = e.id;
      AddPhoto addPhoto = AddPhoto.fromMap(documentMap);
      return addPhoto;
    })
        .toList()
        .reversed
        .toList();
    return Posts;
  }
  addPeopleSave(
      AddPhoto addPhoto,
      String userId,
      ) {
    FirebaseFirestore.instance.collection('post').doc(addPhoto.id).update({
      "Saves": FieldValue.arrayUnion([userId])

    });
    FirebaseFirestore.instance.collection('users').doc(userId).collection('SavePost').doc(addPhoto.id).update({
      "Saves": FieldValue.arrayUnion([userId])

    });
 FirebaseFirestore.instance.collection('users').doc(userId).collection('FavPost').doc(addPhoto.id).update({
      "Saves": FieldValue.arrayUnion([userId])

    });

  }

  deletePeopleUnSave(
      AddPhoto addPhoto,
      String userId,
      ) {
    FirebaseFirestore.instance.collection('post').doc(addPhoto.id).update({
      "Saves": FieldValue.arrayRemove([userId])
    });
    FirebaseFirestore.instance.collection('users').doc(userId).collection('SavePost').doc(addPhoto.id).update({
      "Saves": FieldValue.arrayRemove([userId])

    });
 FirebaseFirestore.instance.collection('users').doc(userId).collection('FavPost').doc(addPhoto.id).update({
      "Saves": FieldValue.arrayRemove([userId])

    });

  }

  /////////////////////Comment

  addComment (
      AddPhoto addPhoto,
      Comments comments,
      ) {
    FirebaseFirestore.instance.collection('post').doc(addPhoto.id).update({
      "Comments": FieldValue.arrayUnion([comments])

    });

  }

  deleteComment(
      AddPhoto addPhoto,
      Comments comments,
      ) {
    FirebaseFirestore.instance.collection('post').doc(addPhoto.id).update({
      "Comments": FieldValue.arrayRemove([comments])
    });


  }

  addComments(AddPhoto addPhoto, Comments comments) async {
    firebaseFirestore
        .collection('post')
        .doc(addPhoto.id)
        .collection('Comments')
        .doc(comments.id)
        .set(comments.toMap());
  }
  removeComments(AddPhoto addPhoto, Comments comments) async {
    firebaseFirestore
        .collection('post')
        .doc(addPhoto.id)
        .collection('Comments')
        .doc(comments.id)
        .delete();
  }


  Future<List<Comments>> getComments(AddPhoto addPhoto) async {
    QuerySnapshot<Map<String, dynamic>> CommentsSnapshot =
    await firebaseFirestore
        .collection('post')
        .doc(addPhoto.id)
        .collection('Comments')
        .get();

    List<Comments> Comment = CommentsSnapshot.docs
        .map((e) {
      Map documentMap = e.data();
      documentMap['id'] = e.id;
      Comments comments = Comments.fromMap(documentMap);
      return comments;
    })
        .toList()
        .reversed
        .toList();
    return Comment;
  }
  //////////////////Story
  Future<String> uploadStoryPhoto(File file) async {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    Reference reference = firebaseStorage.ref('StoryImage/$fileName');
    await reference.putFile(file);
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }

  AddStory(UserStory userStory) async {
    await firebaseFirestore
        .collection('story')
        .doc(userStory.id)
        .set(userStory.toMap());
  }

  Future<List<UserStory>> getStory() async {
    QuerySnapshot<Map<String, dynamic>> StorySnapshot =
    await firebaseFirestore.collection('story').get();

    List<UserStory> Story = StorySnapshot.docs
        .map((e) {
      Map documentMap = e.data();
      documentMap['id'] = e.id;
      UserStory userStory = UserStory.fromMap(documentMap);
      return userStory;
    })
        .toList()
        .reversed
        .toList();
    return Story;
  }

  addPhotoToStory(
     String userId,
      String Photo,
      ) {
    FirebaseFirestore.instance.collection('story').doc(userId).update({
      "imgStory": FieldValue.arrayUnion([Photo])

    });


  }

  final String chatsCollectionName = 'Chats';
  final String messagesCollectionName = 'Messages';

  sendMessage(Message message) async {
    message.sentTime = FieldValue.serverTimestamp();
    await firebaseFirestore
        .collection(chatsCollectionName)
        .doc(message.chatId)
        .collection(messagesCollectionName)
        .add(message.toMap());
  }

  Future<bool> checkCollectionExists(String chatiD) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await firebaseFirestore
        .collection(chatsCollectionName)
        .doc(chatiD)
        .get();
    if (doc.exists) {
      return true;
    } else {
      return false;
    }
  }

  createChat(String chatId, NewUser myUser, NewUser otherUser) async {
    await firebaseFirestore.collection(chatsCollectionName).doc(chatId).set({
      'membersIds': [myUser.id, otherUser.id],
      'membersNames': [myUser.name, otherUser.name]
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getChats() async {
    String myId = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection(chatsCollectionName)
        .where('membersIds', arrayContains: myId)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    return docs;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages(String chatId) {
    return firebaseFirestore
        .collection(chatsCollectionName)
        .doc(chatId)
        .collection(messagesCollectionName)
        .orderBy('sentTime')
        .snapshots();
  }
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  getUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await firebaseFirestore.collection('users').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> query =
        querySnapshot.docs;
    return query;
  }



}


