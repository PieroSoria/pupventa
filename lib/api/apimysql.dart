import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Apiconnect{
  Future<bool> login2(String user, String pass) async {
    var url = "http://rmc.pe/validarusu.php";
    final response = await http.post(Uri.parse(url), body: jsonEncode({
      "user": user.toString(),
      "pass": pass.toString(),
    }));
    debugPrint(json.decode(response.body).toString());
    var responseInfo = await json.decode(response.body);
    if (responseInfo[0]['pass'] == pass.toString() && responseInfo[0]['user'] == user.toString()) {
      return true;
    }
    return false;
  }
}