import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class ItemSchedule extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final bool isHeader;
  const ItemSchedule({Key? key, required this.text1, required this.isHeader, required this.text2, required this.text3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: hValue(10)),
      child: Row(
        children: [
          Expanded(flex : 1,child: Text(text1, style: isHeader ? textSmBold : textSmRegular,)),
          Expanded(flex : 2,child: Text(text2, style: isHeader ? textSmBold : textSmRegular.copyWith(color: text2 == Translator.holiday.tr ? Colors.red : text2 == Translator.notSet.tr ? Colors.black : AppColor.colorPrimary),)),
          Expanded(flex : 2,child: Text(text3, style: isHeader ? textSmBold : textSmRegular.copyWith(color: text3 == Translator.holiday.tr ? Colors.red : text3 == Translator.notSet.tr ? Colors.black : AppColor.colorPrimary),)),
        ],
      ),
    );
  }
}
