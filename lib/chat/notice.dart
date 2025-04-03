import 'package:flutter/material.dart';
import 'chatCard.dart';
import 'smallChatCard.dart';


class noticePage extends StatefulWidget {
  //const noticePage({ Key? key }) : super(key: key);

  @override
  _noticePageState createState() => _noticePageState();
}

class _noticePageState extends State<noticePage> {
  @override
  Widget build(BuildContext context) {
    return   Container(
            // height: 130.0,
            child: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              SizedBox( 
                width: 20,
              ),
              ClipOval(
                  child: Image.asset("lib/assets/face/ChinaPost.jpg",
                      height: 50, width: 50, fit: BoxFit.cover)),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   '柚子官方',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0,
                        letterSpacing: -1,
                        wordSpacing: -1),
                  ),
                  Text(
                   '恭喜你成为第3个小柚子',
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
      ),);
  }
}