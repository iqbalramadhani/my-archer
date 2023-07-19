import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';

class ItemOption extends StatelessWidget {
  final String data;
  final Function onClick;
  const ItemOption({Key? key, required this.data, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: hValue(10)),
      width: Get.width,
      padding: EdgeInsets.all(wValue(15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.gray50,
      ),
      child: InkWell(
        child: Text(
          data,
          style: boldTextFont.copyWith(fontSize: fontSize(13)),
        ),
        onTap: (){
          onClick();
        },
      ),
    );
  }
}
