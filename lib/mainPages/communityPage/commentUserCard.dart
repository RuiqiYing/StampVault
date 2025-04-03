import 'package:code/chat/follow.dart';
import 'package:code/mainPages/homePage/hotTopicPart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class commentUserCard extends StatelessWidget {
  commentUserCard(
      {Key key,
      this.pid,
      this.cid,
      this.uid,
      this.text,
      this.time,
      this.touxiang,
      this.username})
      : super(key: key);

  int pid;
  int cid;
  int uid;
  String text;
  String time;
  String touxiang;
  String username;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
            alignment: Alignment.center,
            height: 180,
            color: Colors.white,
            child: Scaffold(
                appBar: new AppBar(
                  elevation: 6.0,
                  shape: ContinuousRectangleBorder(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                      // bottomLeft: Radius.circular(30.0),
                      // bottomRight: Radius.circular(30.0),
                    ),
                  ),
                  // backgroundColor: Color.fromARGB(255, 146, 180, 146),
                  backgroundColor: Color.fromARGB(255, 240, 240, 240),
                  leading: InkWell(
                      child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              // NetworkImage(touxiang),
                              AssetImage("lib/assets/images/xj1.jpg"),
                          child: Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.center,
                              // width: 150,
                              height: 150)),
                      onTap: () {
                        // Navigator.push(context, new MaterialPageRoute(
                        //     builder: (BuildContext context) {
                        //   return new personInformationPage(id: uid);
                        // }));
                      }),
                  title: IntrinsicWidth(
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        Text(username,
                            style: TextStyle(
                                color: Color(0xFF111111),
                                decorationStyle: TextDecorationStyle.double,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                textBaseline: TextBaseline.alphabetic,
                                fontSize: 13,
                                letterSpacing: 2,
                                wordSpacing: 10,
                                height: 1.5),
                            textAlign: TextAlign.start),
                      ])),
                ),
                body: Container(
                    padding: EdgeInsets.only(left: 10, top: 20, right: 10),
                    child: new Column(children: [
                      Text(text,
                          style: TextStyle(
                              color: Color(0xFF111111),
                              decorationStyle: TextDecorationStyle.double,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              textBaseline: TextBaseline.alphabetic,
                              fontSize: 13,
                              letterSpacing: 2,
                              wordSpacing: 10,
                              height: 1.2),
                          softWrap: true,
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: 10)
                    ])),
                bottomNavigationBar: Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(time, style: TextStyle(fontSize: 10))))));

    // ListTile(
    //     leading: Padding(
    //         padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
    //         child: Image(image: AssetImage('lib/assets/images/xj1.jpg'))),
    //     title: SizedBox(
    //         height: 100,
    //         child: new Row(
    //           children: [
    //             Text('hello'),
    //             SizedBox(width: 100),
    //             new Column(children: [
    //               SizedBox(height: 60),
    //               Text('2021-11-05', style: TextStyle(fontSize: 10))
    //             ])
    //           ],
    //         )));
  }
}
