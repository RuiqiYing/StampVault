import 'dart:convert';

import 'package:code/assets/myIcons.dart';
import 'package:code/common/api.dart';
import 'package:code/mainPages/homePage/threeButton/topic/topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
//  热议话题

String content = "1111";
String createtime = "";
String tagid = "";

class hotTopic extends StatefulWidget {
  //hotTopic({Key? key}) : super(key: key);

  @override
  _hotTopicState createState() => _hotTopicState();
}

class _hotTopicState extends State<hotTopic> {
  List<dynamic> formlist = [];
  @override
  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    setState(() {
      initThisPage();
    });
  }

  initThisPage() async {
    formlist = [
      {
        "tagid": "" '数据加载中...',
        'content': '数据加载中...',
        'createtime': '数据加载中...',
      },
      {
        "tagid": "" '数据加载中...',
        'content': '数据加载中...',
        'createtime': '数据加载中...',
      },
      {
        "tagid": "" '数据加载中...',
        'content': '数据加载中...',
        'createtime': '数据加载中...',
      }
    ];
    await gethot();
  }
  

  gethot() async {
    var url = Uri.parse(Api.url + '/cs1902/tag/all');
    var response = await http.post(url,
        headers: {"content-type": "application/json"},
        body: '{"tagid": "' +
            tagid +
            '", "content": "' +
            content +
            '", "createtime": "' +
            createtime +
            '"}');
    setState(() {
      formlist = jsonDecode(utf8.decode(response.bodyBytes));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFFF4EFEF),
          ),
          child: Row(children: [
            Expanded(
                child: Text(
              '   热议话题',
              style: TextStyle(
                fontSize: 20,
              ),
            )),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => topicPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text('更多   '),
                ))
          ])),
      hotItem(
          title: formlist[0]['content'].toString(),
          num: formlist[0]['trend'].toString()),
      SizedBox(
        height: 5,
      ),
      hotItem(
          title: formlist[1]['content'].toString(),
          num: formlist[1]['trend'].toString()),
      SizedBox(
        height: 5,
      ),
      hotItem(
          title: formlist[2]['content'].toString(),
          num: formlist[2]['trend'].toString()),
    ]));
  }
}

class hotItem extends StatelessWidget {
  const hotItem({Key key, this.title, this.num}) : super(key: key);
  final String title;
  final String num;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.white),
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Text(
                '  ' + title,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Icon(
            MyIcons.hot,
            color: Colors.red[500],
          ),
          Text('  ' + num + '             '),
        ],
      ),
    );
  }
}
