import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:code/mainPages/homePage/threeButton/information/inforDetail.dart';
import 'package:code/mainPages/homePage/threeButton/information/information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

int pageNum = 1;
int pageSize = 3;
String condition = "uptime";
String imageUrl = "";
String title = "";
String uptime = "";
int id = 0;
int listLength = 0;
List formlist = [];

// 资讯速览
class newsQuickLook extends StatefulWidget {
  // final String id;
  // activityDetialAll({Key key, this.id}) : super(key: key);
  @override
  _newsQuickLookState createState() => _newsQuickLookState();
}

class _newsQuickLookState extends State<newsQuickLook> {
  @override
  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    getInfor();
  }

  getInfor() async {
    var url = Uri.parse(Api.url + '/cs1902/information/all');
    var response = await http.post(url,
        headers: {"content-type": "application/json"},
        body: '{"pageNum": "${pageNum}", "pageSize": "${pageSize}",' +
            '"condition": "${uptime}"}');

    var data = jsonDecode(Utf8Codec().decode(response.bodyBytes));
    formlist = data["records"];
    listLength = formlist.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFFF4EFEF),
          ),
          child: Row(children: [
            Expanded(
                child: Text(
              '   资讯速览',
              style: TextStyle(
                fontSize: 20,
              ),
            )),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => informationPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text('更多   '),
                ))
          ])),
      buildGrid(context)
    ]));
  }

  Widget buildGrid(BuildContext context) {
    List<Widget> tiles = [];
    Widget content;
    print(formlist);
    for (var item in formlist) {
      tiles.add(InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => inforDetail(
                          id: item['iid'].toString(),
                        )));
          },
          child: Container(
              height: 130.0,
              child: Column(
                children: <Widget>[
                  // 内容视图
                  Container(
                    child: Container(
                      padding: EdgeInsets.all(18.0),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      child: Text(
                                        item['title'].toString(),
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(0xff111111),
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: Text(' ')),
                                        Text(
                                          item['uptime']
                                              .toString()
                                              .substring(0, 10),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                height: 85.0,
                                width: 115.0,
                                margin: EdgeInsets.only(top: 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        item['imageUrl'].toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 分割线
                ],
              ))));
    }
    content = new Column(
      children: tiles,
    );
    return content;
  }
}
