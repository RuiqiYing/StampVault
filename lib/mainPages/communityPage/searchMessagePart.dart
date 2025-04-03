import 'package:code/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:code/assets/myIcons.dart';

class buildMessage extends StatelessWidget {
  //const buildMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(context, new MaterialPageRoute(builder: (
            BuildContext context,
          ) {
            return chatPage();
          }));
        },
        icon: Icon(
          MyIcons.message2Font,
          color: Color.fromARGB(255, 176, 210, 176),
        ));
  }
}

class searchMessage extends StatelessWidget {
  Widget buildTextField() {
    return Theme(
        data: ThemeData(primaryColor: Colors.grey),
        child: new TextField(
            cursorColor: Color.fromARGB(255, 176, 210, 176),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 176, 210, 176))),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 176, 210, 176))),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 176, 210, 176))),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 176, 210, 176))),
                icon: Icon(Icons.search),
                hintText: "搜索",
                hintStyle: new TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(50, 0, 0, 0),
                    fontWeight: FontWeight.w700))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(new Radius.circular(5.0))),
            alignment: Alignment.center,
            height: 20,
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: buildTextField()));
  }
}
