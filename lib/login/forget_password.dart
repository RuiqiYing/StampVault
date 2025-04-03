import 'package:http/http.dart' as http;
import 'package:code/common/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;

class ForgetPassword extends StatelessWidget {
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
          "修改密码",
          style: TextStyle(fontSize: 20.0),
        ),
        centerTitle: true,
        leadingWidth: 75.0,
        leading: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: TextButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(100, 20))),
              onPressed: () {
                passwordsureController.clear(); //在跳转其他页面时清空本页面已经填入的数据
                passwordController.clear();
                newpasswordController.clear();
                emailController.clear();
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                "<返回",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ),
      ),
      body: SingleChildScrollView(
        //防止页面溢出
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
            SizedBox(height: 70), //空盒子用于控制距离
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
            ), //将后续的部件都加入大部件的盒子中
            SizedBox(
              height: 20,
            ),
            InputNumber(),
            SizedBox(
              height: 15,
            ),
            InputPassword(),
            SizedBox(
              height: 15,
            ),
            InputNewPassword(),
            SizedBox(
              height: 15,
            ),
            SurePassword(),
            SizedBox(
              height: 15,
            ),
            ChangeButton(),
            SizedBox(height: 20),
          ],
        ));
  }
}

//给输入框定义控制部件
TextEditingController passwordsureController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
TextEditingController newpasswordController = new TextEditingController();
TextEditingController emailController = new TextEditingController();

//输入手机号
class InputNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: 300.0,
        alignment: Alignment.center,
        child: TextField(
          controller: emailController,
          maxLines: 1,
          decoration: InputDecoration(
            //设计输入框的样式
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(width: 2, color: Colors.white)),
            labelText: '邮箱地址',
            labelStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

//输入原密码
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
            labelText: '原密码',
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

//输入密码
class InputNewPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: 300.0,
        alignment: Alignment.center,
        child: TextField(
          controller: newpasswordController,
          maxLines: 1,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(width: 2, color: Colors.white)),
            labelText: '新密码',
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

//确认密码
class SurePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: 300.0,
        alignment: Alignment.center,
        child: TextField(
          controller: passwordsureController,
          maxLines: 1,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(width: 2, color: Colors.white)),
            labelText: '确认密码',
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

//修改密码按钮
class ChangeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bool email(String input) {
          //函数判断是否为邮箱格式
          if (input == null || input.isEmpty) return false;
          String regexEmail =
              "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
          return RegExp(regexEmail).hasMatch(input);
        }

        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            newpasswordController.text.isNotEmpty &&
            passwordsureController.text.isNotEmpty &&
            email(emailController.text)) {
          //确保输入
          if (newpasswordController.text != passwordsureController.text)
            Fluttertoast.showToast(msg: '两次输入的密码不一致!');
          else {
            String username = emailController.text;
            String password = passwordController.text;
            String newpassword = newpasswordController.text;
            print('点击了修改密码!');
            print('用户名:' + emailController.text);
            print('原密码:' + passwordController.text);
            print('新密码:' + newpasswordController.text);
            print('确认密码:' + newpasswordController.text);
            _update(username, password, newpassword, context);
          }
        } else {
          if (emailController.text.isEmpty) //弹出错误原因
            Fluttertoast.showToast(msg: '请输入邮箱地址!');
          else if (email(emailController.text) != true)
            Fluttertoast.showToast(msg: '请输入正确的邮箱地址!');
          else if (passwordController.text.isEmpty)
            Fluttertoast.showToast(msg: '请输入原密码!');
          else if (newpasswordController.text.isEmpty)
            Fluttertoast.showToast(msg: '请输入新密码!');
          else if (passwordsureController.text.isEmpty)
            Fluttertoast.showToast(msg: '请确认新密码!');
        }
      },
      child: Container(
          //修改密码按钮
          width: 300.0,
          padding: EdgeInsets.fromLTRB(2, 10, 2, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.green,
          ),
          alignment: Alignment.center,
          child: Text(
            '修改密码',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          )),
    );
  }
}

//更新密码函数
_update(String username, String old_password, String new_password,
    BuildContext context) async {
  var url = Uri.parse(Api.url + '/cs1902/user/pwd');
  var response = await http.post(url,
      headers: {"content-type": "application/json"},
      body:
          '{"account": "${username}", "old_password": "${old_password}","new_password": "${new_password}"}');
  print('Response body: ${response.body}');
  if (response.body == "失败")
    Fluttertoast.showToast(msg: '修改失败!');
  else if (response.body == "成功") Fluttertoast.showToast(msg: '修改成功!');
}
