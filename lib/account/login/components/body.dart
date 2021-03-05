import 'package:AFCSCMS/webview/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:AFCSCMS/account/login/components/background.dart';
import 'package:AFCSCMS/account/signup/signup_screen.dart';
import 'package:AFCSCMS/account/components/already_have_an_account_acheck.dart';
import 'package:AFCSCMS/account/components/rounded_button.dart';
import 'package:AFCSCMS/account/components/rounded_input_field.dart';
import 'package:AFCSCMS/account/components/rounded_password_field.dart';

import 'package:http/http.dart' as http;

import '../../../util/app_constants.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  _login(context) {
    if (false) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebviewScreen(AppConstants.apiHomeUrl)));
    }
    return CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/login.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
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
      ),
    );
  }
}
