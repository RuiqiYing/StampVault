import 'package:code/chat/widgets/recent_chats.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat.dart';
import 'models/userModel.dart';
import 'models/messageModel.dart';
import 'package:code/common/api.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

//聊天页面
String myid = '';
int listLength = 0;

Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  myid = preferences.get('id');
}

final TextEditingController chatTextController = new TextEditingController();
String chatText;
var today = DateTime.now();

class ChatScreen extends StatefulWidget {
  final User user;

  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<dynamic> formlist = [];
  List<Message> messagesList = [];
  getInfor() async {
    currentUser.id = int.parse(myid);
    print(myid);
    var url = Uri.parse(
        Api.url + '/cs1902/message/' + widget.user.id.toString() + "/" + myid);

    var response = await http.post(url);
    formlist = jsonDecode(response.body);
    listLength = formlist.length;
    setState(() {
      formlist = jsonDecode(utf8.decode(response.bodyBytes));
      print(formlist);
    });
    for (var item in formlist) {
      print(item);
      User temp;
      print("!!!!!!!!" + myid);
      print("''''''''''''''''" + item['sender'].toString());
      if (item['sender'].toString() == myid) {
        temp = currentUser;
      } else {
        temp = widget.user;
      }
      bool rTemp;
      if (item['unread'] != 0) {
        rTemp = false;
      } else {
        rTemp = true;
      }
      Message mTemp = Message(
        sender: temp,
        time: item['time'].toString().substring(5, 16),
        text: item['content'],
      );
      messagesList.add(mTemp);
    }
    print('messageList' + messagesList.length.toString());
    print(messagesList);
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

  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
        margin: isMe
            ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
            : EdgeInsets.only(top: 8.0, bottom: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
            color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0))
                : BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0))),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(message.time,
                  style: TextStyle(
                      color: isMe ? Colors.white : Colors.blueGrey,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 8.0),
              Text(message.text,
                  style: TextStyle(
                      color: isMe ? Colors.white : Colors.blueGrey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600))
            ]));
    if (isMe) return msg;
    return Row(children: <Widget>[msg]);
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.photo),
              iconSize: 25.0,
              color: Color.fromARGB(255, 176, 210, 176),
              onPressed: () {}),
          Expanded(
              child: TextField(
                  controller: chatTextController,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) {},
                  decoration: InputDecoration.collapsed(
                      hintText: 'Send a message...',
                      hintStyle: TextStyle(color: Colors.black)))),
          IconButton(
              icon: Icon(Icons.send),
              iconSize: 25.0,
              color: Color.fromARGB(255, 176, 210, 176),
              onPressed: () {
                chatText = chatTextController.text;
                if (chatText != null) {
                  chatTextController.clear();
                  var date1 = today.millisecondsSinceEpoch;
                  var date2 = DateTime.fromMillisecondsSinceEpoch(date1);
                  var newMessage = new Message();
                  newMessage.sender = currentUser;
                  newMessage.text = chatText;
                  newMessage.unread = true;
                  newMessage.time = date2.toString().substring(11, 16);
                  _messageRequest(widget.user.id.toString(),
                      currentUser.id.toString(), chatText, context);
                  setState(() {
                    messagesList.add(newMessage);
                  });
                }
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 176, 210, 176),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 176, 210, 176),
        title: Text(
          widget.user.name,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
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
                    padding: EdgeInsets.only(top: 15.0),
                    itemCount: messagesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Message message;
                      message = messagesList[index];
                      final bool isMe = message.sender == currentUser;
                      return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}

_messageRequest(
    String fromID, String toID, String content, BuildContext context) async {
  var url = Uri.parse(Api.url + '/cs1902/message/send');
  var response = await http.post(url,
      headers: {"content-type": "application/json"},
      body: '{"fromID": "${fromID}", "toID": "${toID}",' +
          '"content": "${content}"}');
  // updateCookie(response);
  var data = jsonDecode(Utf8Codec().decode(response.bodyBytes));
  var result = data["result"];
  print('Response body: ${data}');
}
