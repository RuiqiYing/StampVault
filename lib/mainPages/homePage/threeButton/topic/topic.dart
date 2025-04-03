import 'dart:convert';

import 'package:code/assets/myIcons.dart';
import 'package:flutter/material.dart';
import 'package:code/common/api.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

//  热议话题

String imageUrl = "";
String title = "";
String uptime = "";
int id = 0;
int listLength = 0;
String content = "1111";
String createtime = "";
String tagid = "";
List<dynamic> formlist = [];

class topicPage extends StatefulWidget {
  // topicPage({Key? key}) : super(key: key);

  @override
  _topicPageState createState() => _topicPageState();
}

class _topicPageState extends State<topicPage> {
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
      formlist.sort((a, b) => (b['trend']).compareTo(a['trend']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: new Icon(Icons.chevron_left, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.of(context)..pop();
            },
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            '话题',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: new SingleChildScrollView(
            child: Container(
          color: Color(0xFFf4f4f4),
          child: Column(
            children: <Widget>[
              Container(
                  height: 120,
                  width: double.infinity,
                  child: Image.asset(
                    "lib/assets/images/hotTopicRank.jpg",
                    fit: BoxFit.cover,
                  )),
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFF4EFEF),
                        ),
                        child: Row(children: [
                          Expanded(
                              child: Text(
                            '  实时热榜，每分钟更新一次',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          )),
                        ])),
                    SizedBox(
                      height: 5,
                    ),
                    buildGrid(context)
                  ]))
            ],
          ),
        )));
  }
}

Widget buildGrid(BuildContext context) {
  List<Widget> tiles = [];
  Widget content;
  int count = 0;
  for (var item in formlist) {
    count++;
    tiles.add(InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => topicPage()));
        },
        child: Container(
            height: 40,
            child: Column(
              children: [
                Container(
                  height: 35,
                  decoration: new BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        count.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            '  #' + item['content'].toString() + '#',
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
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text(
                          '  ' + item['trend'].toString(),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ))));
  }
  content = new Column(
    children: tiles,
  );
  return content;
}

class topicItem extends StatelessWidget {
  const topicItem({Key key, this.title, this.num, this.serial})
      : super(key: key);
  final String title;
  final String num;
  final int serial;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.white),
      height: 40,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Text(serial.toString()),
          Expanded(
            child: Container(
              child: Text(
                '  ' + title + "",
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
          Text(
            '  ' + num + '             ',
          ),
        ],
      ),
    );
  }
}
