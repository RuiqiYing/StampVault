import 'package:code/chat/chat.dart';
import 'package:code/login/forget_password.dart';
import 'package:code/login/sign_up.dart';
import 'package:code/mainPages/communityPage/myCommunityPart.dart';
import 'package:code/mainPages/homePage/threeButton/information/inforDetail.dart';
import 'package:code/mainPages/homePage/threeButton/information/information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'bottom.dart';

import 'mainPages/shakePage/shakeAll.dart';
import 'mainPages/activityPage/activityAll.dart';
import 'mainPages/communityPage/communityAll.dart';
import 'mainPages/homePage/homeAll.dart';
import 'mainPages/minePage/mineAll.dart';
import 'login/login.dart';
import 'login/forget_password.dart';
import 'login/sign_up.dart';

import 'flutter_neumorphic.dart';
import 'mainPages/communityPage/addPostPart.dart';
import 'mainPages/communityPage/myCommunityPart.dart';
import 'mainPages/communityPage/personInformationPart.dart';
import 'mainPages/communityPage/addCommentPart.dart';

void main() {
  runApp(Router());
}

class Router extends StatelessWidget {
  final routes = {
    '/login': (context) => Login(),
    '/forget_password': (context) => ForgetPassword(),
    '/sign_up': (context) => SignUp(),
    '/home': (context) => homePage(),
    '/community': (context) => communityPage(),
    '/mine': (context) => minePage(),
    '/shake': (context) => Shake(),
    '/activity': (context) => activityPage(),
    '/bottom': (context) => indexPage(),
    '/infor': (context) => informationPage(),
    '/addPost': (context) => addPostCard(),
    '/myCommunity': (context) => myCommunityPage(),
    '/personInformation': (context) => personInformationPage(),
    '/chat': (context) => chatPage(),
    '/chatCard': (context) => chatPage(), // 具体的聊天界面
    '/addComment': (context) => addCommentpart(),
    '/inforDetail': (context) => inforDetail(),
  };

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      initialRoute: '/login',
      routes: routes,
      color: Color.fromARGB(255, 126, 160, 126),
      onGenerateRoute: (RouteSettings settings) {
        //统一处理
        final String name = settings.name;
        final Function pageContentBuilder = this.routes[name];
        if (pageContentBuilder != null) {
          if (settings.arguments != null) {
            final Route route = MaterialPageRoute(
                builder: (context) =>
                    pageContentBuilder(context, arguments: settings.arguments));
            return route;
          } else {
            final Route route = MaterialPageRoute(
                builder: (context) => pageContentBuilder(context));
            return route;
          }
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
