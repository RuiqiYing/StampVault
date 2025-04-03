import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mineTitleDetail.dart';
import 'package:http/http.dart' as http;

String judge1, judge2, judge3;
Color textcolor1, textcolor2, textcolor3;
String name1, name2, name3;
// ignore: camel_case_types
String uid;
List aList = [{}, {}, {}];
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
}

class mineTitleContent2 extends StatefulWidget {
  // const activityList({ Key? key }) : super(key: key);

  @override
  _mineTitleContent2State createState() => _mineTitleContent2State();
}

class _mineTitleContent2State extends State<mineTitleContent2> {
  @override
  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    setState(() {
      aList = [{}, {}, {}];
      judge1 = '未获得';
      judge2 = '未获得';
      judge3 = '未获得';
      name1 = "loading...";
      name2 = "loading...";
      name3 = "loading...";
      textcolor1 = Colors.black;
      textcolor2 = Colors.black;
      textcolor3 = Colors.black;
      initThisPage();
    });
  }

  Future<void> initThisPage() async {
    await _readShared();
    await getAllTitle();
  }

  getAllTitle() async {
    var url = Uri.parse(Api.url + '/cs1902/title/' + uid + '/2/all');
    var response =
        await http.get(url, headers: {"content-type": "application/json"});
    setState(() {
      aList = jsonDecode(Utf8Codec().decode(response.bodyBytes))['result'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildGrid(context);
  }
}

// ignore: missing_return
Widget buildGrid(BuildContext context) {
  List<Widget> tiles = [];
  Widget content;
  tiles.add(
    Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Text(
        '圈子界',
        style: TextStyle(fontSize: 18),
      ),
    ),
  );
  for (var i = 0; i < aList.length;) {
    int index = i;
    name1 = aList[i]['name'];
    name2 = aList[i + 1]['name'];
    name3 = aList[i + 2]['name'];
    if (name1 == null) {
      name1 = 'loading';
    }
    if (name2 == null) {
      name2 = 'loading';
    }
    if (name3 == null) {
      name3 = 'loading';
    }
    if (aList[i]['iget'] == false) {
      judge1 = '未获得';
      textcolor1 = Colors.black;
    } else {
      judge1 = '已获得';
      textcolor1 = Color(0xFFFCBA2A);
    }
    if (aList[i + 1]['iget'] == false) {
      judge2 = '未获得';
      textcolor2 = Colors.black;
    } else {
      judge2 = '已获得';
      textcolor2 = Color(0xFFFCBA2A);
    }
    if (aList[i + 2]['iget'] == false) {
      judge3 = '未获得';
      textcolor3 = Colors.black;
    } else {
      judge3 = '已获得';
      textcolor3 = Color(0xFFFCBA2A);
    }
    tiles.add(Column(children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 10),
        decoration:
            new BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 65,
              width: double.infinity,
              decoration:
                  new BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
              child: new Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 70,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => mineTitleDetail(
                                        iid: (index + 10).toString(),
                                      )));
                            },
                            child: Container(
                                decoration: new BoxDecoration(
                                    border: new Border.all(
                                        width: 3, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "lib/assets/titleImages/blue.jpg"),
                                        fit: BoxFit.cover)),
                                padding: const EdgeInsets.only(
                                    left: 20, bottom: 2, top: 2, right: 20),
                                child: Row(children: [
                                  Text(
                                    name1,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14,
                                    ),
                                  ),
                                ]))),
                        Text(name1,
                            style: TextStyle(
                              color: Color(0xFF000000),
                              decorationStyle: TextDecorationStyle.double,
                              fontWeight: FontWeight.w500,
                              textBaseline: TextBaseline.alphabetic,
                              fontSize: 14,
                              letterSpacing: 2,
                              wordSpacing: 10,
                              height: 1.2,
                            )),
                        Text(judge1,
                            style: TextStyle(
                              color: textcolor1,
                              decorationStyle: TextDecorationStyle.double,
                              fontWeight: FontWeight.w500,
                              textBaseline: TextBaseline.alphabetic,
                              fontSize: 10,
                              letterSpacing: 2,
                              wordSpacing: 10,
                              height: 1.2,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 70,
                      child: InkWell(
                          onTap: () {},
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  mineTitleDetail(
                                                    iid:
                                                        (index + 11).toString(),
                                                  )));
                                    },
                                    child: Container(
                                        decoration: new BoxDecoration(
                                            border: new Border.all(
                                                width: 3,
                                                color: Colors.black12),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "lib/assets/titleImages/blue.jpg"),
                                                fit: BoxFit.cover)),
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            bottom: 2,
                                            top: 2,
                                            right: 20),
                                        child: Row(children: [
                                          Text(
                                            name2,
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ]))),
                                Text(name2,
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
                                Text(judge2,
                                    style: TextStyle(
                                      color: textcolor2,
                                      decorationStyle:
                                          TextDecorationStyle.double,
                                      fontWeight: FontWeight.w500,
                                      textBaseline: TextBaseline.alphabetic,
                                      fontSize: 10,
                                      letterSpacing: 2,
                                      wordSpacing: 10,
                                      height: 1.2,
                                    ))
                              ]))),
                  SizedBox(
                      height: 70,
                      child: InkWell(
                          onTap: () {},
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  mineTitleDetail(
                                                    iid:
                                                        (index + 12).toString(),
                                                  )));
                                    },
                                    child: Container(
                                        decoration: new BoxDecoration(
                                            border: new Border.all(
                                                width: 3,
                                                color: Colors.black12),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "lib/assets/titleImages/blue.jpg"),
                                                fit: BoxFit.cover)),
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            bottom: 2,
                                            top: 2,
                                            right: 20),
                                        child: Row(children: [
                                          Text(
                                            name3,
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ]))),
                                Text(name3,
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
                                Text(judge3,
                                    style: TextStyle(
                                      color: textcolor3,
                                      decorationStyle:
                                          TextDecorationStyle.double,
                                      fontWeight: FontWeight.w500,
                                      textBaseline: TextBaseline.alphabetic,
                                      fontSize: 10,
                                      letterSpacing: 2,
                                      wordSpacing: 10,
                                      height: 1.2,
                                    ))
                              ]))),
                ],
              ),
            ),
          ],
        ),
      ),
    ]));
    i += 3;
  }
  content = new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: tiles,
  );
  return content;
}
