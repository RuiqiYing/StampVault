import 'package:code/assets/myIcons.dart';
import 'package:code/chat/comment.dart';
import 'package:code/chat/follow.dart';
import 'package:code/chat/notice.dart';
import 'package:code/chat/private.dart';

import 'package:flutter/material.dart';

class chatPage extends StatefulWidget {
  // chatPage({Key? key}) : super(key: key);

  @override
  _chatPageState createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    
                    Navigator.pop(context);
                  }),
              title: Text('消息',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  )),
              // actions: <Widget>[barIcon()],
              backgroundColor: Color.fromARGB(255, 176, 210, 176),
              elevation: 0.5,
              bottom: TabBar(
                  unselectedLabelColor: Colors.white60,
                  indicatorColor: Colors.black54,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: <Widget>[
                    Tab(child: tabIcon(title: '私信', icon: Icons.markunread)),
                    Tab(child: tabIcon(title: '评论', icon: Icons.markunread)),
                    Tab(child: tabIcon(title: '关注', icon: Icons.markunread)),
                    Tab(child: tabIcon(title: '通知', icon: Icons.markunread))
                  ])),
          body: TabBarView(children: <Widget>[
            privatePage(),
            commentPage(),
            followPage(),
            noticePage()
          ]),
        ));
  }
}

class tabIcon extends StatelessWidget {
  const tabIcon({Key key, this.icon, this.title}) : super(key: key);
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Container(child: Icon(icon)), Text(title,  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  ))],
      ),
    );
  }
}

class barIcon extends StatefulWidget {
  //const barIcon({ Key? key }) : super(key: key);

  @override
  _barIconState createState() => _barIconState();
}

class _barIconState extends State<barIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(Icons.cake),
          SizedBox(width: 30),
        ],
      ),
    );
  }
}
