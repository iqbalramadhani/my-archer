import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';

loading({Indicator? typeIndicator, Color? color, double? width}){
  return Center(
    child: Container(child: LoadingIndicator(indicatorType: (typeIndicator == null) ? Indicator.ballPulseRise : typeIndicator, colors:[(color == null) ? colorPrimary : color]), width: width == null  ? wValue(40) : width,) ,
  );
}

loadingDialog({Indicator? typeIndicator, Color? color, double? width}){
  Get.dialog(Center(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        margin: EdgeInsets.only(left: wValue(20), right: wValue(20), top: wValue(10), bottom: wValue(20)),
        child: LoadingIndicator(indicatorType: (typeIndicator == null) ? Indicator.ballPulseRise : typeIndicator, colors : [(color == null) ? colorPrimary : color]), width: width == null  ? wValue(40) : width,),
      )
  ), barrierDismissible: false);
}