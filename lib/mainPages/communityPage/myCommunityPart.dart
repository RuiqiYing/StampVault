import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:code/mainPages/communityPage/communityAll.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'postCardPart.dart';

String UID;
getUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  UID = prefs.getString("id");
}

class myCommunityPage extends StatefulWidget {
  myCommunityPage({Key key, this.id}) : super(key: key);
  int id;
  @override
  _myCommunityPageState createState() => _myCommunityPageState();
}

class _myCommunityPageState extends State<myCommunityPage>
    with AutomaticKeepAliveClientMixin {
  List<Widget> widgetList = [];
  bool isToTop = false;
  //滚动控制器
  ScrollController _controller;

  void initState() {
    //初始化函数、带监听滑动功能
    getUID();

    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset > 1000) {
        setState(() {
          isToTop = true;
        });
      } else if (_controller.offset <= 500) {
        setState(() {
          isToTop = false;
        });
      }
    });
    super.initState();

    getAllPost();

  }

  getAllPost() async {
    var url = Uri.parse(Api.url + '/cs1902/post/getAll');
    var response = await http.get(
      url,
      headers: {"content-type": "application/json"},
    );
    test = jsonDecode(response.body);
    setState(() {
      aList = jsonDecode(Utf8Codec().decode(response.bodyBytes))['postData'];
    });
    for (var item in aList) {
      if (item['uid'] == widget.id) {
        List<String> tmp = [];
        for (var i in item['imgList']) {
          tmp.add(i);
        }
        widgetList.add(new postCardPage(
            uid: item['uid'],
            pid: item['pid'],
            touXiang: item['avatarUrl'].toString(),
            userName: item['username'].toString(),
            time: item['postTime'].toString(),
            device: '',
            text: item['content'].toString(),
            tag: item['tags'].toString(),
            imageList: tmp,
            likes: item['star'],
            comments: item['commentNum'],
            forwards: item['share']));
        print(item['uid'].toString());
      }
    }
  }

  getAllUser() async {
    var url = Uri.parse(Api.url + '/cs1902/user/getAll');
    var response = await http.get(
      url,
      headers: {"content-type": "application/json"},
    );
    test = jsonDecode(response.body);
    aList = jsonDecode(Utf8Codec().decode(response.bodyBytes))['Data'];
    setState(() {
      for (var item in aList) {
        
      }
    });
  }

  Future onRefresh() {
    return Future.delayed(Duration(seconds: 1), () {});
  }

  void _onPressed() {
    //回到ListView顶部
    _controller.animateTo(0,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 239, 239),
      body: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            flexibleSpace: Image.asset(
              'lib/assets/images/background1.jpg',
              fit: BoxFit.cover,
            ),
            expandedHeight: 250,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return widgetList[index];
              },
              childCount: widgetList.length,
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
