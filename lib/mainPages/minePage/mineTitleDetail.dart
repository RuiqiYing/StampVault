import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:code/mainPages/minePage/mineTitleAll.dart';
import 'package:code/mainPages/minePage/mineTitleTop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;

String type = 'lib/assets/titleImages/bronze.jpg';
String uid;
Color buttonColor = Colors.grey;
Map aList, aList2;
String use = '未获得';
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
}

bool flag = false;

// ignore: camel_case_types
class mineTitleDetail extends StatefulWidget {
  final String iid;
  mineTitleDetail({Key key, this.iid}) : super(key: key);

  @override
  _mineTitleDetail createState() => _mineTitleDetail();
}

// ignore: camel_case_types
class _mineTitleDetail extends State<mineTitleDetail> {
  Future<void> initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    setState(() {
      initThisPage();
    });
  }

  initThisPage() async {
    aList = {
      'name': "loading",
      'uptime': 'loading',
      'get_time': 'loading',
      'ttype': '1',
      'content': 'loading'
    };
    aList2 = {
      'name': 'loading',
      'title': {'title_type': '1', 'title_name': 'loading'},
      'avatar_url': 'loading',
      'fans_num': '0',
      'subscribe_num': '0',
      'post_num': '0'
    };
    await _readShared();
    await getTitleDetail();
    await getAllTitle();
  }

  changeMyTitle() async {
    var url = Uri.parse(Api.url + '/cs1902/user/change/' + uid);
    var response = await http.post(url,
        headers: {"content-type": "application/json"},
        body: '{"uid": "${uid}", "tid": "' + widget.iid + '"}');
    setState(() {
      Fluttertoast.showToast(
        msg: '修改成功',
        gravity: ToastGravity.BOTTOM,
      );
      flag = true;
      use = "使用中";
      buttonColor = Colors.grey;
    });
  }

  getAllTitle() async {
    var url = Uri.parse(Api.url + '/cs1902/user/info/' + uid);
    var response =
        await http.get(url, headers: {"content-type": "application/json"});
    setState(() {
      aList2 = jsonDecode(Utf8Codec().decode(response.bodyBytes));
      if (aList2['title']['title_name'] == aList['name']) {
        use = "使用中";
        buttonColor = Colors.grey;
        flag = true;
      } else if (aList['iget'] != true) {
        use = "未获得";
        buttonColor = Colors.grey;
      } else {
        use = "立即更换";
        buttonColor = Colors.orange;
      }
    });
  }

  getTitleDetail() async {
    var url = Uri.parse(
        Api.url + '/cs1902/title/getDetail/' + widget.iid + '/' + uid);
    var response =
        await http.get(url, headers: {"content-type": "application/json"});
    setState(() {
      aList = jsonDecode(Utf8Codec().decode(response.bodyBytes));
      if (aList['type'] == '1') {
        type = 'lib/assets/titleImages/bronze.jpg';
      } else {
        type = 'lib/assets/titleImages/blue.jpg';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: new Icon(Icons.chevron_left, color: Colors.black, size: 30),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return mineTitleAllPage();
                }));
              }),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            '我的称号',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
            decoration:
                new BoxDecoration(color: Color.fromARGB(255, 176, 210, 176)),
            // child: rotationChart(),
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverList(
                  delegate: new SliverChildListDelegate(
                    [
                      Container(
                        child: Column(
                          children: <Widget>[
                            Column(children: [
                              Container(
                                  alignment: Alignment.center,
                                  child: Column(children: [
                                    Container(
                                        width: 200,
                                        margin: const EdgeInsets.only(
                                            bottom: 5, top: 20),
                                        decoration: new BoxDecoration(
                                            border: new Border.all(
                                                width: 5,
                                                color: Colors.black12),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: AssetImage(type),
                                                fit: BoxFit.cover)),
                                        padding: const EdgeInsets.only(
                                          bottom: 5,
                                          top: 5,
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                aList['name'],
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ])),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        aList['name'],
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ),
                                    )
                                  ])),
                              Container(
                                  width: double.infinity,
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: const EdgeInsets.only(
                                            bottom: 30, top: 20, left: 20),
                                        child: Text('领取规则:'),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        height: 490,
                                        margin: const EdgeInsets.only(left: 40),
                                        child: Text(aList['content']),
                                      ),
                                      Container(
                                          child: InkWell(
                                        onTap: () {
                                          if (use == "立即更换") {
                                            changeMyTitle();
                                          }
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 10,
                                              top: 10,
                                              left: 40,
                                              right: 40),
                                          padding: const EdgeInsets.only(
                                              bottom: 10, top: 10),
                                          decoration: new BoxDecoration(
                                            color: buttonColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            use,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                            ])
                          ],
                        ),
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                ),
              ],
            )));
  }

  // ignore: todo
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
}
