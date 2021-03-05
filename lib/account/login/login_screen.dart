import 'package:AFCSCMS/util/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:AFCSCMS/webview/webview_screen.dart';
import 'package:AFCSCMS/account/components/already_have_an_account_acheck.dart';
import 'package:AFCSCMS/account/components/rounded_button.dart';
import 'package:AFCSCMS/account/components/rounded_input_field.dart';
import 'package:AFCSCMS/account/components/rounded_password_field.dart';

import '../../util/app_constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String message;
  String userEmail;
  String userPassword;

  @override
  void initState() {
    AppFunctions.getUserLoginData().then((value) {
      setState(() {
        print(value);
        userEmail = value['email'];
        userPassword = value['password'];
        if (userEmail != '' &&
            userPassword != '' &&
            userEmail != null &&
            userPassword != null) {
          _login(context);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.005),
                Image.asset(
                  "assets/images/login.png",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  message ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),
                RoundedInputField(
                  hintText: "Your Email",
                  onChanged: (value) {
                    userEmail = value;
                  },
                  initialValue: userEmail,
                ),
                RoundedPasswordField(
                  initialValue: userEmail,
                  onChanged: (value) {
                    userPassword = value;
                  },
                ),
                RoundedButton(
                  text: "LOGIN",
                  press: () {
                    _login(context);
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WebviewScreen(AppConstants.apiRegUrl)));
                  },
                ),
              ],
            ),
    )));
  }

  _login(context) {
    print('login');

    if (userEmail != '' &&
        userPassword != '' &&
        userEmail != null &&
        userPassword != null) {
      print('login processing');
      setState(() {
        isLoading = true;
      });

      print('email: ' + userEmail + ' Password: ' + userPassword);

      AppFunctions.userLogin(userEmail, userPassword).then((value) {
        setState(() {
          print(value);
          message = value['message'];
          isLoading = false;
          if (value['status'] == true) {
            AppFunctions.setUserData(userEmail, userPassword);
            //go to the app
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebviewScreen(
                        AppConstants.apiHomeUrl +
                            '/?email=' +
                            userEmail +
                            '&password=' +
                            userPassword)));
          }
        });
      });
    } else {
      print('login: Empty fields');
      setState(() {
        message = 'Email and password cannot be empty';
      });
    }
  }
}
