import 'package:flutter/material.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';

CustomAppBar({required String title, required Function onClick, Widget? rightIcon, Color? iconColor, double? textSize, Color? bgColor, Color? textColor, bool? isShadow, double? height}){
  return PreferredSize(preferredSize: Size.fromHeight(height ?? hValue(45)), child: AppBar(
    toolbarHeight: hValue(45),
    backgroundColor: bgColor ?? AppColor.colorAccent,
    elevation: isShadow != null ? 1 : 0,
    automaticallyImplyLeading: false,
    title: Stack(
      children: <Widget>[
        if(onClick != null) Container(
          height: hValue(40),
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                onClick();
              },
              child: Container(
                padding: EdgeInsets.all(wValue(5)),
                child: Icon(Icons.arrow_back_ios, color: iconColor ?? Colors.white,),
              ),
            ),
          ),
        ),
        wSpace(15),
        Container(
          margin: EdgeInsets.only(left: wValue(35)),
          height: hValue(40),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: boldTextFont.copyWith(
                  color: textColor ?? Colors.white,
                  fontSize: textSize ?? fontSize(14)),
            ),
          ),
        ),
        Positioned(right: 0,child: SizedBox(
          height: hValue(40),
          child: rightIcon ?? Container(),
        ),)
      ],
    ),
  ));
}
