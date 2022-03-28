import 'package:facebook_app/modules/router.dart';
import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:facebook_app/ui/chats/chat_messages_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AllUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<MyProvider>(builder: (context, provider, x) {
      return Container(
        child: provider.users == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: provider.users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      RouterClass.routerClass
                          .routingToSpecificWidgetWithoutPop(
                              AllChatMessagesScreen(
                        otherUser: provider.users[index],
                      ));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(provider.users[index].imgUrl,
                      ),
                      radius: 80.r,
                    ),
                    title: Text(provider.users[index].name),
                    subtitle: Text(provider.users[index].email),
                  );
                }),
      );
    });
  }
}
