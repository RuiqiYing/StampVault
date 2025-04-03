import 'package:flutter/material.dart';
import 'chatCard.dart';
import 'models/messageModel.dart';

class smallChatCard extends StatelessWidget {
  final String title;
  final String date;
  final String content;
  final String faceRoute;
  // final VoidCallback onPressed;

  smallChatCard(
      {Key key,
      this.title,
      // this.onPressed,
      this.date,
      this.content,
      this.faceRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {MaterialPageRoute(builder: (context) => ChatScreen());},
        child: SizedBox(
            height: 80,
            child: Column(children: <Widget>[
              Row(children: <Widget>[
                SizedBox(width: 20),
                ClipOval(
                    child: Image.asset(faceRoute,
                        height: 50, width: 50, fit: BoxFit.cover)),
                SizedBox(width: 20),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(title,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16.0,
                              letterSpacing: -1,
                              wordSpacing: -1)),
                      Text(content)
                    ])),
                Text(date, style: TextStyle()),
                SizedBox(width: 20)
              ]),
              Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Divider(color: Colors.black12))
            ])));
  }
}
