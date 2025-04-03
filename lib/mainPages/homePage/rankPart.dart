import 'package:code/mainPages/homePage/ranks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 排名专栏
class rankPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 40,
        alignment: AlignmentDirectional(-0.9, 0.0),
        decoration: BoxDecoration(
          color: Color(0xFFF4EFEF),
        ),
        child: Text(
          '排名专栏',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      rankItem(
        title: '邮票收藏度排名',
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ranks(id: "stamp")));
          print('点击了');
        },
      ),
      SizedBox(
        height: 10,
      ),
      rankItem(
        title: '用户集邮度排名',
        onPressed: () {
          print('点击了');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ranks(id: "user")));
        },
      )
    ]));
  }
}

class rankItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const rankItem({Key key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: new BoxDecoration(color: Colors.white),
          height: 40,
          child: Row(
            children: [
              SizedBox(
                width: 17,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.menu),
              SizedBox(
                width: 40,
              )
            ],
          ),
        ));
  }
}
