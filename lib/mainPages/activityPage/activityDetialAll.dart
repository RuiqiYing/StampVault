import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

dynamic test;
String aid;
String uid;
bool join;
String joinText;
Color colorText;
final ValueNotifier<int> _counter = ValueNotifier<int>(0);

List aList = [
  {},
];
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
}

Future getInActivity() async {
  var url = Uri.parse(Api.url + '/cs1902/activity/' + aid + '/num');
  var response = await http.post(url,
      headers: {"content-type": "application/json"},
      body: '{"aid": "${aid}", "uid": "' + uid + '"}');
  if (response.statusCode == 200) {
    Fluttertoast.showToast(
      msg: '参与成功',
      gravity: ToastGravity.BOTTOM,
    );
    joinText = "已参与";
    colorText = Colors.grey;
    join = true;
    _counter.value += 1;
  }
}

class activityDetialAll extends StatefulWidget {
  final String id;
  activityDetialAll({Key key, this.id}) : super(key: key);
  @override
  _activityDetialAllState createState() => _activityDetialAllState();
}

class _activityDetialAllState extends State<activityDetialAll> {
  @override
  Future<void> initState() {
    aid = widget.id;
    aList = [
      {
        'title': '数据加载中...',
        'content': '数据加载中...',
        'manager': '数据加载中...',
        'url': '数据加载中...'
      },
    ];
    //初始化函数、带监听滑动功能
    super.initState();
    setState(() {
      initThisPage();
    });
  }

  getActivityDetail() async {
    var url = Uri.parse(Api.url + '/cs1902/activity/all/' + widget.id);
    var response = await http.post(
      url,
      headers: {"content-type": "application/json"},
    );
    setState(() {
      test = jsonDecode(Utf8Codec().decode(response.bodyBytes));
      aList = test;
      aList[0]['uptime'] = aList[0]['uptime'].substring(0, 10);
      aList[0]['offtime'] = aList[0]['offtime'].substring(0, 10);
    });
  }

  didIjoin() async {
    var url =
        Uri.parse(Api.url + '/cs1902/activity/' + aid + '/' + uid + '/exist');
    var response = await http.post(url,
        headers: {"content-type": "application/json"},
        body: '{"uid":"' + uid + '"}');
    join = jsonDecode(response.body);
    setState(() {
      if (join == false) {
        joinText = "立即参与";
        colorText = Colors.orange;
      } else {
        joinText = "已参与";
        colorText = Colors.grey;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildGrid(context);
  }

  Future<void> initThisPage() async {
    joinText = "加载中...";
    join = false;
    colorText = Colors.orange;
    await _readShared();
    await getActivityDetail();
    didIjoin();
  }
}

Widget buildGrid(BuildContext context) {
  return Container(
      child: Scaffold(
    backgroundColor: Color.fromARGB(255, 176, 210, 176),
    appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      leading: IconButton(
        icon: new Icon(Icons.chevron_left, color: Colors.black, size: 30),
        onPressed: () {
          Navigator.of(context)..pop();
        },
      ),
      centerTitle: true,
      title: Text(
        aList[0]['title'].toString(),
        style: TextStyle(color: Colors.black),
      ),
    ),
    body: ListView(
      children: [
        Stack(
          alignment: Alignment.center,
          overflow: Overflow.visible,
          children: [
            Container(
              height: 180,
              decoration: new BoxDecoration(
                color: Color.fromARGB(255, 176, 210, 176),
              ),
            ),
            Positioned(
                top: 21.0,
                child: Container(
                  decoration: new BoxDecoration(
                    color: Color.fromARGB(255, 176, 210, 176),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2.0, 2.0), //阴影xy轴偏移量
                          blurRadius: 5.0, //阴影模糊程度
                          spreadRadius: 1.0 //阴影扩散程度
                          )
                    ],
                  ),
                  child: Image(
                      height: 142,
                      width: 255,
                      image: NetworkImage(aList[0]['imageUrl'].toString()),
                      fit: BoxFit.cover
                      // centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                      ),
                )),
            Positioned(
              top: 24.0,
              child: Container(
                height: 100,
                decoration: new BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                // centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
              ),
            ),
          ],
        ),
        Container(
          height: 600,
          width: double.infinity,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                aList[0]['title'].toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 9, bottom: 9),
                alignment: Alignment.topLeft,
                decoration: new BoxDecoration(
                    border: new Border.all(color: Color(0xFFDDDDDD), width: 2)),
                child: (Row(children: [
                  Icon(Icons.people_alt_outlined,
                      color: Colors.black, size: 24),
                  SizedBox(width: 4),
                  Text('主办方:' + aList[0]['manager'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ))
                ])),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 9, bottom: 9),
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 5),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Color(0xFFDDDDDD), width: 2)),
                child: (Row(children: [
                  Icon(Icons.flag_outlined, color: Colors.black, size: 24),
                  SizedBox(width: 4),
                  Text('活动方式:',
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  Text(aList[0]['url'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ))
                ])),
              ),
              Container(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 9, bottom: 9),
                  margin: const EdgeInsets.only(top: 5),
                  alignment: Alignment.topLeft,
                  decoration: new BoxDecoration(
                      border:
                          new Border.all(color: Color(0xFFDDDDDD), width: 2)),
                  child: (Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.black, size: 24),
                      SizedBox(width: 4),
                      Text(
                        '活动日期:' +
                            aList[0]['uptime'].toString() +
                            '-' +
                            aList[0]['offtime'].toString(),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ))),
              Container(
                  // height: 400,
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 9, bottom: 9),
                  alignment: Alignment.topLeft,
                  decoration: new BoxDecoration(
                      border:
                          new Border.all(color: Color(0xFFDDDDDD), width: 2)),
                  child: (Column(children: [
                    Row(children: [
                      Icon(Icons.dvr, color: Colors.black, size: 24),
                      SizedBox(width: 4),
                      Text('活动简介  :',
                          style: TextStyle(
                            fontSize: 16,
                          ))
                    ]),
                    SizedBox(height: 10),
                    Text(aList[0]['content'],
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    ValueListenableBuilder(
                      builder: (BuildContext context, int value, Widget child) {
                        return Container(
                            child: InkWell(
                          onTap: () {
                            if (join == true) {
                              Fluttertoast.showToast(
                                msg: '您已参与此活动了',
                                gravity: ToastGravity.BOTTOM,
                              );
                            } else {
                              getInActivity();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 30, left: 40, right: 40),
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            decoration: new BoxDecoration(
                              color: colorText,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              joinText,
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ));
                      },
                      valueListenable: _counter,
                    )
                  ])))
            ],
          ),
          // centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
        ),
      ],
    ),
  ));
}
