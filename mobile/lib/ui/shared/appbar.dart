import 'package:flutter/material.dart';
import 'package:my_archery/utils/screen_util.dart';
import 'package:my_archery/utils/theme.dart';

appBar(String title, Function onClick, {Widget? rightIcon, Color? iconColor, double? fontSize, Color? bgColor, Color? textColor, bool? isShadow}){
  return AppBar(
    toolbarHeight: ScreenUtil().setHeight(45),
    backgroundColor: bgColor == null ? Colors.white : bgColor,
    elevation: isShadow != null ? 1 : 0,
    automaticallyImplyLeading: false,
    title: Stack(
      children: <Widget>[
        (onClick == null) ? Container() : Container(
          height: ScreenUtil().setHeight(40),
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                onClick();
              },
              child: Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                child: Icon(Icons.arrow_back_outlined, color: iconColor != null ? iconColor : Colors.black,),
              ),
            ),
          ),
        ),
        Container(
          height: ScreenUtil().setHeight(40),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: boldTextFont.copyWith(
                  color: textColor == null ? Colors.black : textColor,
                  fontSize: fontSize == null ? ScreenUtil().setSp(14) : fontSize),
            ),
          ),
        ),
        Positioned(child: Container(
          height: ScreenUtil().setHeight(40),
          child: (rightIcon == null) ? Container() : rightIcon,
        ), right: 0,)
      ],
    ),
  );
}