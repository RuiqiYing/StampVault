//用户排行页面
import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:code/mainPages/minePage/othersInfoAll.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

var scrollController = new ScrollController();

class userPage extends StatefulWidget {
  userPage(this.data);
  final List data;

  @override
  _userPageState createState() => _userPageState(data);
}

class _userPageState extends State<userPage> {
  List<Widget> list = [];
  List data;
  _userPageState(this.data);
  _getRank() async {
    var url = Uri.parse(Api.url + '/cs1902/user/listRank');
    var response = await http.post(url);
    print(response.body);
    data = jsonDecode(Utf8Codec().decode(response.bodyBytes));
    setState(() {
      for (int i = 0; i < 10; i++) {
        if (i >= data.length) break;
        list.add(SingleuserRank(i + 1, data[i]["image"], data[i]["username"],
            data[i]["collections"], data[i]["useId"]));
      }
    });
  }

  @override
  void initState() {
    super.initState();
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

//单个用户排行列
class SingleuserRank extends StatelessWidget {
  final int no;
  final String imageurl;
  final String name;
  final int hot;
  final int uid;
  const SingleuserRank(this.no, this.imageurl, this.name, this.hot, this.uid);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => othersAllPage(id: uid)));
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
              //显示排行数
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  no.toString(),
                ),
              ),
            ),
            Expanded(
              //显示用户头像
              flex: 3,
              child: Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    image: DecorationImage(
                        image: new NetworkImage(
                          imageurl.toString(),
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
            Expanded(
              //显示用户名
              flex: 4,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                  name,
                ),
              ),
            ),
            Expanded(
                //显示用户手机的邮票数目
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
