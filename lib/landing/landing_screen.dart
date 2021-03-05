import 'package:AFCSCMS/webview/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:AFCSCMS/landing/components/animated_background.dart';
import 'package:AFCSCMS/landing/components/animated_slogan_text.dart';
import 'package:AFCSCMS/landing/components/animated_text.dart';
import 'package:AFCSCMS/landing/components/spread_circles.dart';
import 'package:AFCSCMS/landing/components/stacked_circles.dart';

import 'package:AFCSCMS/account/login/login_screen.dart';

import '../util/app_constants.dart';

class LandingScreen extends StatefulWidget {
  @override
  State createState() => new LandingScreenState();
}

class LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  AnimationController buttonAnimationController;
  Animation<AlignmentGeometry> buttonAlignment;
  Animation<double> buttonOpacity;

  @override
  void initState() {
    super.initState();
    buttonAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));

    buttonAlignment = new AlignmentTween(
      begin: new Alignment(0.0, 1.0),
      end: new Alignment(0.0, 0.95),
    ).animate(new CurvedAnimation(
      parent: buttonAnimationController,
      curve: new Interval(0.3, 0.9, curve: Curves.easeInOut),
    ));
    buttonOpacity = new Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(new CurvedAnimation(
      parent: buttonAnimationController,
      curve: new Interval(0.3, 1.0, curve: Curves.easeInOut),
    ));

    buttonAlignment.addListener(() {
      setState(() {});
    });
    buttonOpacity.addListener(() {
      setState(() {});
    });

    buttonAnimationController.forward();
  }

  @override
  void dispose() {
    buttonAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new AnimatedBackground(),
          _buildStackedCircles(),
          new SpreadCircles(),
          _buildButtomButtons(),
          _buildAnimatedText(),
        ],
      ),
    );
  }

  Widget _buildAnimatedText() {
    final animatedTextDelay = 800;

    return new Align(
        alignment: new Alignment(-1.0, -0.75),
        child: new Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new AnimatedText(
                  "Armed Forces and Command Staff College", animatedTextDelay,
                  durationInMilliseconds: 2500),
              new AnimatedSloganText(animatedTextDelay + 2500),
            ],
          ),
        ));
  }

  Widget _buildStackedCircles() {
    final circleDiameter = 25.0;
    return new Align(
      alignment: new Alignment(0.0, -0.9),
      child: new Hero(
        tag: "CircleHeroTag",
        child: new StackedCircles(circleDiameter),
      ),
    );
  }

  Widget _buildButtomButtons() {
    return new AnimatedBuilder(
        animation: buttonAnimationController,
        child: new Container(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _signInButton(),
              new Padding(padding: const EdgeInsets.only(bottom: 10.0)),
              _createAccountButton(),
              new Padding(padding: const EdgeInsets.only(bottom: 10.0)),
            ],
          ),
        ),
        builder: (BuildContext context, Widget child) {
          return new Align(
            alignment: buttonAlignment.value,
            child: new Opacity(
              opacity: buttonOpacity.value,
              child: child,
            ),
          );
        });
  }

  Widget _createAccountButton() {
    return new GestureDetector(
      child: new Material(
        child: new Container(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(5.0),
            gradient: new LinearGradient(colors: <Color>[
              Colors.red,
              Colors.redAccent,
            ]),
          ),
          alignment: Alignment.center,
          child: new Text(
            "Create account",
            style: new TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebviewScreen(AppConstants.apiRegUrl)));
      },
    );
  }

  Widget _signInButton() {
    return new GestureDetector(
      child: new Material(
        child: new Container(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(5.0),
            gradient: new LinearGradient(colors: <Color>[
              Colors.blue.withAlpha(150),
              Colors.blue.withAlpha(100),
            ]),
          ),
          alignment: Alignment.center,
          child: new Text(
            "Login",
            style: new TextStyle(
                color: Colors.black54,
                fontSize: 16.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
    );
  }
}
