import 'package:code/common/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'atlasDetail.dart';

//单个邮票的组件
class singleStamp extends StatefulWidget {
  final String sid;
  const singleStamp(
      this.name, this.imageurl, this.islike, this.sid, this.iscollected);
  final String name;
  final String imageurl;
  final bool islike;
  final bool iscollected;
  @override
  _singleStampState createState() =>
      _singleStampState(name, imageurl, islike, sid, iscollected);
}

class _singleStampState extends State<singleStamp> {
  String imageurl;
  String name;
  String sid;
  bool islike = true;
  bool iscollected = true;
  Future<void> initState() {
    super.initState();
  }

  _singleStampState(
      this.name, this.imageurl, this.islike, this.sid, this.iscollected);
//喜欢动作按钮
  _like() async {
    var url =
        Uri.parse(Api.url + '/cs1902/stamp/${sid}/star?uid=' + uid.toString());
    var response = await http.get(url);
    setState(() {
      islike = !islike;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
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
          decoration: iscollected == false
              ? BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2.0, 2.0), //阴影xy轴偏移量
                        blurRadius: 5.0, //阴影模糊程度
                        spreadRadius: 1.0 //阴影扩散程度
                        )
                  ],
                  // border: Border.all(
                  //   color: Color.fromARGB(255, 176, 210, 176),
                  //   width: 2,
                  // ),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                )
              : BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(254, 204, 17, 0.5),
                        offset: Offset(2.0, 2.0), //阴影xy轴偏移量
                        blurRadius: 5.0, //阴影模糊程度
                        spreadRadius: 2.0 //阴影扩散程度
                        )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  shape: BoxShape.rectangle,
                  // border: Border.all(
                  //   color: Color.fromRGBO(238, 208, 69, 1),
                  //   width: 5,
                  // )
                ),
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 150,
                width: 125,
                child: Image.network(
                  imageurl.toString(),
                  height: 75,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 130,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    width: 100,
                    child: Text(name.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          decorationStyle: TextDecorationStyle.double,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          textBaseline: TextBaseline.alphabetic,
                          fontSize: 10,
                          height: 1.2,
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _like();
                        print(islike);
                      });
                    },
                    child: Icon(
                      islike == true ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  )
                ]),
              ),
            ],
          ),
        ));
  }
}
