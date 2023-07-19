import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_archery/ui/pages/main/main_controller.dart';
import 'package:my_archery/utils/endpoint.dart';
import 'package:my_archery/utils/screen_util.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';

fadeIn(Widget widget, int durationms){
  return FadeIn(
    child: widget,
    duration: Duration(milliseconds: durationms),
    curve: Curves.easeIn,
  );
}

bool isTesting(){
  return baseUrl.contains("staging") || baseUrl.contains("demo");
}

bannerStaging(){
  return Container(
    width: Get.width,
    child: Align(
      child: Banner(message: "Testing", textStyle: boldTextFont.copyWith(color: Colors.black, fontSize: fontSize(8)), location: BannerLocation.topEnd, color: Colors.yellow,),
      alignment: Alignment.topRight,
    ),
  );
}

goToPage(Widget page, {bool? dismissPage, bool? dismissAllPage}){
  if(dismissAllPage != null){
    Get.offAll(page);
    return;
  }

  if(dismissPage != null){
    Navigator.of(Get.context!).pushReplacement(createRoute(page));
    return;
  }
  Navigator.of(Get.context!).push(createRoute(page));
}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

String convertImagetoBase64(File fileData) {
  List<int> imageBytes = fileData.readAsBytesSync();
  return base64Encode(imageBytes);
}

String decodeBase64(String value) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String decoded = stringToBase64.decode(value);
  return decoded;
}

launchURL(String url, Map<String, String> headers, {bool? enableJs, bool? forceWebview}) async {
  print("url : $url, headers : ${headers.toString()}");
  if (await canLaunch(url)) {
    await launch(url,
        enableJavaScript: (enableJs != null) ? enableJs : false,
        forceWebView: (forceWebview != null) ? forceWebview : false,
        headers: headers);
  } else {
    throw 'Could not launch $url';
  }
}

DateTime convertDateFormat(
    String inFormat, String outFormat, String inputDate) {
  DateFormat inputFormat = DateFormat(inFormat);
  DateTime dateTime = inputFormat.parse(inputDate);
  DateFormat outputFormat = DateFormat(outFormat);
  return outputFormat.parse(dateTime.toString());
}

int getCurrentTimestamp() {
  return new DateTime.now().millisecondsSinceEpoch;
}

String getCurrentFormatedTime(String format) {
  var now = new DateTime.now();
  var formatter = new DateFormat('$format');
  String formattedDate = formatter.format(now);
  return formattedDate;
}

String formattingNumber(dynamic number) {
  return NumberFormat.currency(locale: "id", symbol: "Rp ").format(number);

  // return display(number);
}

String secureNumber(String number) {
  return number.replaceAll(RegExp(r'.(?=.{4})'), '*');
}


closeKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}

makeLine() {
  return Divider(
    color: line,
    thickness: ScreenUtil().setHeight(10),
  );
}

makeLineHeight(double heigh) {
  return Divider(
    color: line,
    thickness: heigh,
  );
}

makePullViewIndicator() {
  return Center(
    child: SizedBox(
      width: ScreenUtil().setWidth(50),
      height: ScreenUtil().setHeight(10),
      child: Card(
        color: Colors.grey,
      ),
    ),
  );
}

viewEmpty() {
  return Container(
    width: Get.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        hSpace(25),
        Text(
          "Tidak ada data",
          style: boldTextFont.copyWith(fontSize: ScreenUtil().setSp(12)),
        )
      ],
    ),
  );
}

border(Color borderColor){
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
      borderSide: BorderSide(
        color: borderColor,
      ));
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

unFocusTextField(BuildContext context) {
  FocusScope.of(context).unfocus();
  new TextEditingController().clear();

  // FocusScope.of(context).requestFocus(null);
}

vLine({double? value}){
  return Container(
    width: wValue(1),
    height: value != null ? value : 15,
    color: Colors.white,
  );
}

printLog({required msg}){
  if(kDebugMode){
    print("$msg");
  }
}

String getErrorMessage(var resp){
  String combinedMessage = "";

  resp.data["errors"].forEach((key, messages) {
    for (var message in messages) combinedMessage = combinedMessage + "- $message\n";
  });

  return combinedMessage;
}

checkLogin(resp){
  if (resp.statusCode == 401 || resp.statusCode == 403) {
    var controller = MainController();
    controller.logoutAction();
    return;
  }
}
