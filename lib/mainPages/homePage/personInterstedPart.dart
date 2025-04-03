import 'package:code/mainPages/minePage/othersInfoAll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 你可能感兴趣的人
class personIntersted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 250,
      child: Column(
        children: [
          Container(
            height: 40,
            alignment: AlignmentDirectional(-0.9, 0.0),
            decoration: BoxDecoration(
              color: Color(0xFFF4EFEF),
            ),
            child: Text(
              '你可能感兴趣的人',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              personInterstItem(
                name: '中国邮政',
                title: '邮斋认证官方号',
                picRoute: "lib/assets/face/ChinaPost.jpg",
                id: 25,
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (
                    BuildContext context,
                  ) {
                    return new othersAllPage(
                      id: 25,
                    );
                  }));
                },
              ),
              SizedBox(
                width: 10,
              ),
              personInterstItem(
                name: '方森森',
                title: '集邮大佬',
                picRoute: "lib/assets/face/fss.jpg",
                id: 13,
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (
                    BuildContext context,
                  ) {
                    return new othersAllPage(
                      id: 13,
                    );
                  }));
                },
              ),
              SizedBox(
                width: 10,
              ),
              personInterstItem(
                name: 'SSQUIRREL',
                title: '资深爱好者',
                id: 11,
                picRoute: "lib/assets/face/dss.jpeg",
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (
                    BuildContext context,
                  ) {
                    return new othersAllPage(
                      id: 11,
                    );
                  }));
                },
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class personInterstItem extends StatelessWidget {
  const personInterstItem(
      {Key key, this.name, this.title, this.picRoute, this.onPressed, this.id})
      : super(key: key);
  final String title;
  final String name;
  final String picRoute;
  final VoidCallback onPressed;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:GestureDetector( 
        onTap: onPressed,
        child: Container(
      height: 170,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ClipOval(
              child: Image.asset(picRoute,
                  height: 50, width: 50, fit: BoxFit.cover)),
          Text(
            name,
            style: TextStyle(fontSize: 15),
          ),
          Text(title, style: TextStyle(fontSize: 11, color: Colors.grey)),
          Container(
              width: 70.0,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
              ),
              alignment: Alignment.center,
              child: Text(
                '去看看',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              )),
        ],
      ),
    ))
       );
  }
}
