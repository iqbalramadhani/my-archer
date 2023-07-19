import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../main/main_screen.dart';

class WebviewScreen extends StatefulWidget {
  final String url;
  final String title;
  final String? from;
  const WebviewScreen({Key? key, required this.title, required this.url, this.from}) : super(key: key);

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  bool isShowLoading = true;


  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: SafeArea(
        child: WillPopScope(
          child: Scaffold(
            body: Column(
              children: [
                appBar("${widget.title}", (){
                  _willPopCallback();
                }),
                if(isShowLoading) LinearProgressIndicator(
                  backgroundColor: Colors.red,
                ),
                // Text('${widget.url}'),
                Expanded(child: WebView(
                  initialUrl: '${widget.url}',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  onProgress: (int progress) {
                    print("WebView is loading (progress : $progress%)");
                    if(progress >= 100){
                      setState(() {
                        isShowLoading = false;
                      });
                    }
                  },
                  javascriptChannels: <JavascriptChannel>{
                    _toasterJavascriptChannel(context),
                  },
                  navigationDelegate: (NavigationRequest request) {
                    if (request.url.startsWith('https://www.youtube.com/')) {
                      print('blocking navigation to $request}');
                      return NavigationDecision.prevent;
                    }
                    if(request.url.startsWith('gojek://')){
                      launchURL(request.url);
                      return NavigationDecision.prevent;
                    }
                    print('allowing navigation to $request');
                    return NavigationDecision.navigate;
                  },
                  onPageStarted: (String url) {
                    print('Page started loading: $url');
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                  },
                  gestureNavigationEnabled: true,
                ), flex: 1,)
              ],
            ),
          ),
          onWillPop: _willPopCallback,
        ),
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    if(widget.from != null && widget.from == "order_event"){
      Get.offAll(MainScreen());
    }else
      Get.back();

    return Future.value(true);
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
