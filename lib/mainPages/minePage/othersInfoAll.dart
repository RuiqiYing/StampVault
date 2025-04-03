import 'package:code/mainPages/minePage/othersPost.dart';
import 'package:code/mainPages/minePage/othersSecondInfo.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'mineInfo.dart';

// ignore: camel_case_types
class othersAllPage extends StatefulWidget {
  final int id;
  othersAllPage({Key key, this.id}) : super(key: key);

  @override
  _othersAllPageState createState() => _othersAllPageState();
}

// ignore: camel_case_types
class _othersAllPageState extends State<othersAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          leading: IconButton(
            icon: new Icon(Icons.chevron_left, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.of(context)..pop();
            },
          ),
          title: Text(
            '用户信息',
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
                        child: Column(
                          children: <Widget>[
                            othersInfoPage(id: widget.id),
                            othersPostPage(id: widget.id)
                          ],
                        ),
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                ),
              ],
            )));

    // ignore: todo
    // TODO: implement wantKeepAlive
  }
}
