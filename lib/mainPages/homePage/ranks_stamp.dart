//邮票排行页面
import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:code/mainPages/homePage/threeButton/atlas/atlasDetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var scrollController = new ScrollController();
String uid;
Future _readShared() async {
  //获取当前用户的用户信息
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
  print(uid);
}

class stampPage extends StatefulWidget {
  stampPage(this.data);
  final List data;

  @override
  _stampPageState createState() => _stampPageState(data);
}

class _stampPageState extends State<stampPage> {
  List<Widget> list = [];
  List data;
  _stampPageState(this.data);

  _getRank() async {
    //Paramr
    var url = Uri.parse(Api.url + '/cs1902/stamp/rank/${uid}');
    var response = await http.get(url);
    data = jsonDecode(Utf8Codec().decode(response.bodyBytes));
    print(data);
    setState(() {
      for (int i = 0; i < 10; i++) {
        if (i >= data.length) break;
        print(data[i]["like"]);
        list.add(SinglestampRank(
            data[i]["stampId"],
            i + 1,
            data[i]["stampImage"],
            data[i]["stampName"],
            data[i]["stampHot"],
            data[i]["like"]));
      }
    });
  }

  @override
  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    _readShared();
    _getRank();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("已经滑到最底部");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: list);
  }
}

//单个邮票的排行列
class SinglestampRank extends StatefulWidget {
  final int no;
  final String sid;
  final String imageurl;
  final String name;
  final int hot;
  final bool islike;
  const SinglestampRank(
      this.sid, this.no, this.imageurl, this.name, this.hot, this.islike);

  @override
  _SinglestampRankState createState() =>
      _SinglestampRankState(sid, no, imageurl, name, hot, islike);
}

class _SinglestampRankState extends State<SinglestampRank> {
  final int no;
  final String sid;
  final String imageurl;
  final String name;
  final int hot;
  bool islike;

  _SinglestampRankState(
      this.sid, this.no, this.imageurl, this.name, this.hot, this.islike);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("${uid},${islike}");
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => atlasDetail(sid, islike)))
            .then((data) {
          setState(() {
            islike = data;
          });
        });
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Color.fromARGB(255, 176, 210, 176),
              width: 2,
            )),
        child: Row(
          children: [
            Expanded(
              //显示排名数
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  no.toString(),
                ),
              ),
            ),
            Expanded(
                //显示邮票样式
                flex: 3,
                child: Image.network(
                  imageurl.toString(),
                  height: 75,
                  width: 75,
                )),
            Expanded(
              //显示邮票名
              flex: 4,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                  name,
                ),
              ),
            ),
            Expanded(
                //显示邮票热度
                flex: 3,
                child: Row(
                  children: [
                    Icon(
                      Icons.whatshot,
                      color: Colors.red,
                    ),
                    Text(
                      hot.toString(),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
