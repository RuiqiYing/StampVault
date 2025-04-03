import 'package:flutter/material.dart';

import 'widgets/favorite_contacts.dart';
import 'widgets/recent_chats.dart';

class privatePage extends StatefulWidget {
  const privatePage({Key key}) : super(key: key);

  @override
  _privatePageState createState() => _privatePageState();
}

class _privatePageState extends State<privatePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: Column(
                  children: <Widget>[FavoriteContacts(), RecentChats()])))
    ]));
  }
}
