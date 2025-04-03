import 'package:code/common/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'activityList.dart';

String test;

class activityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 239, 239),
        appBar: AppBar(
          centerTitle: true,
          title:
              Text('活动', style: TextStyle(color: Colors.black, fontSize: 20)),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        body: activityAll());
  }
}

class activityAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // getAllActivity();
    return Container(
        // child: rotationChart(),
        child: CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverList(
          delegate: new SliverChildListDelegate(
            [
              Column(
                children: <Widget>[
                  activityList(),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
