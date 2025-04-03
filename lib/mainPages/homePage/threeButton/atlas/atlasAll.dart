import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:code/mainPages/homePage/threeButton/atlas/singleStamp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String uid;
List data = [];
var scrollController = new ScrollController();
Future _readShared() async {
  //获取当前用户的用户信息
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
  print(uid);
}

class atlasAll extends StatelessWidget {
  atlasAll({Key key, this.sortname, this.id}) : super(key: key);
  final String sortname;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          leading: IconButton(
            icon: new Icon(Icons.chevron_left, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.of(context)..pop();
            },
          ),
          centerTitle: true,
          title: Text(
            sortname,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: atlaslist(data, sortname, id));
  }
}

List<Widget> list;
int pagenum = 1;

class atlaslist extends StatefulWidget {
  atlaslist(this.data, this.sortname, this.id);
  final List data;
  final String sortname;
  final String id;
  @override
  _atlaslistState createState() => _atlaslistState(data, sortname, id);
}

class _atlaslistState extends State<atlaslist> {
  List<Widget> list = [];
  dynamic data;
  String sortname;
  String id;
  bool isLoading = false;
  _atlaslistState(this.data, this.sortname, this.id);

  _getData(String id) async {
    //判断传入的信息来决定后端接口的调用
    String bigsortname = id;
    var url = Uri.parse(Api.url + '/cs1902/stamp/all');
    var response;
    if (id == "type" || //各种分类情况
        id == "era" ||
        id == "author" ||
        id == "printer" ||
        id == "format") {
      response = await http.post(url,
          headers: {"content-type": "application/json"},
          body: '{"uid": "${uid}", "pageNum": "${pagenum}",' +
              '"pageSize": "${10}","${bigsortname}":"${sortname}"} ');
    } else if (id == "all") {
      //全图鉴情况
      response = await http.post(url,
          headers: {"content-type": "application/json"},
          body: '{"uid": "${uid}", "pageNum": "${pagenum}",' +
              '"pageSize": "${10}"} ');
    } else if (id == "like") {
      //我收藏的邮票情况
      url = Uri.parse(Api.url + '/cs1902/stamp/${uid}/like');
      response = await http.post(url);
    } else if (id == "collected") {
      //我的图鉴情况
      url = Uri.parse(Api.url + '/cs1902/stamp/collection/${uid}');
      response = await http.get(url);
    }
    //不同情况下对不同数据的处理
    if (id != "like" && id != "collected") {
      var datas = jsonDecode(Utf8Codec().decode(response.bodyBytes));
      print(datas);
      data = datas["records"];
    } else {
      data = jsonDecode(Utf8Codec().decode(response.bodyBytes));
    }
    print("atlas:${data}");
    setState(() {
      for (int i = 0; i < 10; i++) {
        if (i >= data.length) break;
        list.add(singleStamp(data[i]["stampName"], data[i]["image"],
            data[i]["isLike"], data[i]["stampId"], data[i]["isCollected"]));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _readShared(); //调用函数获取当前登录用户信息
    pagenum = 1;
    _getData(id);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("已经滑到最底部");
        Fluttertoast.showToast(msg: '加载中...');
        _getMore(); //获取更多函数
      }
    });
  }

  Future _getMore() async {
    //加载更多函数
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 1), () {
        print("加载更多");
        setState(() {
          pagenum++; //后端数据翻页得到数据
          _getData(id);
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 244, 239, 239),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                  child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runAlignment: WrapAlignment.center,
                runSpacing: 20,
                children: list,
              ))),
        ));
  }
}
