import 'package:flutter/material.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/utils/theme.dart';

appBar(String title, Function onClick, {Widget? rightIcon, Color? iconColor, double? textSize, Color? bgColor, Color? textColor, bool? isShadow}){
  return AppBar(
    toolbarHeight: hValue(45),
    backgroundColor: bgColor == null ? colorAccent : bgColor,
    elevation: isShadow != null ? 1 : 0,
    automaticallyImplyLeading: false,
    title: Stack(
      children: <Widget>[
        (onClick == null) ? Container() : Container(
          height: hValue(40),
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                onClick();
              },
              child: Container(
                padding: EdgeInsets.all(wValue(5)),
                child: Icon(Icons.arrow_back_outlined, color: iconColor != null ? iconColor : Colors.white,),
              ),
            ),
          ),
        ),
        Container(
          height: hValue(40),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: boldTextFont.copyWith(
                  color: textColor == null ? Colors.white : textColor,
                  fontSize: textSize == null ? fontSize(14) : textSize),
            ),
          ),
        ),
        Positioned(child: Container(
          height: hValue(40),
          child: (rightIcon == null) ? Container() : rightIcon,
        ), right: 0,)
      ],
    ),
  );
}