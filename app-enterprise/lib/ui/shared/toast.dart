import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:oktoast/oktoast.dart';

class Toast{
  errorToast({String? msg, ToastPosition? position}) {
    Widget widget = Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.only(left: wValue(15), right: wValue(15), top: wValue(10), bottom: wValue(10)),
        margin: EdgeInsets.only(left: wValue(25), right: wValue(25)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.red,
        ),
        child: Row(
          children: [
            // SvgPicture.asset("assets/icons/ic_close_circle.svg"),
            // wSpace(10),
            Expanded(flex: 1,child: Text(
              "$msg",
              style: regularTextFont.copyWith(
                  fontSize: fontSize(12), color: Colors.white),
            ),)
          ],
        ),
      ),
    );

    showToastWidget(
      widget,
      duration: const Duration(seconds: 3),
      position: position ?? ToastPosition.bottom,
      onDismiss: () {
        print("the toast dismiss"); // the method will be called on toast dismiss.
      },
    );
  }

  successToast({String? msg, ToastPosition? position}) {
    Widget widget = Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.only(left: wValue(15), right: wValue(15), top: wValue(10), bottom: wValue(10)),
        margin: EdgeInsets.only(left: wValue(25), right: wValue(25)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.green,
        ),
        child: Row(
          children: [
            // Icon(Icons.check_circle, color: Colors.white),
            // wSpace(10),
            Expanded(
                child: Text(
                  "$msg",
                  style: regularTextFont.copyWith(
                      fontSize: fontSize(12), color: Colors.white),
                ))
          ],
        ),
      ),
    );

    ToastFuture toastFuture = showToastWidget(
      widget,
      duration: const Duration(seconds: 3),
      position: position ?? ToastPosition.bottom,
      onDismiss: () {
        print("the toast dismiss"); // the method will be called on toast dismiss.
      },
    );
  }

  generalToast({String? msg, ToastPosition? position}) {
    Widget widget = Material(
      type: MaterialType.transparency,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.only(left: wValue(15), right: wValue(15), top: wValue(10), bottom: wValue(10)),
        margin: EdgeInsets.only(left: wValue(25), right: wValue(25)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF1F1F1F),
        ),
        child: Text(
          "$msg",
          style: regularTextFont.copyWith(
              fontSize: fontSize(12), color: Colors.white),
        ),
      ),
    );

    showToastWidget(
      widget,
      duration: const Duration(seconds: 3),
      position: position ?? ToastPosition.bottom,
      onDismiss: () {
        print("the toast dismiss"); // the method will be called on toast dismiss.
      },
    );
    // Get.snackbar("Success", msg!, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.all(wValue(15)), backgroundColor: Colors.green, colorText: Colors.white);
  }
}