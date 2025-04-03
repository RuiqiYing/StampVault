import 'assets/myIcons.dart';

import 'mainPages/shakePage/shakeAll.dart';
import 'mainPages/activityPage/activityAll.dart';
import 'mainPages/communityPage/communityAll.dart';
import 'mainPages/homePage/homeAll.dart';
import 'mainPages/minePage/mineAll.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class indexPage extends StatefulWidget {
  indexPage({Key key, this.now = -1}) : super(key: key);
  int now;
  _indexPageState createState() => _indexPageState();
}

class _indexPageState extends State<indexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(MyIcons.homeFont),
      label: '首页',
    ),
    BottomNavigationBarItem(
      icon: Icon(MyIcons.activityFont),
      label: '活动',
    ),
    BottomNavigationBarItem(
      icon: Icon(MyIcons.arFont),
      label: '摇一摇',
    ),
    BottomNavigationBarItem(
      icon: Icon(MyIcons.communityFont),
      label: '圈子',
    ),
    BottomNavigationBarItem(
      icon: Icon(MyIcons.mineFont),
      label: '我的',
    ),
  ];
  final List tabBodies = [
    homePage(),
    activityPage(),
    Shake(),
    communityPage(),
    minePage(),
  ];
  int currentIndex = 0;
  var currentPage;
  @override
  void initState() {
    currentPage = tabBodies[widget.now == -1 ? currentIndex : widget.now];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: bottomTabs,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              currentPage = tabBodies[currentIndex];
            });
            print(widget.now);
          }),
      body: currentPage,
    );
  }
}
