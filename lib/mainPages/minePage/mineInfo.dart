import 'dart:convert';

import 'package:code/chat/chat.dart';
import 'package:code/chat/private.dart';
import 'package:code/common/api.dart';
import 'package:code/mainPages/communityPage/myCommunityPart.dart';
import 'package:code/mainPages/minePage/fixmineInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'mineTitleAll.dart';

String type = 'lib/assets/titleImages/bronze.jpg';
Map aList;
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
}

class mineInfoPage extends StatefulWidget {
  mineInfoPage();
  // minePage({Key key}) : super(key: key);

  @override
  mineInfoState createState() => mineInfoState();
}

// ignore: camel_case_types
class mineInfoState extends State<mineInfoPage> {
  @override
  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    setState(() {
      aList = {
        'name': 'loading',
        'title': {'title_type': '1', 'title_name': 'loading'},
        'avatar_url': 'loading',
        'fans_num': '0',
        'subscribe_num': '0',
        'post_num': '0'
      };
      initThisPage();
    });
  }

  Future<void> initThisPage() async {
    await _readShared();
    await getAllTitle();
    flag = false;
  }

  getAllTitle() async {
    var url = Uri.parse(Api.url + '/cs1902/user/info/' + uid);
    var response =
        await http.get(url, headers: {"content-type": "application/json"});
    setState(() {
      aList = jsonDecode(Utf8Codec().decode(response.bodyBytes));
      if (aList['title']['title_type'] == 1) {
        type = 'lib/assets/titleImages/bronze.jpg';
      } else {
        type = 'lib/assets/titleImages/blue.jpg';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            new BoxDecoration(color: Color.fromARGB(255, 176, 210, 176)),
        child: Container(
            decoration: new BoxDecoration(),
            margin: const EdgeInsets.only(
                left: 30.0, right: 20, top: 17, bottom: 9),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => fixmineInfoPage()))
                            .then((name) {
                          setState(() {
                            print(name);
                            if (name["flag"] == true)
                              aList['name'] = name["name"];
                          });
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(2.0, 2.0), //阴影xy轴偏移量
                                  blurRadius: 5.0, //阴影模糊程度
                                  spreadRadius: 1.0 //阴影扩散程度
                                  )
                            ],
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(150),
                            image: DecorationImage(
                                image: NetworkImage(
                                    aList['avatar_url'].toString()),
                                fit: BoxFit.cover
                                // centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                                )),
                      )),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                left: 20, bottom: 9, top: 10),
                            child: Text(aList['name'],
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 20))),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => mineTitleAllPage()));
                          },
                          child: Container(
                              decoration: new BoxDecoration(
                                  border: new Border.all(
                                      width: 3, color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(type),
                                      fit: BoxFit.cover)),
                              margin: const EdgeInsets.only(
                                  left: 20, bottom: 9, top: 10),
                              padding: const EdgeInsets.only(
                                  left: 10, bottom: 2, top: 2, right: 10),
                              child: Row(children: [
                                Text(
                                  aList['title']['title_name'],
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(Icons.chevron_right,
                                    color: Colors.black, size: 24),
                              ])),
                        )
                      ]),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 65,
                width: double.infinity,
                decoration: new BoxDecoration(
                    border: new Border.all(width: 2, color: Colors.black12),
                    color: Color.fromARGB(255, 255, 255, 255)),
                child: new Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 70,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return myCommunityPage();
                              }));
                            },
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(aList['post_num'].toString(),
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        decorationStyle:
                                            TextDecorationStyle.double,
                                        fontWeight: FontWeight.w500,
                                        textBaseline: TextBaseline.alphabetic,
                                        fontSize: 20,
                                        letterSpacing: 2,
                                        wordSpacing: 10,
                                        height: 1.2,
                                      )),
                                  Text('圈子',
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        decorationStyle:
                                            TextDecorationStyle.double,
                                        fontWeight: FontWeight.w500,
                                        textBaseline: TextBaseline.alphabetic,
                                        fontSize: 14,
                                        letterSpacing: 2,
                                        wordSpacing: 10,
                                        height: 1.2,
                                      ))
                                ]))),
                    SizedBox(
                        height: 70,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return chatPage();
                              }));
                            },
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(aList['subscribe_num'].toString(),
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        decorationStyle:
                                            TextDecorationStyle.double,
                                        fontWeight: FontWeight.w500,
                                        textBaseline: TextBaseline.alphabetic,
                                        fontSize: 20,
                                        letterSpacing: 2,
                                        wordSpacing: 10,
                                        height: 1.2,
                                      )),
                                  Text('关注',
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        decorationStyle:
                                            TextDecorationStyle.double,
                                        fontWeight: FontWeight.w500,
                                        textBaseline: TextBaseline.alphabetic,
                                        fontSize: 14,
                                        letterSpacing: 2,
                                        wordSpacing: 10,
                                        height: 1.2,
                                      )),
                                ]))),
                    SizedBox(
                        height: 70,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return chatPage();
                              }));
                            },
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(aList['fans_num'].toString(),
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        decorationStyle:
                                            TextDecorationStyle.double,
                                        fontWeight: FontWeight.w500,
                                        textBaseline: TextBaseline.alphabetic,
                                        fontSize: 20,
                                        letterSpacing: 2,
                                        wordSpacing: 10,
                                        height: 1.2,
                                      )),
                                  Text('粉丝',
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        decorationStyle:
                                            TextDecorationStyle.double,
                                        fontWeight: FontWeight.w500,
                                        textBaseline: TextBaseline.alphabetic,
                                        fontSize: 14,
                                        letterSpacing: 2,
                                        wordSpacing: 10,
                                        height: 1.2,
                                      )),
                                ]))),
                  ],
                ),
              )
            ])));
  }
}
