import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 每日一邮
class dailyStamp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 40,
            alignment: AlignmentDirectional(-0.9, 0.0),
            decoration: BoxDecoration(
              color: Color(0xFFF4EFEF),
            ),
            child: Text(
              '每日一邮',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            height: 125,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          '   第一套三国演义邮票',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20.0, 0, 0.0, 5.0),
                        child: Text(
                          ' 发行于1988年，邮票总共四枚：分别是桃园三结义、三英战吕布、凤仪亭和煮酒论英雄。',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                /**
 最后的2个元素分别是1个Icon和1个Text,分别用来显示星星和数字
 */

                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 5, 10.0, 0),
                  constraints: BoxConstraints(
                    maxHeight: 90,
                  ),
                  child: Image.asset("lib/assets/rotationChart/sanguo.jpg",
                      fit: BoxFit.cover),
                )
              ],
            ),
          )
        ]));
  }
}
