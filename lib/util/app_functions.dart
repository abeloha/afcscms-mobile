import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:AFCSCMS/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppFunctions {
  AppFunctions._();

  //title of pages
  static userLogin(email, password) async {
    print('userLogin started');

    var data;
    var infos =
        '{"status":false,"message":"Could not connect. Check your internet connectivity."}';

    try {
      var response = await http.get(AppConstants.apiLoginUrl +
          '/?email=' +
          email +
          '&password=' +
          password);

      print('userLogin done');

      if (response.statusCode == 201 || response.statusCode == 200) {
        infos = response.body;
        print('Connected');
      } else {
        print('Not Connected');
      }
    } on SocketException {
      print('Connection timed out');
    }

    data = json.decode(infos);
    return data;
  }

  static getUserLoginData() async {
    print('checkUserData Started');
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userEmail = pref.getString('email');
    String userPassword = pref.getString('password');
    var data = {'email': userEmail, 'password': userPassword};
    print(data);
    print('checkUserData Done');
    return data;
  }

  static setUserData(email, password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    print('setUserData saved');
  }

  static removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('password');
    print('password removed');
  }

  static getUserDataAndLogin() async {
    final data = await getUserLoginData();
    final login = await userLogin(data['email'], data['password']);
    var info = {
      'status': login['status'],
      'message': login['message'],
      'email': data['email'],
      'password': data['password']
    };
    return info;
  }
}
