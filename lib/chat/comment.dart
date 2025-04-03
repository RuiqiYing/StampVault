import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String avatar = "";
String title = "";
String uptime = "";
int fansNum;
String userName = "";
int listLength = 0;
String userId;
List<dynamic> formlist = [];
List<dynamic> formlistTemp = [];
String myid;

Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
   myid = preferences.get('id');
}

class commentPage extends StatefulWidget {
  @override
  _commentPageState createState() => _commentPageState();
}

class _commentPageState extends State<commentPage> {



  getInfor() async {
    var url = Uri.parse('http://101.37.175.115:9833/cs1902/comment/getAll');
    formlist = [];
    var response = await http.get(url);
    print(response.body.toString());
    Map<String, dynamic> map;
    map = jsonDecode(utf8.decode(response.bodyBytes));
    formlistTemp = map['postData'];
    print('333333333333333333333333');
    print(formlistTemp);
    print("uid  " + myid.toString());
    for (var item in formlistTemp) {
      print("item['puid']" + item['puid'].toString());

      if (item['puid'].toString() == myid.toString()) {
        formlist.add(item);
      }
    }
    print(formlist);
    print(formlist.length);
    setState(() {});
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          buildGrid(context),
        ],
      ),
    );
  }
}

Widget buildGrid(BuildContext context) {
  List<Widget> tiles = [];
  Widget content;
  for (var item in formlist) {
    tiles.add(InkWell(
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
                  child: Image.network(item['avatarUrl'],
                      height: 50, width: 50, fit: BoxFit.cover)),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['username'],
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0,
                        letterSpacing: -1,
                        wordSpacing: -1),
                  ),
                  Text(
                    '评论了你：' + item['content'],
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
