import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:sensors/sensors.dart';
import 'package:code/mainPages/homePage/threeButton/atlas/atlasDetail.dart';

import 'dart:convert';
import 'package:code/common/api.dart';
import 'package:code/mainPages/homePage/threeButton/atlas/atlasDetail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String uid = "11";
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
}

class Shake extends StatefulWidget {
  const Shake({Key key}) : super(key: key);

  @override
  _ShakeState createState() => _ShakeState();
}

class _ShakeState extends State<Shake> {
  String imageurl;
  String name;
  String sid;
  bool islike = true;

  _getRandomStamp() async {
    print("nonononono");
    var request = http.Request('POST', 
        Uri.parse("http://101.37.175.115:9833/cs1902/stamp/getstamprand/11"));
    print("yesyesyesyes");
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      sid = await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }

  //当前摇出的邮票的界面个数
  static int pageNum = 0;
  static int stampNum = 0;
  static int msgNum = 0;

  @override
  void initState() {
    accelerometerEvents.listen((AccelerometerEvent event) async{
      // 摇一摇阀值,不同手机能达到的最大值不同，如某品牌手机只能达到20。
      int value = 20;
      if (event.x >= value ||
          event.x <= -value ||
          event.y >= value ||
          event.y <= -value ||
          event.z >= value ||
          event.z <= -value) {
        if (pageNum == 0 && stampNum < 5) {
          await _getRandomStamp();
          stampNum++;
          pageNum++;
          if(sid != null) {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => atlasDetail(sid, islike)))
              .then((data) {
            setState(() {
              pageNum--;
            });
          });
        } else if (stampNum == 5 && msgNum == 0) {
          showDialog<bool>(
            context: context,
            barrierDismissible: true,

            // AudioCache player = AudioCache();

            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text('提示'),
                content: Text('每日获得邮票已达上限(5张)'),
                actions: [
                  CupertinoDialogAction(
                    child: Text('确定'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      msgNum--;
                    },
                  ),
                ],
              );
            },
          );
          msgNum++;
        }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('摇一摇', style: TextStyle(color: Colors.black, fontSize: 20)),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Center(
        child: Image.asset("lib/assets/shake/shake5.png"),
      ),
    );
  }
}
