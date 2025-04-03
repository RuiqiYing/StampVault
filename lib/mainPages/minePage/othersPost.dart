import 'dart:convert';

import 'package:code/assets/myIcons.dart';
import 'package:code/common/api.dart';
import 'package:code/mainPages/communityPage/postCardPart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

String type = 'lib/assets/titleImages/bronze.jpg';

dynamic test;
DateTime time;
List aaList;

class othersPostPage extends StatefulWidget {
  // minePage({Key key}) : super(key: key);
  final int id;
  othersPostPage({Key key, this.id}) : super(key: key);
  @override
  _othersPostState createState() => _othersPostState();
}

// ignore: camel_case_types
class _othersPostState extends State<othersPostPage> {
  @override
  List<Widget> temp = [];

  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    temp.clear();
    setState(() {
      getAllPost();
    });
  }

  getAllPost() async {
    var url = Uri.parse(Api.url + '/cs1902/post/getAll');
    var response = await http.get(
      url,
      headers: {"content-type": "application/json"},
    );
    test = jsonDecode(response.body);
    setState(() {
      aaList = jsonDecode(Utf8Codec().decode(response.bodyBytes))['postData'];
    });
    // print(aList);
    temp.add(SizedBox(height: 10));
    temp.add(Container(alignment: Alignment.topLeft, child: Text('最近动态')));
    temp.add(SizedBox(height: 10));
    for (var item in aaList) {
      if (widget.id == item['uid']) {
        List<String> tmp = [];
        for (var i in item['imgList']) {
          tmp.add(i);
        }
        temp.add(new postCardPage(
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
            forwards: item['share']));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: temp);
    // return ListView.builder(itemCount: temp.length, itemBuilder: (BuildContext context, int index){ return temp[index];});
  }
}
