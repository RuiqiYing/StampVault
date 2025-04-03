import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'singleStamp.dart';

String uid;
List data = [];
var scrollController = new ScrollController();
Future _readShared() async {
  //获取当前登录用户的信息
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
  print(uid);
}

List<Widget> list = [];
int pagenum = 1;
final TextEditingController searchController = new TextEditingController();

String word = searchController.text;

class atlassearch extends StatefulWidget {
  @override
  _atlassearchState createState() => _atlassearchState();
}

class _atlassearchState extends State<atlassearch> {
  getData(String word) async {
    list.clear(); //清楚原本加载的数据，方便第二次加载
    data.clear();
    var url = Uri.parse(Api.url + '/cs1902/stamp/search/${uid}');
    var response = await http.post(url,
        headers: {"content-type": "application/json"},
        body: '{"pageNum": "${pagenum}",' +
            '"pageSize": "${100}","word":"${word}"} ');
    var datas = jsonDecode(Utf8Codec().decode(response.bodyBytes));
    data = datas["records"];
    print("atlas_search:${data}");
    setState(() {
      print(data);
      for (int i = 0; i < data.length; i++) {
        list.add(singleStamp(data[i]["stampName"], data[i]["image"],
            data[i]["isLike"], data[i]["stampId"], data[i]["isCollected"]));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 176, 210, 176),
            title: TextField(
                controller: searchController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 176, 210, 176))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 176, 210, 176))),
                    hintText: "搜索",
                    hintStyle: new TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w700))),
            leading: IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    word = searchController.text;
                    getData(word);
                  });
                },
              )
            ]),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(child: atlaslist(data, word)),
        ));
  }
}

//搜索结果展示
class atlaslist extends StatefulWidget {
  atlaslist(this.data, this.word);
  final List data;
  final String word;
  @override
  _atlaslistState createState() => _atlaslistState(data, word);
}

class _atlaslistState extends State<atlaslist> {
  int nums = 10;
  dynamic data;
  String word;
  bool isLoading = false;
  _atlaslistState(this.data, this.word);

  @override
  void initState() {
    super.initState();
    _readShared();
    pagenum = 1;
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("已经滑到最底部");
        Fluttertoast.showToast(msg: '加载中...');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
                runSpacing: 5,
                children: list,
              ))),
        ));
  }
}
