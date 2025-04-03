import 'dart:convert';
import 'dart:io';
import 'package:code/common/api.dart';
// import 'package:dio/dio.dart';
import 'package:code/mainPages/minePage/changeName.dart';
import 'package:code/mainPages/minePage/mineTitleAll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Map aList;
String uid;
String _avatarPath;
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.get('id');
}

bool flag = false;

// ignore: camel_case_types
class fixmineInfoPage extends StatefulWidget {
  fixmineInfoPage();
  // minePage({Key key}) : super(key: key);

  @override
  _fixmineInfoPageState createState() => _fixmineInfoPageState();
}

class _fixmineInfoPageState extends State<fixmineInfoPage> {
  File _image;
  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    setState(() {
      aList = {
        'name': 'loading',
        'title': {'title_type': '1', 'title_name': 'loading'},
        'avatar_url': 'loading',
        'fans_num': '0',
        'subscribe_num': '0',
        'post_num': '0'
      };
      initThisPage();
    });
  }

  Future<void> initThisPage() async {
    await _readShared();
    await getAllTitle();
  }

  getAllTitle() async {
    var url = Uri.parse(Api.url + '/cs1902/user/info/' + uid);
    var response =
        await http.get(url, headers: {"content-type": "application/json"});
    setState(() {
      aList = jsonDecode(Utf8Codec().decode(response.bodyBytes));
    });
  }

  Future _getImage() async {
    // var image = await ImagePicker.pickImage(source: ImageSource.camera);
    // _upLoadImage(image); //上传图片
    // setState(() {});
  }

  Future _chooseImage() async {
    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // _upLoadImage(image); //上传图片
    // setState(() {});
  }

  Future choosePic(ImageSource source) async {
    //参数类型为ImageSource
    //var image = await ImagePicker.pickImage(source: source); //过期方法暂时没有找到合适的替代方法
    ImagePicker imagePicker = ImagePicker();
    PickedFile image = await imagePicker.getImage(source: source);
    print(image.runtimeType.toString());
    setState(() {
      //将用户照片存储到_image
      _image = File(image.path);
    });

    //上传

    var url = Uri.parse(Api.url + "/cs1902/user/image/" + uid);
    var request = new http.MultipartRequest('POST', url);
    var multipartFile = await http.MultipartFile.fromPath('data', image.path);
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    print('上传');
    print(response.statusCode);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: '修改成功',
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.of(context).pop();
      getAllTitle();
    }
  }

  _upLoadImage(File image) async {
    // FormData formData = FormData.from({
    //   //"": "", //这里写其他需要传递的参数
    //   "file": UploadFileInfo(image, "imageName.png"),
    // });
    // var response =
    //     await Dio().post(Api.url + "/user/imgupload/" + uid, data: formData);
    // Map responseMap = response.data;
    // print(Api.url + "/user/imgupload/" + uid + "${responseMap["path"]}");
    // setState(() {
    //   _avatarPath = "http://jd.itying.com${responseMap["path"]}";
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          leading: IconButton(
            icon: new Icon(Icons.chevron_left, color: Colors.black, size: 30),
            onPressed: () {
              print(aList["name"]);
              Navigator.of(context).pop({"flag": flag, "name": aList["name"]});
            },
          ),
          title: Text(
            '个人资料',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
            decoration: new BoxDecoration(color: Color(0xFFF4EFEF)),
            // child: rotationChart(),
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverList(
                  delegate: new SliverChildListDelegate(
                    [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => changeNamePage()));
                          },
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: 180,
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        choosePic(
                                                            ImageSource.camera);
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 50,
                                                        decoration:
                                                            new BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)),
                                                        child: Container(
                                                            alignment:
                                                                Alignment(0, 0),
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 15,
                                                                    left: 20,
                                                                    bottom: 15),
                                                            child: Text('拍照',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16))),
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                        choosePic(ImageSource
                                                            .gallery);
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 5),
                                                        width: double.infinity,
                                                        height: 50,
                                                        decoration:
                                                            new BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)),
                                                        child: Container(
                                                            alignment:
                                                                Alignment(0, 0),
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 15,
                                                                    left: 20,
                                                                    bottom: 15),
                                                            child: Text(
                                                                '从相册中选择',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16))),
                                                      )),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    width: double.infinity,
                                                    height: 50,
                                                    decoration:
                                                        new BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255)),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Container(
                                                          alignment:
                                                              Alignment(0, 0),
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 15,
                                                                  left: 20,
                                                                  bottom: 15),
                                                          child: Text('取消',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16))),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      width: double.infinity,
                                      height: 80,
                                      decoration: new BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 15, left: 20, bottom: 15),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(child: (Text('我的头像'))),
                                              Container(
                                                child: Row(children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    height: 50,
                                                    width: 50,
                                                    decoration:
                                                        new BoxDecoration(
                                                            color: Color
                                                                .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        150),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    aList['avatar_url']
                                                                        .toString()),
                                                                fit:
                                                                    BoxFit.cover
                                                                // centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                                                                )),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 15),
                                                      alignment:
                                                          Alignment(1, 0),
                                                      child: Icon(
                                                          Icons.chevron_right,
                                                          color: Colors.black,
                                                          size: 20))
                                                ]),
                                              )
                                            ],
                                          )
                                        ]),
                                      ),
                                    ))
                              ],
                            ),
                            alignment: Alignment.center,
                          )),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => changeNamePage()))
                                .then((name) {
                              setState(() {
                                if (name["flag"] == true)
                                  aList['name'] = name["name"];
                                flag = name["flag"];
                              });
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: double.infinity,
                            height: 50,
                            decoration: new BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            child: Container(
                                margin: const EdgeInsets.only(
                                    top: 15, left: 20, bottom: 15),
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(child: (Text('我的昵称'))),
                                          Container(
                                              child: Row(
                                            children: [
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(right: 5),
                                                  alignment: Alignment(1, 0),
                                                  child: Text(
                                                    aList['name'],
                                                    style: TextStyle(
                                                        color: Colors.black38),
                                                  )),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 15),
                                                  alignment: Alignment(1, 0),
                                                  child: Icon(
                                                      Icons.chevron_right,
                                                      color: Colors.black,
                                                      size: 20))
                                            ],
                                          ))
                                        ]),
                                  ],
                                )),
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 1),
                        width: double.infinity,
                        height: 50,
                        decoration: new BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Container(
                            margin: const EdgeInsets.only(
                                top: 15, left: 20, bottom: 15),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                mineTitleAllPage()));
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(child: (Text('我的称号'))),
                                        Container(
                                            child: Row(
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 5),
                                                alignment: Alignment(1, 0),
                                                child: Text(
                                                  aList['title']['title_name'],
                                                  style: TextStyle(
                                                      color: Colors.black38),
                                                )),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 15),
                                                child: Icon(Icons.chevron_right,
                                                    color: Colors.black,
                                                    size: 20))
                                          ],
                                        ))
                                      ]),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
