import 'package:code/assets/myIcons.dart';
import 'package:code/mainPages/homePage/threeButton/atlas/atlasSort.dart';
import 'package:code/mainPages/homePage/threeButton/information/information.dart';
import 'package:code/mainPages/homePage/threeButton/topic/topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 三个功能
class threeFunction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: new Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 70,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => topicPage()));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: IconButton(
                        onPressed: null,
                        icon: Icon(
                          MyIcons.topicFont,
                        ),
                      ),
                    ),
                    Text('话题',
                        style: TextStyle(
                          color: Color(0xFF000000),
                          decorationStyle: TextDecorationStyle.double,
                          fontWeight: FontWeight.w500,
                          textBaseline: TextBaseline.alphabetic,
                          fontSize: 14,
                          letterSpacing: 2,
                          wordSpacing: 10,
                          height: 1.2,
                        )),
                    SizedBox(height: 10)
                  ],
                )),
          ),
          SizedBox(
              height: 70,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => atlasSort()));
                  },
                  child: Column(children: [
                    Expanded(
                        child: IconButton(
                      onPressed: null,
                      icon: Icon(
                        MyIcons.activityFont,
                      ),
                    )),
                    Text('图鉴',
                        style: TextStyle(
                          color: Color(0xFF000000),
                          decorationStyle: TextDecorationStyle.double,
                          fontWeight: FontWeight.w500,
                          textBaseline: TextBaseline.alphabetic,
                          fontSize: 14,
                          letterSpacing: 2,
                          wordSpacing: 10,
                          height: 1.2,
                        )),
                    SizedBox(height: 10)
                  ]))),
          SizedBox(
              height: 70,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => informationPage()));
                  },
                  child: Column(children: [
                    Expanded(
                        child: IconButton(
                      onPressed: null,
                      icon: Icon(
                        MyIcons.newsFont,
                      ),
                    )),
                    Text('资讯',
                        style: TextStyle(
                          color: Color(0xFF000000),
                          decorationStyle: TextDecorationStyle.double,
                          fontWeight: FontWeight.w500,
                          textBaseline: TextBaseline.alphabetic,
                          fontSize: 14,
                          letterSpacing: 2,
                          wordSpacing: 10,
                          height: 1.2,
                        )),
                    SizedBox(height: 10)
                  ]))),
        ],
      ),
    );
  }
}
