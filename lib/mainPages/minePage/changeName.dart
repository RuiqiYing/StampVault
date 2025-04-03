import 'dart:convert';
import 'package:code/common/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final TextEditingController nameController = new TextEditingController();
String uid;
String Name;
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
}

bool flag = false;

// ignore: camel_case_types
class changeNamePage extends StatefulWidget {
  changeNamePage();
  // minePage({Key key}) : super(key: key);

  @override
  _changeNameState createState() => _changeNameState();
}

List aList;

class _changeNameState extends State<changeNamePage> {
  @override
  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    setState(() {
      initThisPage();
    });
  }

  Future<void> initThisPage() async {
    await _readShared();
    nameController.text = "加载中";
    await _getUserName();
    flag = false;
    // await getAllTitle();
  }

  _getUserName() async {
    var url = Uri.parse(Api.url + '/cs1902/user/name/' + uid);
    var response =
        await http.get(url, headers: {"content-type": "application/json"});
    setState(() {
      nameController.text = response.body;
    });
  }

  _fixUserName() async {
    var url = Uri.parse(Api.url + '/cs1902/user/name/' + uid);
    var response = await http.post(url,
        headers: {"content-type": "application/json"},
        body: jsonEncode({'username': nameController.text.toString()}));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: '修改成功',
        gravity: ToastGravity.BOTTOM,
      );
    }
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
              Navigator.of(context)
                  .pop({"flag": flag, "name": nameController.text.toString()});
            },
          ),
          title: Text(
            '修改名称',
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
                                        Container(child: (Text('我的昵称'))),
                                        SizedBox(width: 50),
                                        Expanded(
                                          child: TextField(
                                            controller: nameController,
                                            decoration: InputDecoration(),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                      ]),
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            _fixUserName();
                            setState(() {
                              flag = true;
                            });

                            print(flag);
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
                              '确定',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 20),
                            ))),
                          ),
                        )
                      ],
                    ),
                  ),
                ])));
  }
}


// ignore: camel_case_types
