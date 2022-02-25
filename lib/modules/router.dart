import 'package:flutter/material.dart';


class RouterClass {
  RouterClass._();
  static RouterClass routerClass = RouterClass._();
  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  pushToSpecificScreenByName(String screenName) {
    navKey.currentState.pushNamed(screenName);
  }

  pushToSpecificScreenUsingWidget(Widget widget) {
    BuildContext context = navKey.currentContext;
    navKey.currentState.push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  popFunction() {
    navKey.currentState.pop();
  }

}