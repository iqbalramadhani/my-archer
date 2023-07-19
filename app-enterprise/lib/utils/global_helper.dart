import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:myarcher_enterprise/core/controllers/profile_controller.dart';
import 'package:myarcher_enterprise/core/models/objects/profile_model.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/shared/dialog.dart';
import 'package:myarcher_enterprise/ui/shared/loading.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/translator.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalHelper {

  var box = GetStorage();

  String formattingNumber(dynamic number) {
    return NumberFormat.simpleCurrency(decimalDigits: 0, locale: "id_ID")
        .format(number);
  }

  Future<Position> getCurrentLoc() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  webLaunch(String url, {bool? enableJs, bool? forceWebview}) async {
    await launch(
      url,
      enableJavaScript: (enableJs != null) ? enableJs : false,
      forceWebView: (forceWebview != null) ? forceWebview : false,
    );
  }

  Future<String> convertImagetoBase64(File fileData) async {
    late Uint8List bytes;
    try{
      bytes = await fileData.readAsBytes();
    }catch(e){
      print("error convert => ${e.toString()}");
    }
    return base64Encode(bytes);
  }

  fadeIn({required Widget widget, required int durationms}){
    return FadeIn(
      duration: Duration(milliseconds: durationms),
      curve: Curves.easeIn,
      child: widget,
    );
  }

  String getError(resp){
    var msg = "";
    if(resp['message'] != null){
      msg = resp['message'];
    }else if(resp['error'] != null){
      msg = resp['error'];
    }else{
      msg = Translator.failedToRequest.tr;
    }
    return msg;
  }

  makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  printLog({required msg}){
    if(kDebugMode){
      print("$msg");
    }
  }


  border(Color borderColor, {double? radius}){
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? wValue(15))),
        borderSide: BorderSide(
          color: borderColor,
        ));
  }

  sendEmail(String email) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Subject'
      }),
    );
    await launchUrl(emailLaunchUri);
  }

  closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  bool isEmailValid(String email){
    return EmailValidator.validate(email);
  }

  ProfileModel getCurrentUser(){
    ProfileModel user = ProfileModel();
    if(box.read(KeyValue.keyUser) != null){
      try {
        user = box.read(KeyValue.keyUser);
      } catch (_) {
        user = ProfileModel.fromJson(box.read(KeyValue.keyUser));
      }
    }

    return user;
  }

  imageRadius(String url, double width, double height, double radius, {String? placeholder, BoxFit? boxFit,}) {
    return SizedBox(
      width: width,
      height:  height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: url,
          width: width,
          height:  height,
          fit: boxFit ?? BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) => Container(
              padding: EdgeInsets.all(wValue(20)),
              child: loading(),
            ),
          errorWidget: (context, url, error) => Image.asset(placeholder ?? Assets.images.imgPlaceholder.path, fit: BoxFit.cover,),
        ),
      ),
    );
  }

  imageRadiusLocal(String path, double width, double height, double radius, {String? placeholder, bool? isFile, BoxFit? boxFit}) {
    return SizedBox(
      width: width,
      height:  height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: isFile != null && isFile ? Image.file(
          File(path),
          width: width,
          height:  height,
          fit: boxFit ?? BoxFit.cover,
          errorBuilder: (context, exception, stackTrace) {
            return Image.asset(placeholder ?? Assets.images.imgPlaceholder.path, fit: BoxFit.cover,);
          },
        ) : Image.asset(
          path,
          width: width,
          height:  height,
          fit: boxFit ?? BoxFit.cover,
          errorBuilder: (context, exception, stackTrace) {
            return Image.asset(placeholder ?? Assets.images.imgPlaceholder.path, fit: BoxFit.cover,);
          },
        ),
      ),
    );
  }
}

String removeHtml(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body?.text).documentElement!.text;

  return parsedString;
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

border(Color borderColor, {double? radius}){
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.0)),
      borderSide: BorderSide(
        color: borderColor,
      ));
}

String getErrorMessage(var resp){
  String combinedMessage = "";

  if(resp.data['errors'] != null){
    resp.data["errors"].forEach((key, messages) {
      for (var message in messages) {
        combinedMessage = "$combinedMessage- $message\n";
      }
    });
  }else if(resp.data['error'] != null){
    combinedMessage = resp.data['error'];
  }else if(resp.data['message'] != null){
    combinedMessage = resp.data['message'];
  }

  return combinedMessage;
}

showDialogError({required String msg, required Function onPosClick}){
  showConfirmDialog(Get.context!, content: msg, btn1: Translator.close.tr, btn3: Translator.tryAgain.tr, onClickBtn1: (){

  }, onClickBtn3: (){
    onPosClick();
  });
}

dynamic goToPageWithResult(Widget page) async {
  final result = await Navigator.push(
    Get.context!,
    MaterialPageRoute(builder: (context) => page),
  );
  return result;
}

printLog({String? msg}){
  if(kDebugMode){
    print("$msg");
  }
}

Future<Address> getAddress(Coordinates coordinates) async {
  // GeoCode geoCode = GeoCode();

  try {
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    // Address alamat = await geoCode.reverseGeocoding(latitude: coordinates.latitude!, longitude: coordinates.longitude!);

    printLog(msg: "alamat => ${first.toMap()}");
    return first;
  } catch (e) {
    print(e);
  }
  return Address();
}

Future<File> cropImage({required String path}) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: Translator.appName.tr,
            toolbarColor: AppColor.colorPrimary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
      ],
  );

  return File(croppedFile!.path);
}

checkLogin(resp){
  if (resp.statusCode == 401 || resp.statusCode == 403) {
    var controller = ProfileController();
    controller.logout();
    return;
  }
}

Future<File?> compressFile({required File file, required String targetPath, int? quality}) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: (quality != null) ? quality : 70,
  );

  print(file.lengthSync());
  print(result?.lengthSync());

  return result;
}
