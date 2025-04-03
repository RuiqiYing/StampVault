import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'rotationPart.dart';
import 'threeFunctionPart.dart';
import 'dailyStampPart.dart';
import 'hotPostPart.dart';
import 'hotTopicPart.dart';
import 'personInterstedPart.dart';
import 'newsQuickLookPart.dart';
import 'rankPart.dart';

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          '首页',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: homeAll(),
    );
  }
}

class homeAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        rotationChart(),
                        threeFunction(),
                        dailyStamp(),
                        hotPost(),
                        hotTopic(),
                        personIntersted(),
                        newsQuickLook(),
                        rankPart(),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                    alignment: Alignment.center,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
