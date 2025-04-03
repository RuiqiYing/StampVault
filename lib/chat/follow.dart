import 'package:code/mainPages/minePage/othersInfoAll.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String uid = "1";
String avatar = "";
String title = "";
String uptime = "";
int id = 0;
int fansNum;
String userName = "";
int listLength = 0;
String userId;

List<dynamic> formlist = [];

Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
}

class followPage extends StatefulWidget {
  //const followPage({ Key? key }) : super(key: key);

  @override
  _followPageState createState() => _followPageState();
}

class _followPageState extends State<followPage> {
  Future<void> initThisPage() async {
    await _readShared();
  }

  getInfor() async {
    var url = Uri.parse(Api.url + '/cs1902/follower/' + uid);
    var response = await http.post(url);
    print(response.body.toString());
    formlist = jsonDecode(response.body);
    listLength = formlist.length;
    print('Response body: ${response.body}');
    setState(() {
      formlist = jsonDecode(utf8.decode(response.bodyBytes));
      print(listLength);
    });
  }
  
  @override
  Future<void> initState() {
    getInfor();
    super.initState();
    setState(() {
      initMesPage();
    });
  }

  Future<void> initMesPage() async {
    await _readShared();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
          child: buildGrid(context),
        )
      ],
    ));
  }
}

Widget buildGrid(BuildContext context) {
  List<Widget> tiles = [];
  Widget content;
  for (var item in formlist) {
    tiles.add(InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => othersAllPage(
                        id: item['id'],
                      )));
        },
        child: Container(
          // height: 130.0,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  ClipOval(
                      child: Image.network(item['avatar'],
                          height: 50, width: 50, fit: BoxFit.cover)),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['userName'],
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                            letterSpacing: -1,
                            wordSpacing: -1),
                      ),
                      Text(
                        '粉丝数：' + item['fansNum'],
                      )
                    ],
                  )),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                ),
              ),
            ],
          ),
        )));
  }
  content = new Column(
    children: tiles,
  );
  return content;
}
