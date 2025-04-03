import 'dart:convert';

import 'package:code/assets/myIcons.dart';
import 'package:code/common/api.dart';
import 'package:code/mainPages/communityPage/momentPart.dart';
import 'package:code/mainPages/communityPage/recommandPart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'addPostPart.dart';
import 'myCommunityPart.dart';
import 'personInformationPart.dart';
import 'addPostPart.dart';
import 'searchMessagePart.dart';
import 'postCardPart.dart';

class communityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: searchMessage(),
          actions: <Widget>[buildMessage()],
          bottom: TabBar(
            labelColor: Color.fromARGB(255, 176, 210, 176),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black54,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 1.0,
            tabs: <Widget>[Tab(text: '推荐'), Tab(text: '动态')],
          ),
        ),
        body: TabBarView(children: <Widget>[recommandPage(), momentPage()]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, new MaterialPageRoute(builder: (
              BuildContext context,
            ) {
              return new addPostCard();
            }));
          },
          child: IconButton(
              icon: Icon(MyIcons.add2Font),
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(builder: (
                  BuildContext context,
                ) {
                  return new addPostCard();
                }));
              }),
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 180, 210, 250),
        ),
      ),
    );
  }
}
