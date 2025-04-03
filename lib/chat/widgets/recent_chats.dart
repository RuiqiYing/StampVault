import 'package:code/chat/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/messageModel.dart';
import '../chatCard.dart';
import 'dart:convert';
import 'package:code/common/api.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

String myid = '111';
int listLength = 0;
//最近聊天、聊天列表
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  myid = preferences.get('id');
}

List<Message> a = chats;

class RecentChats extends StatefulWidget {
  @override
  _RecentChatsState createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  List<dynamic> formlist = [];
  List<User> userList = [];
  List<Message> chatList = [];
  
  getInfor() async {
    var url = Uri.parse(Api.url + '/cs1902/message/list/' + myid);

    var response = await http.post(url);
    print('object');
    formlist = jsonDecode(response.body);
    listLength = formlist.length;
    //print('Response body: ${response.body}');
    setState(() {
      formlist = jsonDecode(utf8.decode(response.bodyBytes));
      print(formlist);
    });
    for (var item in formlist) {
      User temp = User(
        id: int.parse(item['uid']),
        name: item['username'],
        imageUrl: item['avatar'],
      );
      bool rTemp;
      if (item['unread'] != 0) {
        rTemp = true;
      } else {
        rTemp = false;
      }
      Message mTemp = Message(
        sender: temp,
        time: item['last_time'].toString().substring(5, 16),
        text: item['content'],
        unread: rTemp,
      );
      userList.add(temp);
      chatList.add(mTemp);
      print(chatList);
    }
    print(userList);
    print(a);
  }

  @override
  Future<void> initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    getInfor();
    // setState(() {
      initThisPage();
    // });
  }

  @override
  Future<void> initThisPage() async {
    await _readShared();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
            itemCount: chatList.length,
            itemBuilder: (BuildContext context, int index) {
              print(index);
              final Message chat = chatList[index];
              return GestureDetector(
                onTap: () {
                  print(chat.unread);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        user: chat.sender,
                      ),
                    ),
                  );
                  setState(() {
                    if (chat.unread) {
                      chat.unread = false;
                    }
                  }); 
                },
                child: Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage: NetworkImage(chat.sender.imageUrl == null? " ": chat.sender.imageUrl),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                chat.sender.name,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                  chat.text,
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            chat.time,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 9.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          chat.unread
                              ? Container(
                                  width: 40.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'NEW',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Text(''),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
