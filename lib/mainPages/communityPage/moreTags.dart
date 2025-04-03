import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:code/mainPages/communityPage/tagCardPart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'addCommentPart.dart';

dynamic test;
DateTime time;
List aList;

class moreTags extends StatefulWidget {
  const moreTags({Key key}) : super(key: key);

  @override
  _moreTagsState createState() => _moreTagsState();
}

class _moreTagsState extends State<moreTags> {
  List<String> tagTextList = [];
  List<Widget> tagCardList = [];

  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    getAllTag();
  }

  getAllTag() async {
    var url = Uri.parse(Api.url + '/cs1902/tag/all');
    var response = await http.post(
      url,
      headers: {"content-type": "application/json"},
    );
    test = jsonDecode(response.body);
    setState(() {
      aList = jsonDecode(Utf8Codec().decode(response.bodyBytes));
    });
    // List<Widget> tmp = [];
    for (var item in aList) {
      tagTextList.add(item['content'].toString());
      tagCardList
          .add(new tagCard(text: item['content'].toString(), mode: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 400,
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 244, 239, 239),
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              leading: IconButton(
                icon:
                    new Icon(Icons.chevron_left, color: Colors.black, size: 30),
                onPressed: () {
                  Navigator.of(context)..pop();
                },
              ),
              centerTitle: true,
              title: Text(
                '更多Tags',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: new ListView(children: [
              Padding(
                  padding: EdgeInsets.only(top: 50, left: 20, right: 30),
                  child: Wrap(spacing: 0, runSpacing: 5, children: tagCardList))
            ]),
            bottomNavigationBar: Text("\n\n\n请选择你想要的一个Tag~ 下滑会有更多Tag~\n\n",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600))));
  }
}
