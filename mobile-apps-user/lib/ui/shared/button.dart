
import 'package:flutter/material.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/utils/theme.dart';

Button(String title, Color color, bool enable, Function onClick,  {double? textSize, Color? borderColor, double? borderWidth, double? width, Color? fontColor, bool? isLoading, Widget? leftView, Widget? rightView,  double? height}){
  return MaterialButton(
      color: color,
      elevation: 0,
      splashColor: enable ? Colors.white : color,
      height: height ?? hValue(40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor ?? color, width: borderWidth ?? 1)
      ),
      child: isLoading != null ? Container(child: LoadingIndicator(indicatorType: Indicator.ballPulse, color: Colors.white), width: wValue(40),) : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (leftView != null) ? Container(child: leftView, margin: EdgeInsets.only(right: wValue(10)),) : Container(),
          Text(
            title,
            style: boldTextFont.copyWith(fontSize: textSize ?? fontSize(15), color: fontColor != null ? fontColor : Colors.white),
          ),
          (rightView != null) ? Container(child: rightView, margin: EdgeInsets.only(right: wValue(10)),) : Container(),
        ],
      ),
      onPressed: () {
        if(enable){
          onClick();
        }
      });
}