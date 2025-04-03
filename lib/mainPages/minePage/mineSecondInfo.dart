import 'package:code/mainPages/homePage/threeButton/atlas/atlasAll.dart';
import 'package:code/mainPages/minePage/myActivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'mineSetting.dart';
import 'mineTitleAll.dart';

// ignore: camel_case_types
class mineSecondInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Container(
        margin: const EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 53,
        decoration:
            new BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: Container(
            margin: const EdgeInsets.only(top: 15, left: 20, bottom: 15),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => atlasAll(
                              id: "collected",
                              sortname: "我的图鉴",
                            )));
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(child: (Text('我的图鉴'))),
                        Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Icon(Icons.chevron_right,
                                color: Colors.black, size: 20))
                      ]),
                ),
              ],
            )),
      ),
      Container(
          margin: const EdgeInsets.only(top: 1),
          width: double.infinity,
          height: 53,
          decoration:
              new BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => myActivityPage()));
            },
            child: Container(
                margin: const EdgeInsets.only(top: 15, left: 20, bottom: 15),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: (Text('我的活动'))),
                          Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Icon(Icons.chevron_right,
                                  color: Colors.black, size: 20))
                        ]),
                  ],
                )),
          )),
      Container(
        margin: const EdgeInsets.only(top: 1),
        width: double.infinity,
        height: 53,
        decoration:
            new BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => mineTitleAllPage()));
            },
            child: Container(
                margin: const EdgeInsets.only(top: 15, left: 20, bottom: 15),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: (Text('我的称号'))),
                          Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Icon(Icons.chevron_right,
                                  color: Colors.black, size: 20))
                        ]),
                  ],
                ))),
      ),
      Container(
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        height: 53,
        decoration:
            new BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => mineSettingPage()));
          },
          child: Container(
              margin: const EdgeInsets.only(top: 15, left: 20, bottom: 15),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(child: (Text('我的设置'))),
                        Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Icon(Icons.chevron_right,
                                color: Colors.black, size: 20))
                      ]),
                ],
              )),
        ),
      )
    ]);
  }
}
