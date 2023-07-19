import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';

Button(
    {required String title,
    required Color color,
    required bool enable,
    required Function onClick,
    double? textSize,
    Color? borderColor,
    double? borderWidth,
    double? width,
    Color? fontColor,
    bool? isLoading,
    Widget? leftView,
    Widget? rightView,
    double? height}) {
  return MaterialButton(
      color: color,
      elevation: 0,
      splashColor: enable ? Colors.white : color,
      height: height ?? hValue(36),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side:
              BorderSide(color: borderColor ?? color, width: borderWidth ?? 1)),
      child: isLoading != null
          ? SizedBox(
              width: wValue(40),
              child: const LoadingIndicator(
                  indicatorType: Indicator.ballPulse, colors: [Colors.white]),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (leftView != null)
                    ? Container(
                        margin: EdgeInsets.only(right: wValue(10)),
                        child: leftView,
                      )
                    : Container(),
                Text(
                  title,
                  style: textSmBold.copyWith(color: fontColor ?? Colors.white, fontSize: textSize ?? fontSize(12)),
                ),
                (rightView != null)
                    ? Container(
                        margin: EdgeInsets.only(right: wValue(10)),
                        child: rightView,
                      )
                    : Container(),
              ],
            ),
      onPressed: () {
        if (enable) {
          onClick();
        }
      });
}
