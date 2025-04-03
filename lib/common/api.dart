import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Api {
  static final String url = "http://101.37.175.115:9833";

  static String md5(String plain) {
    var content = new Utf8Encoder().convert(plain);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  static Future<int> check(String username, BuildContext context) async {
    //json
    var url = Uri.parse(Api.url + '/user/check?username=' + username);
    var response = await http.post(url);
    print('Response body: ${response.body}');
    if (response.body == '1')
      return 1;
    else
      return 0;
  }
}
