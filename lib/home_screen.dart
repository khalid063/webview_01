import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Color mainColor = Color(0xff734d9f);
  bool _isLoading = true;
  late WebViewController controller;
  final Completer<WebViewController> _controller = Completer<WebViewController>();   // default


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Crow & Ferret'),
        centerTitle: true,
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: 'https://crowandferret.com/',
          javascriptMode: JavascriptMode.unrestricted,

          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            //print("WebView is loading (progress : $progress%)");
          },
          // javascriptChannels: <JavascriptChannel>{
          //   _toasterJavascriptChannel(context),
          // },

          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) async {
            setState(() {
              _isLoading = false;
            });
            // final gotCookies = await cookieManager
            //     .getCookies('https://crowandferret.com/');
            // for (var item in gotCookies) {
            //   print(item);
            // }
          },
          backgroundColor: Colors.white,
          gestureNavigationEnabled: true,
          geolocationEnabled: true, //support geolocation or not
        );
      }),
    );
  }
}
