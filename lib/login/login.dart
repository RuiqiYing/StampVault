import 'dart:convert';

import 'package:code/common/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

final TextEditingController phoneNumberController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();
//设置暂存，将用户信息储存起来在后面的过程中可以随时调用
setUserName(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('id', id);
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyScaff(),
      decoration: BoxDecoration(
        //设置背景图
        image: DecorationImage(
          image: AssetImage("lib/assets/loginimages/login_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MyScaff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        //设置向导栏，包括登录和返回字样
        elevation: 0, //将向导栏的阴影设为0，确保全透明
        backgroundColor: Colors.transparent, //将向导栏设为透明颜色
        title: Text(
          "登录",
          style: TextStyle(fontSize: 20.0),
        ),
        centerTitle: true,
        leadingWidth: 75.0,
        leading: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Text(
            " ",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: MyText(),
      ),
    );
  }
}

//设置字样
class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center, //容器居中
        child: Column(
          children: [
            //用children同时表示多个字样
            SizedBox(height: 120), //空盒子用于控制距离
            Row(
              mainAxisAlignment: MainAxisAlignment.center, //居中
              children: [
                Text(
                  "欢迎使用邮斋!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            InputNumber(),
            SizedBox(
              height: 20,
            ),
            InputPassword(),
            SizedBox(
              height: 20,
            ),
            LoginButton(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, //将3个盒子合理规划位置
              children: [
                TextButton(
                    onPressed: () {
                      phoneNumberController.clear();
                      passwordController.clear();
                      Navigator.pushNamed(
                        context,
                        '/forget_password',
                      );
                    },
                    child: Text(
                      "忘记密码",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    )),
                Text(
                  "|",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      phoneNumberController.clear();
                      passwordController.clear();
                      Navigator.pushNamed(context, '/sign_up');
                    },
                    child: Text(
                      "注册新用户",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ],
        ));
  }
}

//输入手机号
class InputNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: 300.0, //控制容器的宽度

        alignment: Alignment.center,
        child: TextField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11)
          ], //设置只能输入数字
          keyboardType: TextInputType.number,
          controller: phoneNumberController,
          //文本域定义，最大显示一行
          maxLines: 1,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(width: 2, color: Colors.white)),
            labelText: '手机号',
            labelStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

//输入密码
class InputPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: 300.0,
        alignment: Alignment.center,
        child: TextField(
          controller: passwordController,
          maxLines: 1,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(width: 2, color: Colors.white)),
            labelText: '密码',
            labelStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
          style: TextStyle(color: Colors.white),
          obscureText: true,
        ),
      ),
    );
  }
}

//登录按钮
class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        String username = phoneNumberController.text;
        String password = passwordController.text;
        print('点击了登录!');
        print('用户名:' + phoneNumberController.text);
        print('密码:' + passwordController.text);
        _login(username, password, context);
      },
      child: Container(
          width: 300.0,
          padding: EdgeInsets.fromLTRB(2, 10, 2, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.green,
          ),
          alignment: Alignment.center,
          child: Text(
            '登录',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          )),
    );
  }
}

//登录函数
_login(String username, String password, BuildContext context) async {
  //json
  var url = Uri.parse(Api.url + '/cs1902/user/login');
  var response = await http.post(url,
      headers: {"content-type": "application/json"},
      body: '{"account": "${username}", "password": "' + password + '"}');
  print('Response body: ${response.body}');
  if (response.body != '请输入正确的手机号或邮箱' &&
      response.body != '用户名或密码错误' &&
      response.body != '密码错误') {
    Fluttertoast.showToast(msg: '欢迎');
    String test = jsonDecode(Utf8Codec().decode(response.bodyBytes))['uid'];
    setUserName(test);
    Navigator.of(context).pop();
    Navigator.pushNamed(context, '/bottom',
        arguments: {'username': username, 'password': password});
  } else
    Fluttertoast.showToast(msg: '用户名或密码错误');
  phoneNumberController.clear();
  passwordController.clear();
}

// class SpUtil {
//   static SharedPreferences prefs;
//   // static PackageInfo packageInfo;
//   static Future<bool> getInstance() async {
//     prefs = await SharedPreferences.getInstance();
//     return true;
//   }

//   static Future<bool> getUserName() async {
//     prefs = await SharedPreferences.getInstance();
//     return true;
//   }
// }
