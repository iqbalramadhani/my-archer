import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:myarchery_archer/ui/pages/main/profile/profile_controller.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/date_symbol_data_local.dart';

isDebug(){
  return (baseUrl.contains("staging"));
}

fadeIn(Widget widget, int durationms){
  return FadeIn(
    child: widget,
    duration: Duration(milliseconds: durationms),
    curve: Curves.easeIn,
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

dynamic goToPageWithResult(Widget page) async {
  final result = await Navigator.push(
    Get.context!,
    MaterialPageRoute(builder: (context) => page),
  );
  return result;
}

bool isEmailValid(String email){
  return email.isEmail;
}

Future<File> cropImage({required String path}) async {
  File? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Sesuaikan Ukuran Foto',
          toolbarColor: colorPrimary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
  );

  return croppedFile!;
}

Future<File> compressFile({required File file, required String targetPath, int? quality}) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path, targetPath,
    quality: quality ?? 60,
  );

  print(file.lengthSync());
  print(result!.lengthSync());

  return result;
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
  return "data:image/jpeg;base64,${base64Encode(imageBytes)}";
}

launchURL(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}

String convertDateFormat(String inFormat, String outFormat, String date) {
  initializeDateFormatting();

  DateTime parseDate = new DateFormat("$inFormat").parse(date);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('$outFormat', "id");
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}

int convertDateFormatIntoTimestamp(String inFormat, String date) {
  initializeDateFormatting();

  DateTime parseDate = new DateFormat("$inFormat").parse(date);
  var inputDate = DateTime.parse(parseDate.toString());
  return inputDate.millisecondsSinceEpoch;
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
  var nbr = NumberFormat.currency(locale: "id", symbol: "Rp ").format(number);
  if(nbr.contains(",")){
    nbr = nbr.split(",").first;
  }
  return nbr;
}

String secureNumber(String number) {
  return number.replaceAll(RegExp(r'.(?=.{4})'), '*');
}

getPrice(String number){
  if(number.contains(".")) {
    return number.split(".").first;
  }else{
    return number;
  }
}


closeKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}

makeLine() {
  return Divider(
    color: line,
    thickness: hValue(10),
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
      width: wValue(50),
      height: hValue(10),
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
        Text(
          "Tidak ada data",
          style: boldTextFont.copyWith(fontSize: fontSize(12)),
        )
      ],
    ),
  );
}

imageRadius(String url, double width, double height, double radius, {String? placeholder, BoxFit? boxFit,}) {
  return Container(
    width: width,
    height:  height,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        '$url',
        width: width,
        height:  height,
        fit: boxFit ?? BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          return Image.asset(placeholder == null ? "assets/img/img_placeholder.png" : placeholder, fit: BoxFit.cover,);
        },
      ),
    ),
  );
}

imageRadiusLocal(String path, double width, double height, double radius, {String? placeholder, bool? isFile,}) {
  return Container(
    width: width,
    height:  height,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: isFile != null && isFile ? Image.file(
        File('$path'),
        width: width,
        height:  height,
        fit: BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          return Image.asset(placeholder == null ? "assets/img/img_placeholder.png" : placeholder, fit: BoxFit.cover,);
        },
      ) : Image.asset(
        '$path',
        width: width,
        height:  height,
        fit: BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          return Image.asset(placeholder == null ? "assets/img/img_placeholder.png" : placeholder, fit: BoxFit.cover,);
        },
      ),
    ),
  );
}

String convertTeamCategory(String teamCategoryId){
  var nameTeamCategory = "";
  if(teamCategoryId == "individu male"){
    nameTeamCategory = "Individu Putra";
  }else if(teamCategoryId == "individu female"){
    nameTeamCategory = "Individu Putri";
  }else if(teamCategoryId == "individu female"){
    nameTeamCategory = "Individu Putri";
  }else if(teamCategoryId == "male_team"){
    nameTeamCategory = "Beregu Putra";
  }else if(teamCategoryId == "female_team"){
    nameTeamCategory = "Beregu Putri";
  }else if(teamCategoryId == "mix_team"){
    nameTeamCategory = "Beregu Campuran";
  }

  return nameTeamCategory;
}

circleAvatar(String url, double width, double height, {double? radius}) {
  return Container(
    child: CircleAvatar(
      radius: radius != null ? radius : wValue(50),
      backgroundImage: AssetImage("assets/img/img_placeholder_circle.png"),
      backgroundColor: Colors.transparent,
      foregroundImage: NetworkImage("$url"),
    ),
    width: width,
    height: height,
  );
}

circleAvatarLocal(String path, double width, double height, {double? radius}) {
  return Container(
    child: CircleAvatar(
      radius: radius != null ? radius : wValue(50),
      backgroundImage: AssetImage("assets/img/img_placeholder_circle.png"),
      backgroundColor: Colors.transparent,
      foregroundImage: FileImage(File("$path")),
    ),
    width: width,
    height: height,
  );
}

printLog({String? msg}){
  debugPrint("$msg");
}

border(Color borderColor, {double? radius}){
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius != null ? radius : 4.0)),
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

String getErrorMessage(var resp){
  String combinedMessage = "";

  resp.data["errors"].forEach((key, messages) {
    for (var message in messages) combinedMessage = combinedMessage + "- $message\n";
  });

  return combinedMessage;
}

Widget labelView(String title, Color? textColor, Color? bgColor, {bool? isBold, EdgeInsetsGeometry? padding}){
  return Card(
    color: bgColor ?? Color(0xFFFFF2D9),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(wValue(10))),
    child: Container(
      padding: padding ?? EdgeInsets.only(left: wValue(10), right: wValue(10), top: wValue(5), bottom: wValue(5)),
      child: Text("$title", style: isBold != null && isBold ? boldTextFont.copyWith(fontSize: fontSize(10), color: textColor ?? Color(0xFFE86F00)) : regularTextFont.copyWith(fontSize: fontSize(10), color: textColor ?? Color(0xFFE86F00)),maxLines: 1,),
    ),
  );
}

checkLogin(resp){
  if (resp.statusCode == 401 || resp.statusCode == 403) {
    var controller = ProfileController();
    controller.logoutAction();
    return;
  }
}