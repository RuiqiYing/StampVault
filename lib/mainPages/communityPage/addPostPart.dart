import 'dart:convert';
import 'dart:ui';
import 'dart:io';

import 'package:code/common/api.dart';
import 'package:code/mainPages/communityPage/communityAll.dart';
import 'package:code/mainPages/communityPage/moreTags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bottom.dart';
import 'tagCardPart.dart';
import 'package:http/http.dart' as http;

String imagepicList;
dynamic test;
DateTime time;
List aList;
List<Widget> tiles;
String UID;
getUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  UID = prefs.getString("id");
}

String TAG;
getTAG() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  TAG = prefs.getString("tag");
}

setTag(String tag) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("tag", tag);
}

String TEXT;

List<String> IMGS = [];

class addPostCard extends StatefulWidget {
  addPostCard({
    Key key,
    this.text,
    this.imageList,
    this.tagList,
  }) : super(key: key);

  String text;
  Widget imageList;
  List<String> tagList;
  @override
  _addPostCardState createState() => _addPostCardState();
}

List<String> imageUrl = [];

class _addPostCardState extends State<addPostCard> {
  List<String> tagTextList = [];
  List<Widget> tagCardList = [];
  List<Widget> imageList = [];
  String nowTag = "";
  File _image;
  String tmp = "1";

  void initState() {
    //初始化函数、带监听滑动功能
    getUID();
    setTag("");
    imageUrl.clear();
    super.initState();
    getAllTag();
  }

  getAllTag() async {
    var url = Uri.parse(Api.url + '/cs1902/tag/all');
    var response = await http.post(
      url,
      headers: {"content-type": "application/json"},
    );
    test = jsonDecode(response.body);
    setState(() {
      aList = jsonDecode(Utf8Codec().decode(response.bodyBytes));
    });
    int num = 0;
    for (var item in aList) {
      tagTextList.add(item['content'].toString());
      tagCardList
          .add(new tagCard(text: item['content'].toString(), mode: true));
      num++;
      if (num == 6) break;
    }
  }

  insertPost(int uid, String tag, String text, String time,
      List<String> imgList) async {
    print("tag:" + tag);
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse(Api.url + '/cs1902/post/insert'));
    text = tag + " " + text;
    for (int i = 0; i < imgList.length; ++i)
      imgList[i] = "\"" + imgList[i] + "\"";
    request.body =
        "{\"uid\": ${uid},\"content\": \"${text}\",\"postTime\": \"${time}\",\"tags\": \"${tag}\",\"imgList\": ${imgList}}";
    print(request.body.toString());
    print(imgList.toString() + "   listttt");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
  }

  Future choosePic(ImageSource source) async {
    //参数类型为ImageSource
    //var image = await ImagePicker.pickImage(source: source); //过期方法暂时没有找到合适的替代方法
    ImagePicker imagePicker = ImagePicker();
    PickedFile image = await imagePicker.getImage(source: source);
    print(image.runtimeType.toString());
    //上传
    var request = http.MultipartRequest(
        'POST', Uri.parse(Api.url + '/cs1902/post/uploadImage'));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      tmp = await response.stream.bytesToString();
      print(tmp + "的imageurl");
      if (tmp.length > 20) {
        Fluttertoast.showToast(
          msg: '添加图片成功',
          gravity: ToastGravity.BOTTOM,
        );
        setState(() {
          //将用户照片存储到_image
          _image = File(image.path);
          imageList.add(new Container(
              height: 50,
              width: 50,
              child: Image.file(_image),
              decoration: new BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2.0, 2.0), //阴影xy轴偏移量
                        blurRadius: 5.0, //阴影模糊程度
                        spreadRadius: 1.0 //阴影扩散程度
                        )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(150))));
          imageUrl.add(tmp);
          print(tmp + "yesyesyes imageurl");
        });
      } else {
        print("nonononononono imageurl");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    getUID();
    return SizedBox(
        width: 450,
        height: 600,
        child: Container(
            width: 400,
            height: 500,
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: SizedBox(
                width: 400,
                height: 300,
                child: Scaffold(
                    appBar: new AppBar(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      leading: IconButton(
                        icon: new Icon(Icons.chevron_left,
                            color: Colors.black, size: 30),
                        onPressed: () {
                          Navigator.of(context)..pop();
                        },
                      ),
                      centerTitle: true,
                      title: Text(
                        '发布动态',
                        style: TextStyle(color: Colors.black),
                      ),
                      actions: [
                        TextButton(
                          child:
                              Text("发布", style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            getTAG();
                            print(TAG);
                            DateTime now = new DateTime.now();
                            IMGS.clear();
                            for (int i = 0; i < imageUrl.length; ++i)
                              IMGS.add(imageUrl[i].toString());
                            insertPost(int.parse(UID), TAG.toString(), TEXT,
                                now.toString(), IMGS);
                            setTag("");
                            for (var i in imageUrl) {
                              print(i + "  im imageUrl");
                            }
                            Navigator.pop(context);
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return indexPage(now: 3);
                            }));
                            ;
                          },
                        )
                      ],
                    ),
                    resizeToAvoidBottomInset: false,
                    body: new Column(children: [
                      Center(
                          child: SizedBox(
                              width: 300,
                              height: 50,
                              child: new Row(children: [
                                Text('热门Tag',
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.left),
                                SizedBox(width: 150),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          new MaterialPageRoute(builder: (
                                        BuildContext context,
                                      ) {
                                        return moreTags();
                                      }));
                                    },
                                    child:
                                        Text('更多', textAlign: TextAlign.right))
                              ]))),
                      SizedBox(height: 5),
                      Center(
                          child: SizedBox(
                              width: 330,
                              height: 120,
                              child: Wrap(
                                  spacing: 10, //主轴上子控件的间距
                                  runSpacing: 5, //交叉轴上子控件之间的间距
                                  children: tagCardList))),
                      SizedBox(height: 5),
                      SizedBox(
                          width: 330,
                          height: 200,
                          child: TextField(
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.blue,
                              cursorWidth: 5,
                              maxLines: 8,
                              decoration: InputDecoration(
                                  hintText: '请输入你想发布的内容...',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                              onChanged: (a) {
                                TEXT = a;
                              })),
                      IconButton(
                          icon: Icon(Icons.photo),
                          iconSize: 80,
                          onPressed: () {
                            choosePic(ImageSource.gallery);
                          }),
                      Wrap(
                          spacing: 20, //主轴上子控件的间距
                          runSpacing: 5, //交叉轴上子控件之间的间距
                          children: imageList)
                    ])))));
  }
}
