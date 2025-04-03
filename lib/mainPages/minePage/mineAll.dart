import 'package:code/mainPages/minePage/mineSecondInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'mineInfo.dart';

// ignore: camel_case_types
class minePage extends StatefulWidget {
  minePage();
  // minePage({Key key}) : super(key: key);

  @override
  _minePageState createState() => _minePageState();
}

// ignore: camel_case_types
class _minePageState extends State<minePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            '我的',
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
                          children: <Widget>[mineInfoPage(), mineSecondInfo()],
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
