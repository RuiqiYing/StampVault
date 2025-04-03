import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:code/assets/myIcons.dart';
import 'package:code/common/api.dart';
import 'package:code/mainPages/communityPage/personInformationPart.dart';
import 'package:code/mainPages/communityPage/tagCardPart.dart';
import 'package:code/mainPages/minePage/othersInfoAll.dart';
import 'package:code/mainPages/minePage/othersSecondInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'commentCardPart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'communityAll.dart';

setPid(int pid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('pid', pid);
}

String UID;
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  UID = preferences.get('id');
}

String TAG;

int YN = 0;
getYn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  YN = prefs.getInt("yn");
}

class SpUtil {
  static SharedPreferences prefs;
  static Future<bool> getTag() async {
    prefs = await SharedPreferences.getInstance();
    TAG = prefs.getString("tag");
    return true;
  }

  static Future<bool> setTag(String tag) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("tag", tag);
    return true;
  }
}

dynamic test;
DateTime time;
List aList;

class postCardPage extends StatefulWidget {
  postCardPage(
      {Key key,
      this.uid,
      this.pid,
      this.touXiang,
      this.userName,
      this.time,
      this.device,
      this.text,
      this.tag,
      this.imageList,
      this.likes,
      this.comments,
      this.forwards,
      this.likeMode = 0,
      this.followMode = 0})
      : super(key: key);
  int uid;
  int pid;
  String touXiang;
  String userName;
  String time;
  String device;
  String text;
  String tag;
  List<String> imageList;
  int likes;
  int comments;
  int forwards;
  int likeMode;
  int followMode;
  @override
  _postCardPageState createState() => _postCardPageState();
}

class _postCardPageState extends State<postCardPage> {
  @override
  int vis = 0;
  List<Widget> widgetList = [];
  void initState() {
    _readShared();
    //初始化函数、带监听滑动功能
    super.initState();
    setState(() {
      initThisPage();
    });
  }

  initThisPage() async {
    await _readShared();
    print(UID);
    await getAllFollows();
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

  insertPost(int uid, String tag, String text, String time,
      List<String> imgList) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse(Api.url + '/cs1902/post/insert'));
    request.body =
        "{\"uid\": ${uid},\"content\": \"${text}\",\"postTime\": \"${time}\",\"tags\": \"${tag}\",\"imgList\": ${imgList}}";
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
  }

  getAllFollows() async {
    var url = Uri.parse(Api.url + '/cs1902/follower/getAll');
    var response = await http.get(
      url,
      headers: {"content-type": "application/json"},
    );
    test = jsonDecode(response.body);
    aList = jsonDecode(Utf8Codec().decode(response.bodyBytes))['Data'];
    setState(() {
      for (var item in aList) {
        if (item['fid'] == int.parse(UID) && item['uid'] == widget.uid) {
          widget.followMode = 1;
          break;
        }
      }
    });
  }

  insertFollow(int uid, int fid) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse(Api.url + '/cs1902/follower/insert'));
    request.body = "{\"uid\": ${uid},\"fid\": ${fid}}";
    print(request.body.toString());
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
  }

  deleteFollow(int uid, int fid) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse(Api.url + '/cs1902/follower/delete'));
    request.body = "{\"uid\": ${uid},\"fid\": ${fid}}";
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    widgetList.clear();
    for (int i = 0; i < widget.imageList.length; ++i) {
      widgetList.add(Image(
          image: NetworkImage(widget.imageList[i]), height: 70, width: 70));
    }

    Future commentArea(int pid) async {
      RenderBox renderBox = context.findRenderObject();
      var screenSize = renderBox.size;
      final option = await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, state) {
              setPid(widget.pid);
              return new commentAllIn(
                  pid: widget.pid,
                  likes: widget.likes,
                  comments: widget.comments,
                  shares: widget.forwards,
                  phoneSize: screenSize);
            });
          });
    }

    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
            padding: EdgeInsets.all(15.0),
            alignment: Alignment.center,
            height: 400,
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: new AppBar(
                    elevation: 6.0,
                    shape: ContinuousRectangleBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    backgroundColor: Color.fromARGB(255, 240, 240, 240),
                    leading: InkWell(
                        child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                            child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(widget.touXiang),
                                child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    alignment: Alignment.center,
                                    // width: 150,
                                    height: 150))),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return new othersAllPage(id: widget.uid);
                          }));
                        }),
                    title: IntrinsicWidth(
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text(widget.userName,
                                  style: TextStyle(
                                      color: Color(0xFF111111),
                                      decorationStyle:
                                          TextDecorationStyle.double,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      textBaseline: TextBaseline.alphabetic,
                                      fontSize: 13,
                                      letterSpacing: 2,
                                      wordSpacing: 10,
                                      height: 1.5),
                                  textAlign: TextAlign.start)),
                          Text(widget.time,
                              style: TextStyle(
                                  color: Colors.grey,
                                  decorationStyle: TextDecorationStyle.double,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  textBaseline: TextBaseline.alphabetic,
                                  fontSize: 11,
                                  letterSpacing: 2,
                                  wordSpacing: 10,
                                  height: 1.5),
                              textAlign: TextAlign.start)
                        ])),
                    actions: <Widget>[
                      widget.uid == int.parse(UID)
                          ? Text("")
                          : IconButton(
                              color: widget.followMode == 1
                                  ? Colors.red[700]
                                  : Colors.black,
                              icon: widget.followMode == 1
                                  ? Icon(MyIcons.followFont, size: 28)
                                  : Icon(MyIcons.followFont),
                              onPressed: () {
                                showFollowDialog(context);
                              })
                    ]),
                body: Neumorphic(
                    style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.only(bottomLeft: Radius.circular(0))),
                        depth: 20,
                        color: Color.fromARGB(255, 240, 240, 240)),
                    child: Container(
                        padding: EdgeInsets.only(left: 10, top: 20, right: 10),
                        child: new ListView(children: [
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text("  " + widget.text,
                                  style: TextStyle(
                                      color: Color(0xFF111111),
                                      decorationStyle:
                                          TextDecorationStyle.double,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      textBaseline: TextBaseline.alphabetic,
                                      fontSize: 13,
                                      letterSpacing: 2,
                                      wordSpacing: 10,
                                      height: 1.2),
                                  softWrap: true,
                                  maxLines: 100,
                                  overflow: TextOverflow.ellipsis)),
                          SizedBox(height: 10),
                          Container(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 15, right: 10),
                                  child: new Wrap(
                                      spacing: 10,
                                      runSpacing: 8,
                                      children: widgetList)))
                        ]))),
                bottomNavigationBar: Neumorphic(
                    style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                        depth: -10,
                        color: Color.fromARGB(255, 240, 240, 240)),
                    child: IntrinsicWidth(
                        child: Container(
                            height: 40,
                            child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  new Row(children: <Widget>[
                                    new Row(children: [
                                      IconButton(
                                          color: widget.likeMode == 1
                                              ? Color.fromARGB(
                                                  255, 176, 210, 176)
                                              : Colors.black,
                                          icon: widget.likeMode == 1
                                              ? Icon(MyIcons.likeFont, size: 28)
                                              : Icon(MyIcons.likeFont),
                                          onPressed: () {
                                            if (widget.likeMode == 0) {
                                              updatePostLikeCommShare(
                                                  widget.pid,
                                                  widget.likes + 1,
                                                  widget.comments,
                                                  widget.forwards);
                                              setState(() {
                                                widget.likes += 1;
                                                widget.likeMode = 1;
                                              });
                                            } else {
                                              updatePostLikeCommShare(
                                                  widget.pid,
                                                  widget.likes - 1,
                                                  widget.comments,
                                                  widget.forwards);
                                              setState(() {
                                                widget.likes -= 1;
                                                widget.likeMode = 0;
                                              });
                                            }
                                          }),
                                      Text('${widget.likes}',
                                          style: TextStyle(
                                              color: Color(0xFF111111),
                                              decorationStyle:
                                                  TextDecorationStyle.double,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: 15,
                                              letterSpacing: 2,
                                              wordSpacing: 10,
                                              height: 1.2))
                                    ]),
                                    SizedBox(width: 40),
                                    new Row(children: [
                                      IconButton(
                                          icon: Icon(MyIcons.commentFont),
                                          onPressed: () {
                                            setPid(widget.pid);
                                            commentArea(widget.pid);
                                          }),
                                      Text('${widget.comments}',
                                          style: TextStyle(
                                              color: Color(0xFF111111),
                                              decorationStyle:
                                                  TextDecorationStyle.double,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: 15,
                                              letterSpacing: 2,
                                              wordSpacing: 10,
                                              height: 1.2))
                                    ]),
                                    SizedBox(width: 40),
                                    new Row(children: [
                                      IconButton(
                                          onPressed: () {
                                            showAlertDialog(context);
                                          },
                                          icon: Icon(MyIcons.forwardFont)),
                                      Text('${widget.forwards}',
                                          style: TextStyle(
                                              color: Color(0xFF111111),
                                              decorationStyle:
                                                  TextDecorationStyle.double,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: 15,
                                              letterSpacing: 2,
                                              wordSpacing: 10,
                                              height: 1.2))
                                    ])
                                  ])
                                ])))))));
  }

  showAlertDialog(BuildContext context) {
    //设置按钮
    Widget cancelButton = FlatButton(
      child: Text("取消"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("确定"),
      onPressed: () {
        DateTime now = new DateTime.now();
        insertPost(
            int.parse(UID),
            widget.tag,
            "@" + widget.userName + "// " + widget.text,
            now.toString(),
            widget.imageList);
        updatePostLikeCommShare(
            widget.pid, widget.likes, widget.comments, widget.forwards + 1);
        setState(() {
          widget.forwards += 1;
        });
        Navigator.of(context).pop();
      },
    );

    //设置对话框
    AlertDialog alert = AlertDialog(
        title: Text("转发提示框"),
        content: Text("确定转发吗？"),
        actions: [continueButton, cancelButton]);

    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showFollowDialog(BuildContext context) {
    //设置按钮
    Widget cancelButton = FlatButton(
      child: Text("取消"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("确定"),
      onPressed: () {
        if (widget.followMode == 0)
          insertFollow(widget.uid, int.parse(UID));
        else
          deleteFollow(widget.uid, int.parse(UID));
        setState(() {
          widget.followMode = 1 - widget.followMode;
        });
        Navigator.of(context).pop();
      },
    );

    //设置对话框
    AlertDialog alert = AlertDialog(
        title: Text("关注提示框"),
        content: Text("确定关注吗？"),
        actions: [continueButton, cancelButton]);

    AlertDialog alert2 = AlertDialog(
        title: Text("取消关注提示框"),
        content: Text("确定取消关注吗？"),
        actions: [continueButton, cancelButton]);

    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (widget.followMode == 0)
          return alert;
        else
          return alert2;
      },
    );
  }
}
