import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String title = "数据加载中...";
String uptime = "数据加载中...";
String content = "数据加载中...";

class inforDetail extends StatefulWidget {
  final String id;
  inforDetail({Key key, this.id}) : super(key: key);

  @override
  _inforDetailState createState() => _inforDetailState();
}

class _inforDetailState extends State<inforDetail> {
  Map getlist = {};

  @override
  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    setState(() {
      initThisPage();
    });
  }

  initThisPage() async {
    await getInforDetial();
  }

  getInforDetial() async {
    var url = Uri.parse(Api.url + '/cs1902/information/' + widget.id);
    var response = await http.get(url);
    setState(() {
      getlist = jsonDecode(Utf8Codec().decode(response.bodyBytes)); // body
      if (getlist['title'] != null) {
        title = getlist['title'];
      }
      if (getlist['content'] != null) {
        content = getlist['content'];
      }
      if (getlist['uptime'] != null) {
        uptime = getlist['uptime'].toString().substring(0, 10);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            '资讯详情',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: new Icon(Icons.chevron_left, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.of(context)..pop();
            },
          ),
        ),
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverList(
              delegate: new SliverChildListDelegate(
                [
                  Container(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      color: Color.fromARGB(255, 244, 239, 239),
                      //上下左右各添加16像素补白
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 176, 210, 176),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(2.0, 2.0), //阴影xy轴偏移量
                                    blurRadius: 5.0, //阴影模糊程度
                                    spreadRadius: 1.0 //阴影扩散程度
                                    )
                              ],
                            ),
                            child: Image(
                                height: 142,
                                width: 255,
                                image: NetworkImage(
                                    getlist['imageUrl'].toString()),
                                fit: BoxFit.cover
                                // centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                                ),
                          ),
                          Text(
                            title,
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 5),
                              alignment: Alignment.bottomRight,
                              child: Text(
                                uptime,
                                style: TextStyle(fontSize: 13),
                              )),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10, top: 10, right: 10, bottom: 10),
                              decoration: new BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(15.0)),
                              ),
                              child: Text(
                                "  " + content,
                                style: TextStyle(fontSize: 15),
                              ))
                        ],
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
