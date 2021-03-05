import 'package:AFCSCMS/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:AFCSCMS/webview/webview_screen.dart';
import 'package:AFCSCMS/account/components/rounded_button.dart';

class NoConnectionScreen extends StatefulWidget {
  final String url;
  const NoConnectionScreen(this.url);
  @override
  LoginScreenState createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<NoConnectionScreen> {
  bool isLoading = false;
  String message = "Oops! Check your internet connection and try again.";

  @override
  void initState() {
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
                RoundedButton(
                  text: "Try Again",
                  press: () {
                    _tryagain(context);
                  },
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
    )));
  }

  _tryagain(context) {
    print('try agin');
    String url = widget.url;
    if (url == '' || url == null) {
      url = AppConstants.apiDashboardUrl;
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WebviewScreen(url)));
  }
}
