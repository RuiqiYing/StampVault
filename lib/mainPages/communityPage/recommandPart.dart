import 'package:code/mainPages/communityPage/addCommentPart.dart';
import 'package:flutter/material.dart';

import 'postCardPart.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:code/common/api.dart';
import 'dart:convert';

dynamic test;
DateTime time;
List aList;

String UID;
getUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  UID = prefs.getString("id");
}

class node {
  int pos;
  int w;
  node(int _pos, int _w) {
    this.pos = _pos;
    this.w = _w;
  }
}

class recommandPage extends StatefulWidget {
  recommandPage();
  @override
  _recommandPageState createState() => _recommandPageState();
}

class _recommandPageState extends State<recommandPage>
    with AutomaticKeepAliveClientMixin {
  List<Widget> widgetList = [];
  List<node> mp = [];
  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    getUID();
    getAllPost();
  }

  getAllPost() async {
    var url = Uri.parse(Api.url + '/cs1902/post/getAll');
    var response = await http.get(
      url,
      headers: {"content-type": "application/json"},
    );
    test = jsonDecode(response.body);
    setState(() {
      aList = jsonDecode(Utf8Codec().decode(response.bodyBytes))['postData'];
    });
    int num = 0;
    for (var item in aList) {
      List<String> tmp = [];
      for (var i in item['imgList']) {
        tmp.add(i);
      }
      // if (num != 0) widgetList.add(Divider(height: 5));
      widgetList.add(new postCardPage(
        uid: item['uid'],
        pid: item['pid'],
        touXiang: item['avatarUrl'].toString(),
        userName: item['username'].toString(),
        time: item['postTime'].toString(),
        device: '',
        text: item['content'].toString(),
        tag: item['tags'].toString(),
        imageList: tmp,
        likes: item['star'],
        comments: item['commentNum'],
        forwards: item['share'],
      ));
      mp.add(node(num, item['star']));
      num++;
    }
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < mp.length; ++i)
      for (int j = i + 1; j < mp.length; ++j) {
        if (mp[i].w < mp[j].w) {
          node temp = mp[i];
          mp[i] = mp[j];
          mp[j] = temp;
        }
      }

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: widgetList.length,
          itemBuilder: (BuildContext context, int index) {
            return widgetList[mp[index].pos];
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
