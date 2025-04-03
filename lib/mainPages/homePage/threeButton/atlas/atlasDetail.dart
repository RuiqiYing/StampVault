import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var data;
var scrollController = new ScrollController();
String uid;
//初始化展示数据
String stampName = "邮票名称",
    stampImage = "邮票样式",
    stampAuthor = "邮票设计者",
    stampPrint = "邮票印刷厂",
    stampType = "邮票类别",
    stampEra = "邮票年代";
//获取当前登录用户信息
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
}

class atlasDetail extends StatefulWidget {
  atlasDetail(this.sid, this.islike);
  final String sid;
  bool islike;

  @override
  _atlasDetailState createState() => _atlasDetailState(sid, islike);
}

class _atlasDetailState extends State<atlasDetail> {
  final String sid;

  bool islike;
  _atlasDetailState(this.sid, this.islike);

//喜欢动作函数
  _like() async {
    //Paramr
    var url =
        Uri.parse(Api.url + '/cs1902/stamp/${sid}/star?uid=' + uid.toString());
    var response = await http.get(url);
    setState(() {
      islike = !islike;
    });
  }

//获取数据函数
  _getData() async {
    //Paramr
    var url = Uri.parse(
        Api.url + '/cs1902/stamp/' + sid.toString() + '?uid=' + uid.toString());
    print(url);
    var response = await http.get(url);
    data = jsonDecode(Utf8Codec().decode(response.bodyBytes));
    print("atlasDetail:${data}");
    setState(() {
      //判断传入数据是否为空，若非空则展示，若为空则显示为未知
      if (data["stampName"] != null)
        stampName = data["stampName"];
      else
        stampName = "未知";
      if (data["stampImage"] != null)
        stampImage = data["stampImage"];
      else
        stampImage = "未知";
      if (data["stampAuthor"] != null)
        stampAuthor = data["stampAuthor"];
      else
        stampAuthor = "未知";
      if (data["stampPrint"] != null)
        stampPrint = data["stampPrint"];
      else
        stampPrint = "未知";
      if (data["stampType"] != null)
        stampType = data["stampType"];
      else
        stampType = "未知";
      if (data["stampEra"] != null)
        stampEra = data["stampEra"];
      else
        stampEra = "未知";
    });
  }

  @override
  void initState() {
    //初始化函数
    super.initState();
    setState(() {
      _readShared();
      _getData();
      print("object11111");
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          print("已经滑到最底部");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 176, 210, 176),
          title: Text(
            stampName,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context, islike);
              }),
          actions: <Widget>[
            IconButton(
                icon: islike == true
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  _like();
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Detail(),
        ));
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.all(30),
        child: Column(
            //邮票信息
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "邮票样式",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Image.network(stampImage, height: 300, fit: BoxFit.cover),
              Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 9, bottom: 9),
                alignment: Alignment.topLeft,
                decoration: new BoxDecoration(
                    border: new Border.all(color: Color(0xFFDDDDDD), width: 2)),
                child: (Column(
                  children: [
                    Row(children: [
                      Icon(Icons.sort, color: Colors.black, size: 24),
                      SizedBox(width: 4),
                      Text(
                        '邮票类别:',
                      )
                    ]),
                    Text(stampType,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ],
                )),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 9, bottom: 9),
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 5),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Color(0xFFDDDDDD), width: 2)),
                child: Column(children: [
                  Row(children: [
                    Icon(Icons.hourglass_bottom, color: Colors.black, size: 24),
                    SizedBox(width: 4),
                    Text(
                      '邮票年代:',
                    ),
                  ]),
                  Text(stampEra,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                      ))
                ]),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 9, bottom: 9),
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 5),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Color(0xFFDDDDDD), width: 2)),
                child: Column(children: [
                  Row(children: [
                    Icon(Icons.person_outline_outlined,
                        color: Colors.black, size: 24),
                    SizedBox(width: 4),
                    Text(
                      '邮票设计者:',
                    ),
                  ]),
                  Text(stampAuthor,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                      ))
                ]),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 9, bottom: 9),
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 5),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Color(0xFFDDDDDD), width: 2)),
                child: Column(children: [
                  Row(children: [
                    Icon(Icons.print, color: Colors.black, size: 24),
                    SizedBox(width: 4),
                    Text(
                      '邮票印刷厂:',
                    )
                  ]),
                  Text(stampPrint,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                      ))
                ]),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 9, bottom: 9),
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 5),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Color(0xFFDDDDDD), width: 2)),
                child: Column(children: [
                  Row(children: [
                    Icon(Icons.remove_red_eye_outlined,
                        color: Colors.black, size: 24),
                    SizedBox(width: 4),
                    Text(
                      '邮票背景:',
                    ),
                  ]),
                  Text("暂无",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                      ))
                ]),
              ),
            ]));
  }
}
