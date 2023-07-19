import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/spacing.dart';

itemInfoPeserta(String title, String value){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("$title", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
      Text("$value", style: boldTextFont.copyWith(fontSize: fontSize(12)),)
    ],
  );
}

itemMenuTop(String icon, String title, bool isSelected, Function onClick){
  return InkWell(
    child: Card(
      color: isSelected ? colorPrimary : Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(wValue(8))),
      child: Container(
        child: Column(
          children: [
            SvgPicture.asset("assets/icons/$icon", width: wValue(13), color: isSelected ? Colors.white : colorPrimary,),
            hSpace(5),
            Text("$title", style: boldTextFont.copyWith(fontSize: fontSize(8), color: isSelected ? Colors.white : colorPrimary),)
          ],
        ),
        margin: EdgeInsets.all(wValue(10)),
      ),
    ),
    onTap: (){
      onClick();
    },
  );
}
itemInfoEvent(String title, String value){
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title", style: regularTextFont.copyWith(fontSize: fontSize(14), color: gray500),),
        hSpace(5),
        Text("$value", style: boldTextFont.copyWith(fontSize: fontSize(14)),),
        hSpace(10),
        Divider(
          thickness: 1,
        )
      ],
    ),
    padding: EdgeInsets.all(wValue(10)),
  );
}