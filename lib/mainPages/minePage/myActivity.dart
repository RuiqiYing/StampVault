import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'myActivityList.dart';

// ignore: camel_case_types
class myActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 239, 239),
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: new Icon(Icons.chevron_left, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.of(context)..pop();
            },
          ),
          title: Text('我参与的活动',
              style: TextStyle(color: Colors.black, fontSize: 20)),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        body: myActivity());
  }
}

class myActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  myactivityList(),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
