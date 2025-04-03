import 'package:code/mainPages/communityPage/postCardPart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class hotPost extends StatefulWidget {
  // hotPost({Key? key}) : super(key: key);

  @override
  _hotPostState createState() => _hotPostState();
}

class _hotPostState extends State<hotPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFFF4EFEF),
            ),
            child: Row(children: [
              Expanded(
                  child: Text(
                '   热点动态',
                style: TextStyle(
                  fontSize: 20,
                ),
              )),
            ])),
        Container(
            color: Colors.white,
            child: postCardPage(
              uid: 11,
              pid: 3,
              touXiang:
                  "http://101.37.175.115:9832/images/Avatar/IMG_2021122268791.jpeg",
              userName: "SSQUIRREL",
              time: "2021-11-24 12:00:00",
              device: '',
              text:
                  "《张仲景》特种邮票将于2022年7月份发行，为助推仲景文化的传承弘扬、助力《张仲景》邮票发行，南阳日报社“直播南阳”云播台、南阳晚报、张仲景博物院、中国邮政集团有限公司南阳市分公司联合面向社会征集建议，得到了社会各界人士的广泛关注和热情支持。",
              tag: "",
              imageList: [
                "http://101.37.175.115:9832/images/PostImage/IMG_2021122144841.jpg"
              ],
              likes: 3,
              comments: 0,
              forwards: 3,
            ))
      ],
    ));
  }
}
