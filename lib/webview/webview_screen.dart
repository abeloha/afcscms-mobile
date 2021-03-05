import 'dart:async';
import 'package:AFCSCMS/account/login/login_screen.dart';
import 'package:AFCSCMS/util/app_functions.dart';
import 'package:AFCSCMS/webview/no_connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

//String selectedUrl = AppConstants.apiBaseUrl;

class WebviewScreen extends StatefulWidget {
  final String url;
  const WebviewScreen(this.url);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WebviewScreen> {
  // Instance of WebView plugin
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  StreamSubscription _onDestroy;
  StreamSubscription<double> _onProgressChanged;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loaded = false;
  String lastUrl = '';

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.launch(widget.url);
    postInit(() {
      flutterWebViewPlugin.resize(_buildRect());
    });

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.
        _scaffoldKey.currentState.showSnackBar(
            const SnackBar(content: const Text('Webview Destroyed')));
      }
    });

    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          lastUrl = url;
          if (url.contains('/login') || url.contains('/logout')) {
            print('login / logout of app');
            AppFunctions.removeUserData();
            flutterWebViewPlugin.dispose();
            flutterWebViewPlugin.close();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          } else {
            print(url);
            _scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text('Loading')));
          }
        });
      }
    });

    _onProgressChanged =
        flutterWebViewPlugin.onProgressChanged.listen((double progress) {
      if (mounted) {
        setState(() {
          progress = progress * 100;
          String progressPercent = progress.toStringAsFixed(2);
          String msg = 'Loading: $progressPercent %';
          if (progress < 50) {
            loaded = false;
          } else {
            loaded = true;
          }
          print(msg);
        });
      }
    });

    _onHttpError =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
      if (mounted) {
        print('Error loading page');
        flutterWebViewPlugin.dispose();
        flutterWebViewPlugin.close();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => NoConnectionScreen(lastUrl)));
      }
    });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onHttpError.cancel();
    _onUrlChanged.cancel();
    _onProgressChanged.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return Scaffold(
        key: _scaffoldKey,
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Rect _buildRect() {
    final topPadding = MediaQuery.of(context).padding.top;
    final top = topPadding;
    var height = MediaQuery.of(context).size.height - top;
    height -= 0.0 + MediaQuery.of(context).padding.bottom;

    if (height < 0.0) {
      height = 0.0;
    }

    return new Rect.fromLTWH(
        0.0, top, MediaQuery.of(context).size.width, height);
  }

  Stream waitForStateLoading() async* {
    while (!mounted) {
      yield false;
    }
    yield true;
  }

  Future<void> postInit(VoidCallback action) async {
    await for (var isLoaded in waitForStateLoading()) {}
    action();
  }
}
