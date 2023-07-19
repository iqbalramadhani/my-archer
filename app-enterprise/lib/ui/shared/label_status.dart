import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class LabelStatus extends StatelessWidget {
  final int status;
  const LabelStatus({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bgColor;
    var textColor;
    var title;

    if(status == StatusVenue.draft){
      bgColor = AppColor.secondaryOrange50;
      textColor = AppColor.secondaryOrange1;
      title = Translator.draft.tr;
    }else if(status == StatusVenue.diajukan){
      bgColor = AppColor.purple100;
      textColor = AppColor.purple600;
      title = Translator.requested.tr;
    }else if(status == StatusVenue.lengkapiData){
      bgColor = AppColor.secondaryOrange1;
      textColor = AppColor.white;
      title = Translator.completeData.tr;
    }else if(status == StatusVenue.aktif){
      bgColor = AppColor.green100;
      textColor = AppColor.green400;
      title = Translator.active.tr;
    }else if(status == StatusVenue.nonaktif){
      bgColor = AppColor.gray500;
      textColor = AppColor.white;
      title = Translator.nonactive.tr;
    }else{
      bgColor = AppColor.gray100;
      textColor = AppColor.negativeRed;
      title = Translator.rejected.tr;
    }

    return Card(
      color: bgColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(wValue(10))),
      child: Container(
        padding: EdgeInsets.all(wValue(5)),
        child: Text(
          title,
          style: textXsBold.copyWith(color: textColor),
          maxLines: 2,
        ),
      ),
    );
  }
}
