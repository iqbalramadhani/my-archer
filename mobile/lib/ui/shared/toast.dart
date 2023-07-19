
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';

errorToast({String? msg}){
  Get.snackbar("Oops", msg!, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.all(wValue(15)), backgroundColor: Colors.red, colorText: Colors.white);
}

successToast({String? msg}){
  Get.snackbar("Oops", msg!, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.all(wValue(15)), backgroundColor: Colors.green, colorText: Colors.white);
}

generalToast({String? msg}){
  Get.snackbar("Oops", msg!, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.all(wValue(15)), backgroundColor: colorPrimary, colorText: Colors.white);
}