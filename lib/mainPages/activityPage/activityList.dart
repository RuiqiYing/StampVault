import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'activityDetialAll.dart';
import 'package:http/http.dart' as http;

dynamic test;
DateTime time;
List aList = [{}, {}];

// ignore: camel_case_types
class activityList extends StatefulWidget {
  // const activityList({ Key? key }) : super(key: key);

  @override
  _activityListState createState() => _activityListState();
}

Widget buildGrid(BuildContext context) {
  List<Widget> tiles = [];
  Widget content;
  for (var item in aList) {
    tiles.add(new Container(
        width: double.infinity,
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => activityDetialAll(
                              id: item['id'].toString(),
                            )));
              },
              child: Container(
                alignment: Alignment.bottomRight,
                height: 152,
                width: 358,
                decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2.0, 2.0), //阴影xy轴偏移量
                          blurRadius: 5.0, //阴影模糊程度
                          spreadRadius: 1.0 //阴影扩散程度
                          )
                    ],
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(15.0)),
                    image: DecorationImage(
                        image: NetworkImage(item['cover'].toString()),
                        fit: BoxFit.cover
                        // centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        )),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 12.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(15.0)),
                    color: Color(0xFF8ECC9C),
                  ),
                  height: 25,
                  width: 74,
                  child: Text(
                    '点击参与',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 9,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Text(item['title'].toString(),
                    style: TextStyle(
                      decorationStyle: TextDecorationStyle.double,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      height: 1.2,
                    ))),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Row(
                        children: [
                          Icon(Icons.access_alarm),
                          Text(
                            item['date'].toString(),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    new Row(children: [
                      Icon(
                        Icons.whatshot,
                        color: Colors.red,
                      ),
                      Text(
                        item['hot'].toString(),
                        style: TextStyle(fontSize: 12),
                      )
                    ])
                  ],
                )
              ],
            )
          ],
        )));
  }
  
  content = new Column(
    children: tiles,
  );
  return content;
}

class _activityListState extends State<activityList> {
  @override
  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    getAllActivity();
  }

  getAllActivity() async {
    var url = Uri.parse(Api.url + '/cs1902/activity/all');
    var response = await http.get(
      url,
      headers: {"content-type": "application/json"},
    );
    print(response.body.toString());
    print('Response body: ${response.body}');
    test = jsonDecode(response.body);
    setState(() {
      aList = jsonDecode(Utf8Codec().decode(response.bodyBytes))['result'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildGrid(context);
  }
}
