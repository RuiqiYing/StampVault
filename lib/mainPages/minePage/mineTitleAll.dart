import 'package:code/mainPages/minePage/mineTitleContent2.dart';
import 'package:code/mainPages/minePage/mineTitleTop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../bottom.dart';
import 'mineTitleContent.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// ignore: camel_case_types
class mineTitleAllPage extends StatefulWidget {
  mineTitleAllPage();
  // minePage({Key key}) : super(key: key);

  @override
  _mineTitleAllPage createState() => _mineTitleAllPage();
}

// ignore: camel_case_types
class _mineTitleAllPage extends State<mineTitleAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: new Icon(Icons.chevron_left, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return indexPage(now: 4);
              }));
            },
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            '我的称号',
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
                            mineTitleTop(),
                            mineTitleContent(),
                            mineTitleContent2(),
                          ],
                        ),
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                ),
              ],
            )));
  }

  // ignore: todo
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
}
