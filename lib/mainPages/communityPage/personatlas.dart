import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

var scrollController = new ScrollController();
var data;
List<Widget> stampatlas = [
  //定义动态列表
  Center(
    child: Text("TA的图鉴",
        textAlign: TextAlign.center,
        style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold)),
  ),
  SizedBox(
    height: 10,
  )
];
//定义初始数据
String userTitle = "称号",
    avatar =
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwx4.sinaimg.cn%2Fmw690%2F006Gs6kxly1g1760vf6nij30ku0kujs0.jpg&refer=http%3A%2F%2Fwx4.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1642242312&t=d4b9b0917e2245b5cec6909ecb132b97",
    bgImage =
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202009%2F28%2F20200928111654_91e98.thumb.1000_0.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1642237044&t=a29899a60c93f5a10445e9870368e607",
    userName = "昵称";

class Personatlas extends StatefulWidget {
  Personatlas({this.uid});
  final String uid;
  @override
  _PersonatlasState createState() => _PersonatlasState(uid);
}

class _PersonatlasState extends State<Personatlas> {
  _PersonatlasState(this.uid);
  final String uid;
  List atlasinfo;
  _getData() async {
    //获取数据的异步函数
    //Paramr
    var url = Uri.parse(Api.url + '/cs1902/stamp/${uid}');
    var response = await http.post(
      url,
      headers: {"content-type": "application/json"},
    );
    var datas = jsonDecode(Utf8Codec().decode(response.bodyBytes)); //转码得到的数据
    print("TA的图鉴:${datas}");
    var personinfo = datas[0];
    atlasinfo = datas[1];
    setState(() {
      //实时更新数据
      stampatlas.clear();
      if (personinfo["userName"] != Null) userName = personinfo["userName"];
      if (personinfo["userTitle"] != Null) userTitle = personinfo["userTitle"];
      if (personinfo["bgImage"] != Null) bgImage = personinfo["bgImage"];
      if (personinfo["avatar"] != Null) avatar = personinfo["avatar"];
      print("atlasinfo:${atlasinfo}");
      if (atlasinfo.isNotEmpty) {
        //判断数据是否为空，若有数据则将数据加入列表中
        for (int i = 0; i < atlasinfo.length; i++) {
          stampatlas.add(
              Singlestamp(atlasinfo[i]["image"], atlasinfo[i]["stampName"]));
        }
      } else {
        //若数据为空则显示无数据情况
        //防止多次添加控件
        stampatlas.add(SizedBox(
          height: 80,
        ));
        stampatlas.add(Center(
          child: Text("TA暂时还没有收集到邮票哦!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold)),
        ));
      }
    });
  }

  @override
  void initState() {
    //初始化函数
    super.initState();
    _getData(); //初始化获取数据
    scrollController.addListener(() {
      //监听滚动
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("已经滑到最底部");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        //防止溢出
        child: Column(
          children: [
            personinfo(),
            atlas(atlasinfo),
          ],
        ),
      ),
    );
  }
}

//个人信息背景等展示
class personinfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      //确保iconbutton控件可以使用，使用Material将其包裹起来
      child: Container(
        height: 300,
        child: Stack(
          //使用Stack控件可以较为方便的控制和堆叠不同的控件位置
          children: [
            Positioned(
                //背景图
                child: Image.network(
              bgImage,
              height: 250,
              width: 375,
              fit: BoxFit.cover,
            )),
            Positioned(
              //返回键
              left: 10,
              top: 10,
              child: IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            Positioned(
                //昵称及称号
                right: 130,
                bottom: 25,
                child: Column(
                  children: [
                    Text(
                      userName,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(userTitle,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 16,
                            color: Colors.black))
                  ],
                )),
            Positioned(
                //头像
                right: 20,
                bottom: 20,
                child: Container(
                  // 圆形图片
                  child: ClipOval(
                    child: Image.network(
                      avatar,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

//展示邮票
class atlas extends StatefulWidget {
  atlas(this.atlasinfo);
  final List atlasinfo;
  @override
  _atlasState createState() => _atlasState(atlasinfo);
}

class _atlasState extends State<atlas> {
  _atlasState(this.atlasinfo);
  final List atlasinfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Wrap(
              children: stampatlas,
            ),
          )
        ],
      ),
    );
  }
}

//单个邮票控件
class Singlestamp extends StatelessWidget {
  final String image;
  final String name;
  const Singlestamp(this.image, this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: Column(
        children: [
          Image.network(
            image,
            height: 100,
            width: 100,
          ),
          Text(name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 14,
                  color: Colors.black)),
        ],
      ),
    );
  }
}
