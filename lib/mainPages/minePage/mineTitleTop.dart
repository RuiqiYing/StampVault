import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String type = 'lib/assets/titleImages/bronze.jpg';
String uid;
Map aList;
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
}

class mineTitleTop extends StatefulWidget {
  @override
  _mineTitleTop createState() => _mineTitleTop();
}

// ignore: camel_case_types
class _mineTitleTop extends State<mineTitleTop> {
  Future<void> initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    setState(() {
      initThisPage();
    });
  }

  initThisPage() async {
    aList = {
      'name': 'loading',
      'title': {'title_type': '1', 'title_name': 'loading'},
      'avatar_url': 'loading',
      'fans_num': '0',
      'subscribe_num': '0',
      'post_num': '0'
    };
    await _readShared();
    await getAllTitle();
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
                left: 20.0, right: 20, top: 14, bottom: 9),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                left: 20, bottom: 0, top: 5),
                            child: Row(children: [
                              Text('称号墙',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 20)),
                              Container(
                                  decoration: new BoxDecoration(
                                      border: new Border.all(
                                          width: 3, color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: AssetImage(type),
                                          fit: BoxFit.cover)),
                                  margin: const EdgeInsets.only(left: 20),
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 2, top: 2, right: 20),
                                  child: Row(children: [
                                    Text(
                                      aList['title']['title_name'],
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ])),
                            ])),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              '您共获得了1个称号,点击下方称号可进行更替',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ))
                      ]),
                  Container(
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.only(left: 20),
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
                            image: NetworkImage(aList['avatar_url'].toString()),
                            fit: BoxFit.cover
                            // centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                            )),
                  ),
                ],
              ),
            ])));
  }
}
