import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

bool flag1 = false;
bool flag2 = false;
bool flag3 = false;
String uid;
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
}

// ignore: camel_case_types
class mineindividualSettingPage extends StatefulWidget {
  mineindividualSettingPage();
  // minePage({Key key}) : super(key: key);

  @override
  _mineindividualSettingPageState createState() =>
      _mineindividualSettingPageState();
}

// ignore: camel_case_types
class _mineindividualSettingPageState extends State<mineindividualSettingPage> {
  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    setState(() {
      initThisPage();
    });
  }

  initThisPage() async {
    await _readShared();
    var url = Uri.parse(Api.url + '/cs1902/profile/individualInfo/' + uid);
    var response = await http.get(
      url,
      headers: {"content-type": "application/json"},
    );
    setState(() {
      flag1 = jsonDecode(response.body)[0]['showStamp'] == 1 ? true : false;
      flag2 = jsonDecode(response.body)[0]['showCommunity'] == 1 ? true : false;
      flag3 = jsonDecode(response.body)[0]['openMessage'] == 1 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          leading: IconButton(
            icon: new Icon(Icons.chevron_left, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.of(context)..pop();
            },
          ),
          title: Text(
            '个性化设置',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
            decoration: new BoxDecoration(color: Color(0xFFF4EFEF)),
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
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: double.infinity,
                              decoration: new BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 15, left: 20, bottom: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(child: (Text('开放私信'))),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              child: CupertinoSwitch(
                                                value: flag3,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    flag3 = value;
                                                  });
                                                },
                                              ),
                                            )
                                          ]),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 1),
                        width: double.infinity,
                        decoration: new BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Container(
                            margin: const EdgeInsets.only(
                                top: 15, left: 20, bottom: 15),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(child: (Text('开放邮票展示'))),
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: CupertinoSwitch(
                                          value: flag1,
                                          onChanged: (bool value) {
                                            setState(() {
                                              flag1 = value;
                                            });
                                          },
                                        ),
                                      )
                                    ]),
                              ],
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 1),
                        width: double.infinity,
                        decoration: new BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Container(
                            margin: const EdgeInsets.only(
                                top: 15, left: 20, bottom: 15),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(child: (Text('开放我的圈子'))),
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: CupertinoSwitch(
                                          value: flag2,
                                          onChanged: (bool value) {
                                            setState(() {
                                              flag2 = value;
                                            });
                                          },
                                        ),
                                      )
                                    ]),
                              ],
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          fixMyIndivdualInfo();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 20),
                          width: double.infinity,
                          height: 50,
                          decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          child: Container(
                              child: (Text(
                            '确定修改',
                            style: TextStyle(color: Colors.green, fontSize: 20),
                          ))),
                        ),
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

  void fixMyIndivdualInfo() async {
    int s1 = flag1 == true ? 1 : 0;
    int s2 = flag2 == true ? 1 : 0;
    int s3 = flag3 == true ? 1 : 0;
    var url = Uri.parse(Api.url + '/cs1902/profile/individualInfo/');
    var response = await http.post(url,
        headers: {"content-type": "application/json"},
        body: jsonEncode({
          'id': uid,
          "show_stamp": s1,
          "show_community": s2,
          "open_message": s3
        }));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: '修改成功',
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
