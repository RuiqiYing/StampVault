import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:code/common/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bottom.dart';
import 'communityAll.dart';

String UID;
getUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  UID = prefs.getString("id");
}

int PID;
getPID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  PID = prefs.getInt("pid");
}

setYnadd(int yn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("yn", yn);
}

class addCommentpart extends StatefulWidget {
  addCommentpart(
      {Key key, this.uid, this.pid, this.likes, this.comments, this.shares})
      : super(key: key);
  int uid;
  int pid;
  String text;
  int likes;
  int comments;
  int shares;
  @override
  _addCommentpartState createState() => _addCommentpartState();
}

class _addCommentpartState extends State<addCommentpart> {
  insertComment(int pid, int uid, String text, String time) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse(Api.url + '/cs1902/comment/insert'));
    print(text);
    print(text.toString());
    request.body =
        "{\"pid\": ${pid}, \"uid\": ${uid}, \"content\": \"${text}\", \"time\": \"${time}\"}";
    print(request.body.toString());
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
  }

  updatePostLikeCommShare(int pid, int likes, int comments, int shares) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse(Api.url + '/cs1902/post/update'));
    request.body =
        "{\"pid\": ${pid},\"star\": ${likes},\"commentNum\": ${comments},\"share\": ${shares}}";
    print(request.body.toString());
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    getUID();
    getPID();
    String content = "";
    return SizedBox(
        width: 450,
        height: 600,
        child: Container(
            width: 400,
            height: 500,
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: SizedBox(
                width: 400,
                height: 300,
                child: Scaffold(
                    appBar: new AppBar(
                      backgroundColor: Color.fromARGB(255, 176, 210, 176),
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                            setYnadd(0);
                          }),
                      title: Text('评论',
                          style: TextStyle(
                              fontSize: 28.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      actions: [
                        TextButton(
                            child: Text("发布",
                                style: TextStyle(color: Colors.black)),
                            onPressed: () {
                              DateTime now = new DateTime.now();
                              insertComment(PID, int.parse(UID), widget.text,
                                  now.toString());
                              updatePostLikeCommShare(PID, widget.likes,
                                  widget.comments + 1, widget.shares);
                              setState(() {
                                setYnadd(1);
                                Navigator.of(context).pop(true);
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return indexPage(now: 3);
                                }));
                              });
                              // deactivate();
                            })
                      ],
                    ),
                    body: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: SizedBox(
                            child: TextField(
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.blue,
                                cursorWidth: 5,
                                maxLines: 8,
                                decoration: InputDecoration(
                                    hintText: '请输入你想发布的内容...',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                onChanged: (a) {
                                  widget.text = a;
                                })))))));
  }

  @override
  void deactivate() {
    super.deactivate();
    var bool = ModalRoute.of(context).isCurrent;
    if (bool) {
      initState(); //需要调用的方法
    }
  }
} 
