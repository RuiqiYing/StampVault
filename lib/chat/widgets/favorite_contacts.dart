import 'dart:convert';

import 'package:code/chat/models/userModel.dart';
import 'package:code/common/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/messageModel.dart';
import '../chatCard.dart';

import 'package:http/http.dart' as http;

dynamic test;
DateTime time;
List aList;

List<User> favorites = [];

String UID;
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  UID = preferences.get('id');
}

class FavoriteContacts extends StatefulWidget {
  const FavoriteContacts({Key key}) : super(key: key);

  @override
  _FavoriteContactsState createState() => _FavoriteContactsState();
}

class _FavoriteContactsState extends State<FavoriteContacts> {
  void initState() {
    _readShared();
    favorites.clear();
    //初始化函数、带监听滑动功能
    super.initState();
    getAllFollows();
    getAllUser();
    // setState(() {
    //   initThisPage();
    // });
  }

  getAllFollows() async {
    var url = Uri.parse(Api.url + '/cs1902/follower/getAll');
    var response = await http.get(
      url,
      headers: {"content-type": "application/json"},
    );
    test = jsonDecode(response.body);
    aList = jsonDecode(Utf8Codec().decode(response.bodyBytes))['Data'];
    setState(() {
      for (var item in aList) {
        if (item['fid'] == int.parse(UID)) {
          favorites.add(User(id: item['uid']));
        }
      }
    });
  }

  getAllUser() async {
    var url = Uri.parse(Api.url + '/cs1902/user/getAll');
    var response = await http.get(
      url,
      headers: {"content-type": "application/json"},
    );
    test = jsonDecode(response.body);
    aList = jsonDecode(Utf8Codec().decode(response.bodyBytes))['Data'];
    setState(() {
      for (var item in aList) {
        for (int i = 0; i < favorites.length; ++i) {
          if (item['uid'] == favorites[i].id) {
            favorites[i].name = item['username'].toString();
            favorites[i].imageUrl = item['avatarUrl'].toString();
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '我的关注',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                  ),
                  iconSize: 15.0,
                  color: Colors.blueGrey,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            height: 100.0,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        user: favorites[index],
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage:
                              NetworkImage(favorites[index].imageUrl),                              
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          favorites[index].name,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
