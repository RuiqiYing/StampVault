import 'package:code/assets/myIcons.dart';
import 'package:code/mainPages/communityPage/myCommunityPart.dart';
import 'package:code/mainPages/communityPage/personatlas.dart';
import 'package:code/mainPages/communityPage/postCardPart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class personInformationPage extends StatefulWidget {
  personInformationPage({Key key, this.id}) : super(key: key);

  int id;

  @override
  _personInformationPageState createState() => _personInformationPageState();
}

class _personInformationPageState extends State<personInformationPage> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetList = [
      Container(
        height: 160,
        color: Colors.grey,
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('lib/assets/images/xj1.jpg'),
              child: Container(
                alignment: Alignment(0, .5),
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(width: 20),
            new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '昵称：',
                  style: TextStyle(
                    color: Color(0xFF111111),
                    decorationStyle: TextDecorationStyle.double,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    textBaseline: TextBaseline.alphabetic,
                    fontSize: 13,
                    letterSpacing: 2,
                    wordSpacing: 10,
                    height: 1.5,
                  ),
                ),
                Text(
                  '称号：',
                  style: TextStyle(
                    color: Color(0xFF111111),
                    decorationStyle: TextDecorationStyle.double,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    textBaseline: TextBaseline.alphabetic,
                    fontSize: 13,
                    letterSpacing: 2,
                    wordSpacing: 10,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '西伯利亚大松鼠',
                  style: TextStyle(
                    color: Color(0xFF111111),
                    decorationStyle: TextDecorationStyle.double,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    textBaseline: TextBaseline.alphabetic,
                    fontSize: 13,
                    letterSpacing: 2,
                    wordSpacing: 10,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  '集邮小天才',
                  style: TextStyle(
                    color: Color(0xFF111111),
                    decorationStyle: TextDecorationStyle.double,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    textBaseline: TextBaseline.alphabetic,
                    fontSize: 13,
                    letterSpacing: 2,
                    wordSpacing: 10,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Icon(Icons.person_sharp),
          ],
        ),
      ),
      SizedBox(height: 20),
      Container(
        height: 80,
        width: 350,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: IconButton(
                          onPressed: null, icon: Icon(MyIcons.message1Font))),
                  Text('私信',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        decorationStyle: TextDecorationStyle.double,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        textBaseline: TextBaseline.alphabetic,
                        fontSize: 20,
                        letterSpacing: 2,
                        wordSpacing: 10,
                        height: 1.2,
                      )),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (
                            BuildContext context,
                          ) {
                            return new myCommunityPage();
                          }));
                        },
                        icon: Icon(MyIcons.communityFont)),
                  ),
                  Text('圈子',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        decorationStyle: TextDecorationStyle.double,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        textBaseline: TextBaseline.alphabetic,
                        fontSize: 20,
                        letterSpacing: 2,
                        wordSpacing: 10,
                        height: 1.2,
                      )),
                ],
              ),
            ),
            SizedBox(
                child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Personatlas(uid: 1.toString())));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: null, icon: Icon(MyIcons.bookFont)),
                  ),
                  Text('图鉴',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        decorationStyle: TextDecorationStyle.double,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        textBaseline: TextBaseline.alphabetic,
                        fontSize: 20,
                        letterSpacing: 2,
                        wordSpacing: 10,
                        height: 1.2,
                      )),
                ],
              ),
            )),
          ],
        ),
      ),
      SizedBox(height: 10),
      Text('最近动态'),
      SizedBox(height: 10),
      new postCardPage(
        touXiang: 'lib/assets/images/xj1.jpg',
        userName: '西伯利亚大松鼠',
        time: '11-26 15:23',
        device: '',
        text: '中国邮政 文化季已开幕！六大主题文化周，历时三个月，献上一场文化盛宴，给你不一样的冬天！',
        imageList: [
          'lib/assets/images/xj5.jpg',
          'lib/assets/images/xj4.jpg',
          'lib/assets/images/xj3.jpg'
        ],
        likes: 24,
        comments: 24,
        forwards: 5,
      ),
      new postCardPage(
        touXiang: 'lib/assets/images/xj1.jpg',
        userName: '西伯利亚大松鼠',
        time: '11-6 13:20',
        device: '',
        text: '7月19日上午，重固妈妈俱乐部——暑期邮票DIY活动在社会组织服务中心二楼热闹开展，此次活动特邀重固小学陆老师前来授课，活动吸引了不少社区小朋友前来参加。活动开始前，一批小小志愿者上线，负责引导、签到、安排小朋友入座等工作。小志愿者们分工明确，各个富有责任心， 现场井然有序。' +
            '小朋友们到齐后，重固小学陆老师通过PPT的形式让大家了解了邮票的起源，知道第一张邮票诞生于英国，叫黑便士邮票，我国第一张邮票叫大龙邮票，还了解了邮票的用途和分类。小朋友们听得认真，并积极回答问题，现场气氛热烈。' +
            '随后，小朋友根据学习到的邮票相关知识，动手绘制邮票，有的大胆创新，发挥自己画画的天赋，最后的作品，也是各有各的特色。',
        imageList: [
          'lib/assets/images/xj5.jpg',
          'lib/assets/images/xj4.jpg',
          'lib/assets/images/xj3.jpg'
        ],
        likes: 237,
        comments: 294,
        forwards: 5,
      )
    ];

    return Scaffold(
        body: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            // controller: _scrollController,
            itemCount: widgetList.length,
            // itemExtent: 360,
            itemBuilder: (BuildContext context, int index) {
              return widgetList[index];
            }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
}
