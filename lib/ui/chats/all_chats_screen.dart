import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'chat_messages_screen.dart';

class AllChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<MyProvider>(builder: (context, provider, x) {
      return Container(
        child: provider.allMyChats == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.allMyChats.isEmpty
                ? Center(
                    child: Text('No Chats Found'),
                  )
                : ListView.builder(
                    itemCount: provider.allMyChats.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          RouterClass.routerClass.pushToSpecificScreenUsingWidget(
                                  AllChatMessagesScreen(
                                      chat: provider.allMyChats[index]));
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(provider.users[index].imgUrl,
                          ),
                          radius: 80.r,
                        ),
                        title: Text(provider.allMyChats[index].membersNames
                            .where(
                                (element) => element != provider.loggedUser.name)
                            .first),
                        subtitle: Text(provider.users[index].email),
                      );
                    }),
      );
    });
  }
}
