import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/Auth/fire_store.dart';
import 'package:facebook_app/modules/chat.dart';
import 'package:facebook_app/modules/message.dart';
import 'package:facebook_app/modules/new_user.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AllChatMessagesScreen extends StatelessWidget {
  Chat chat;
  NewUser otherUser;
  AllChatMessagesScreen({this.chat, this.otherUser});
  TextEditingController textEditingController = TextEditingController();
  String setChatId() {
    String chatId;
    String myId = FirebaseAuth.instance.currentUser.uid;
    int myIdHash = myId.hashCode;
    int otherUserHash = otherUser.id.hashCode;

    if (myIdHash > otherUserHash) {
      chatId = myId.toString() + '_' + (otherUser.id.toString());
    } else {
      chatId = (otherUser.id.toString()) + '_' + myId.toString();
    }
    return chatId;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<MyProvider>(builder: (context, provider, x) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(otherUser.name),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.call_outlined)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FireStore.fireStore
                      .getChatMessages(chat?.chatId ?? setChatId()),
                  builder: (context, dataSnapShot) {
                    List<QueryDocumentSnapshot<Map<String, dynamic>>>
                        snapshots = dataSnapShot.data?.docs ?? [];
                    return Container(
                      child: ListView.builder(
                          itemCount: snapshots.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 2),
                              child: Row(
                                mainAxisAlignment: snapshots[index]
                                            ['senderId'] ==
                                        provider.loggedUser.id
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      snapshots[index]['senderId'] ==
                                              provider.loggedUser.id
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                            )
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  otherUser.imgUrl),
                                            ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      ChatBubble(
                                        backGroundColor: snapshots[index]
                                                    ['senderId'] ==
                                                provider.loggedUser.id
                                            ? Colors.deepOrange
                                            : Colors.grey[500],
                                        clipper: ChatBubbleClipper5(
                                            type: snapshots[index]
                                                        ['senderId'] ==
                                                    provider.loggedUser.id
                                                ? BubbleType.sendBubble
                                                : BubbleType.receiverBubble),
                                        child: Text(
                                          snapshots[index]['content'],
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  },
                )),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 130.h,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: textEditingController,
                          decoration: InputDecoration(
                            hoverColor: Colors.deepOrange,
                            focusColor: Colors.amberAccent,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(50)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'Message...',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        String chatId;
                        if (otherUser != null) {
                          chatId = setChatId();
                        } else {
                          chatId = this.chat.chatId;
                        }
                        Message message = Message(
                            content: textEditingController.text,
                            senderId: provider.loggedUser.id,
                            chatId: chatId);
                        provider.sendMessage(message, otherUser);
                        textEditingController.clear();
                      },
                      child: Container(
                          height: 130.h,
                          width: 170.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
