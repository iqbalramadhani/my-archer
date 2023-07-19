import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';

modalBottomTwoActions({required String title, required String content, Widget? icon, required bool skipable, String? btnNeg, String? btnPos, Function? onBtnPosClick, Function? onBtnNegClick}) {
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: skipable,
      enableDrag: skipable,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return WillPopScope(child: Wrap(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(wValue(25)),
              margin: EdgeInsets.only(top: hValue(100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  hSpace(10),
                  Text(title, style: textBaseBold.copyWith(color: AppColor.colorPrimary),),
                  hSpace(20),
                  icon ?? SvgPicture.asset(Assets.images.imgCheck, width: wValue(104),),
                  hSpace(14),
                  Text(content, style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.center,),
                  hSpace(30),
                  Button(title: btnPos ?? "", color: Colors.white, enable: true, onClick: (){
                    Get.back();
                    if(onBtnPosClick != null){
                      onBtnPosClick();
                    }
                  }, fontColor: AppColor.colorPrimary, borderColor: AppColor.colorPrimary),
                  hSpace(10),
                  Button(title: btnNeg ?? "", color: AppColor.colorPrimary, enable: true, onClick: (){
                    Get.back();
                    if(onBtnNegClick != null){
                      onBtnNegClick();
                    }
                  }),
                ],
              ),
            )
          ],
        ), onWillPop: () async => skipable);
      });
}