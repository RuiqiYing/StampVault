import 'package:code/mainPages/minePage/mineindividualSetting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../login/login.dart';

// ignore: camel_case_types
class mineSettingPage extends StatefulWidget {
  mineSettingPage();
  // minePage({Key key}) : super(key: key);

  @override
  _mineSettingPageState createState() => _mineSettingPageState();
}

// ignore: camel_case_types
class _mineSettingPageState extends State<mineSettingPage> {
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
            '我的设置',
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
                              height: 50,
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
                                            Container(child: (Text('版本号'))),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 15),
                                                child: Text(
                                                  'v1.0.1',
                                                  style: TextStyle(
                                                      color: Colors.black38),
                                                ))
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
                        height: 50,
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
                                      Container(child: (Text('关于我们'))),
                                      Container(
                                          margin: EdgeInsets.only(right: 15),
                                          alignment: Alignment(1, 0),
                                          child: Icon(Icons.chevron_right,
                                              color: Colors.black, size: 20))
                                    ]),
                              ],
                            )),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    mineindividualSettingPage()));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 1),
                            width: double.infinity,
                            height: 50,
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
                                          Container(child: (Text('个性化设置'))),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              child: Icon(Icons.chevron_right,
                                                  color: Colors.black,
                                                  size: 20))
                                        ]),
                                  ],
                                )),
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
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
                            '退出登录',
                            style: TextStyle(color: Colors.red, fontSize: 20),
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
}
