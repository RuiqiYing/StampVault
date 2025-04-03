import 'dart:convert';
import 'dart:io';

import 'package:code/mainPages/communityPage/addCommentPart.dart';
import 'package:code/mainPages/homePage/hotTopicPart.dart';
import 'package:flutter/material.dart';
import '../../bottom.dart';
import 'commentUserCard.dart';
import 'package:http/http.dart' as http;
import 'package:code/common/api.dart';

import 'package:shared_preferences/shared_preferences.dart';

int PID;
getPID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  PID = prefs.getInt("pid");
}
dynamic test;
DateTime time;
List aList;
dynamic test2;
DateTime time2;
List aList2;

class commentAllIn extends StatelessWidget {
  commentAllIn(
      {Key key,
      this.pid,
      this.likes,
      this.comments,
      this.shares,
      this.phoneSize})
      : super(key: key);
  int pid;
  int likes;
  int comments;
  int shares;
  int flag = 0;
  Size phoneSize;
  @override
  Widget build(BuildContext context) {
    getPID();
    return commentCard(
        pid: pid, likes: likes, comments: comments, shares: shares);
  }
}

class commentCard extends StatefulWidget {
  commentCard(
      {Key key,
      this.pid,
      this.likes,
      this.comments,
      this.shares,
      this.phoneSize})
      : super(key: key);
  int pid;
  int likes;
  int comments;
  int shares;
  Size phoneSize;
  @override
  _commentCardState createState() => _commentCardState();
}

class _commentCardState extends State<commentCard> {
  List<Widget> widgetList = [Divider()];
  void initState() {
    super.initState();
    // getInt();
    getAllComment();
  }

  getAllComment() async {
    var url = Uri.parse(Api.url + '/cs1902/comment/getAll');
    var response = await http.get(
      url,
      headers: {"content-type": "application/json"},
    );
    test = jsonDecode(response.body);
    setState(() {
      aList = jsonDecode(Utf8Codec().decode(response.bodyBytes))['postData'];
    });
    print(PID);
    for (var item in aList) {
      if (PID == item['pid'])
        widgetList.add(new commentUserCard(
            pid: item['pid'],
            uid: item['uid'],
            cid: item['cid'],
            text: item['content'].toString(),
            time: item['time'].toString(),
            touxiang: item['avatarUrl'].toString(),
            username: item['username'].toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    int flag = 0;
    print(widget.phoneSize.toString());
    return Stack(alignment: AlignmentDirectional.topCenter, children: [
      Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                color: Colors.black,
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return indexPage(now: 3);
                      },
                    ));
                  });
                }),
            title:
                Text('评论', style: TextStyle(color: Colors.grey, fontSize: 25)),
            actions: [
              IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    setState(() {
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) {
                        return new addCommentpart(
                            likes: widget.likes,
                            comments: widget.comments,
                            shares: widget.shares);
                      }));
                    });
                  },
                  color: Colors.grey)
            ],
          ),
          body: Container(
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: widgetList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return widgetList[index];
                  })))
    ]);
  }
}
