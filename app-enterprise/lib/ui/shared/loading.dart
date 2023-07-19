import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';

loading({Indicator? typeIndicator, Color? color, double? width}) {
  return Center(
    child: SizedBox(
      width: width ?? wValue(40),
      child: LoadingIndicator(
          indicatorType:
              (typeIndicator == null) ? Indicator.ballPulseRise : typeIndicator,
          colors: [(color == null) ? AppColor.colorPrimary : color]),
    ),
  );
}

loadingDialog({Indicator? typeIndicator, Color? color, double? width}) {
  Get.dialog(
      Center(
          child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
            margin: EdgeInsets.only(
                left: wValue(20),
                right: wValue(20),
                top: wValue(10),
                bottom: wValue(20)),
            width: width ?? wValue(40),
            child: LoadingIndicator(
                indicatorType: (typeIndicator == null)
                    ? Indicator.ballPulseRise
                    : typeIndicator,
                colors: [(color == null) ? AppColor.colorPrimary : color])),
      )),
      barrierDismissible: false);
}
