import 'dart:convert';
import 'package:code/common/api.dart';
import 'package:code/mainPages/homePage/ranks_stamp.dart';
import 'package:code/mainPages/homePage/ranks_user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

List data = [];
var scrollController = new ScrollController();

class ranks extends StatelessWidget {
  const ranks({this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 176, 210, 176),
          title: Text(
            "排行",
          ),
          leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: rank(id),
        ));
  }
}

class rank extends StatefulWidget {
  final String id;
  const rank(this.id);
  @override
  _rankState createState() => _rankState(id);
}

class _rankState extends State<rank> {
  final String id;
  _rankState(this.id);
  bool _stamp = false;
  bool _user = false;

  _getposition(String id) {
    //控制排行页面的分区展示
    if (id == "stamp") {
      _stamp = true;
    } else if (id == "user") {
      _user = true;
    }
  }

  @override
  void initState() {
    //初始化获得展示页面的id
    super.initState();
    _getposition(id);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //制作分页控件
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    _stamp = true;
                    _user = false;
                  });
                },
                child: Text("邮票热度排行",
                    style: TextStyle(
                      color: _stamp
                          ? Color.fromARGB(255, 176, 210, 176)
                          : Colors.black, //当处于不同页面时，按钮颜色不同
                      fontSize: _stamp ? 20 : 16, //当处于不同页面时，按钮大小不同
                    ))),
            TextButton(
                onPressed: () {
                  setState(() {
                    _stamp = false;
                    _user = true;
                  });
                },
                child: Text("用户排行",
                    style: TextStyle(
                      color: _user
                          ? Color.fromARGB(255, 176, 210, 176)
                          : Colors.black,
                      fontSize: _user ? 20 : 16, //当处于不同页面时，按钮颜色不同
                    ))),
          ]),
          Visibility(
            visible: _stamp,
            child: Container(child: stampPage(data)),
          ),
          Visibility(visible: _user, child: Container(child: userPage(data))),
        ],
      ),
    );
  }
}
