import 'dart:async';

import 'package:code/mainPages/homePage/threeButton/atlas/atlasAll.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:code/common/data.dart';

import 'atlasSearch.dart';

class atlasSort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          leading: IconButton(
            icon: new Icon(Icons.chevron_left, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.of(context)..pop();
            },
          ),
          centerTitle: true,
          title: Text(
            '图鉴',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search,color: Colors.black,),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => atlassearch()));
                }),
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 244, 239, 239),
            ),
            child: Column(
              children: [
                Container(
                  
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(2.0, 2.0), //阴影xy轴偏移量
                                  blurRadius: 5.0, //阴影模糊程度
                                  spreadRadius: 1.0 //阴影扩散程度
                                  )
                            ],
                          ),
                          height: 90,
                          width: 90,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => atlasAll(
                                        id: "all",
                                        sortname: " 全图鉴 ",
                                      )));
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.import_contacts),
                                  ),
                                ),
                                // SizedBox(height: 5),
                                Text('全图鉴',
                                    style: TextStyle(
                                      decorationStyle:
                                          TextDecorationStyle.double,
                                      fontWeight: FontWeight.w500,
                                      textBaseline: TextBaseline.alphabetic,
                                      fontSize: 16,
                                      height: 1.2,
                                    )),
                              ],
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(2.0, 2.0), //阴影xy轴偏移量
                                  blurRadius: 5.0, //阴影模糊程度
                                  spreadRadius: 1.0 //阴影扩散程度
                                  )
                            ],
                          ),
                          width: 90,
                          height: 90,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => atlasAll(
                                        id: "like",
                                        sortname: "我的收藏",
                                      )));
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.stars),
                                  ),
                                ),
                                Text('我的收藏',
                                    style: TextStyle(
                                      decorationStyle:
                                          TextDecorationStyle.double,
                                      fontWeight: FontWeight.w500,
                                      textBaseline: TextBaseline.alphabetic,
                                      fontSize: 16,
                                      height: 1.2,
                                    )),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                Sort()
              ],
            )));
  }
}

//建立大分类的分页
class Sort extends StatefulWidget {
  @override
  _SortState createState() => _SortState();
}

class _SortState extends State<Sort> {
  bool _sorts = true;
  bool _years = false;
  bool _printer = false;
  bool _format = false;
  bool _designer = false;

  @override
  Widget build(BuildContext context) {
    return Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2.0, 2.0), //阴影xy轴偏移量
                          blurRadius: 5.0, //阴影模糊程度
                          spreadRadius: 1.0 //阴影扩散程度
                          )
                    ],
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(15.0)),
),
      child:Column(
      children: [
        SizedBox(height: 20),
        Container(
                          decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2.0, 2.0), //阴影xy轴偏移量
                          blurRadius: 5.0, //阴影模糊程度
                          spreadRadius: 1.0 //阴影扩散程度
                          )
                    ],
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(15.0))),
          child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextButton(
              onPressed: () {
                setState(() {
                  _sorts = true;
                  _years = false;
                  _printer = false;
                  _format = false;
                  _designer = false;
                });
              },
              child: Text("类别",
                  style: TextStyle(
                    decoration:
                        _sorts ? TextDecoration.underline : TextDecoration.none,
                    color: _sorts
                        ? Color.fromARGB(255, 176, 210, 176)
                        : Colors.black, //当处于不同页面时，按钮颜色不同
                    fontSize: _sorts ? 20 : 16, //当处于不同页面时，按钮大小不同
                  ))),
          TextButton(
              onPressed: () {
                setState(() {
                  _sorts = false;
                  _years = true;
                  _printer = false;
                  _format = false;
                  _designer = false;
                });
              },
              child: Text("年代",
                  style: TextStyle(
                    decoration:
                        _years ? TextDecoration.underline : TextDecoration.none,

                    color: _years
                        ? Color.fromARGB(255, 176, 210, 176)
                        : Colors.black,
                    fontSize: _years ? 20 : 16, //当处于不同页面时，按钮颜色不同
                  ))),
          TextButton(
              onPressed: () {
                setState(() {
                  _sorts = false;
                  _years = false;
                  _printer = false;
                  _format = true;
                  _designer = false;
                });
              },
              child: Text("版式",
                  style: TextStyle(
                    decoration: _format
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    color: _format
                        ? Color.fromARGB(255, 176, 210, 176)
                        : Colors.black,
                    fontSize: _format ? 20 : 16,
                  ))),
          TextButton(
              onPressed: () {
                setState(() {
                  _sorts = false;
                  _years = false;
                  _printer = false;
                  _format = false;
                  _designer = true;
                });
              },
              child: Text(
                "设计者",
                style: TextStyle(
                  decoration: _designer
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  color: _designer
                      ? Color.fromARGB(255, 176, 210, 176)
                      : Colors.black,
                  fontSize: 16,
                ),
              )),
          TextButton(
              onPressed: () {
                setState(() {
                  _sorts = false;
                  _years = false;
                  _printer = true;
                  _format = false;
                  _designer = false;
                });
              },
              child: Text("印刷厂",
                  style: TextStyle(
                    decoration: _printer
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    color: _printer
                        ? Color.fromARGB(255, 176, 210, 176)
                        : Colors.black,
                    fontSize: 16,
                  ))),
        ])),
        Visibility(
          //展示不同页面
          visible: _sorts,
          child: SingleChildScrollView(child: SortPage("type")),
        ),
        Visibility(visible: _years, child: SortPage("era")),
        Visibility(visible: _format, child: SortPage("format")),
        Visibility(visible: _designer, child: SortPage("author")),
        Visibility(visible: _printer, child: SortPage("printer")),
      ],
    ));
  }
}

//根据大分类显示小分类
class SortPage extends StatelessWidget {
  final String choose;
  SortPage(this.choose);

  List sortlist;
  String _choose() {
    if (choose == "type")
      sortlist = sort;
    else if (choose == "era")
      sortlist = era;
    else if (choose == "format")
      sortlist = format;
    else if (choose == "author")
      sortlist = author;
    else if (choose == "printer") sortlist = printer;
    return choose;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = [];

    Widget content;
    String id;

    id = _choose();
    for (var item in sortlist) {
      tiles.add(Listss(item, id.toString()));
    }

    content = Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        height: 465,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 25,
                runAlignment: WrapAlignment.center,
                runSpacing: 10,
                children: tiles)));
    return content;
  }
}

//建立分类列表
class Listss extends StatelessWidget {
  final String title;
  final String id;
  const Listss(this.title, this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 40,
        width: 100,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Color.fromARGB(255, 176, 210, 176)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(2.0, 2.0), //阴影xy轴偏移量
                blurRadius: 5.0, //阴影模糊程度
                spreadRadius: 1.0 //阴影扩散程度
                )
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => atlasAll(
                          sortname: title.toString(),
                          id: id.toString(),
                        )));
          },
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(fontSize: 16),
          ),
        ));
  }
}
