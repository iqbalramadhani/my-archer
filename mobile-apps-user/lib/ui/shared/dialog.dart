import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/button.dart';

showNormalDialog({String? title, String? content, String? btnYes, String? btnNo, Function? onClickYes, Function? onClickNo}){
  return showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {

        return AlertDialog(
            title: new Text("$title"),
            content: new Text("$content"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: new Text("$btnYes"),
                onPressed: () {
                  Get.back();
                  onClickYes!();
                },
              ),
              FlatButton(
                child: new Text("$btnNo"),
                onPressed: () {
                  Get.back();
                  onClickNo!();
                },
              )
            ]
        );
      }
  );
}

showConfirmDialog(BuildContext context, {String? content, String? assets, String? typeAsset, bool? showIcon, String? btn1, String? btn2, String? btn3, Function? onClickBtn1, Function? onClickBtn2, Function? onClickBtn3}){
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(wValue(15))),
          child: Wrap(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(wValue(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if(showIcon != null && typeAsset == "svg") SvgPicture.asset(assets != null ? assets : "assets/icons/ic_alert.svg"),
                      if(showIcon != null && typeAsset != "svg") Image.asset(assets != null ? assets : "assets/img/img_recheck.png"),
                      hSpace(15),
                      Text("$content", style: regularTextFont.copyWith(fontSize: fontSize(12)), textAlign: TextAlign.center,),
                      hSpace(15),
                      btn1 != null ? Button("$btn1", grey, true, (){
                        Get.back();
                        onClickBtn1!();
                      }, fontColor: colorAccent, textSize: fontSize(12)) : Container(),
                      btn2 != null ? Container(
                        child: Button("$btn2", grey, true, (){
                          Get.back();
                          onClickBtn2!();
                        }, fontColor: colorAccent, textSize: fontSize(12)),
                        margin: EdgeInsets.only(top: hValue(10)),
                      ) : Container(),
                      btn3 != null ? Container(
                        child: Button("$btn3", colorAccentDark, true, (){
                          Get.back();
                          onClickBtn3!();
                        }, fontColor: Colors.white, textSize: fontSize(12)),
                        margin: EdgeInsets.only(top: hValue(10)),
                      ) : Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      });
}

showDialogJoinClub(BuildContext context, {Function? onJoinClick}){
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(wValue(15))),
          child: Wrap(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(wValue(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Align(
                          child: SvgPicture.asset("assets/icons/ic_close_circle_border.svg", width: wValue(17),),
                          alignment: Alignment.centerRight,
                        ),
                        onTap: (){
                          Get.back();
                        },
                      ),
                      SvgPicture.asset("assets/icons/ic_club_circle.svg", width: wValue(41),),
                      hSpace(15),
                      Text("Gabung Klub", style: boldTextFont.copyWith(fontSize: fontSize(16), color: colorPrimary), textAlign: TextAlign.center,),
                      hSpace(10),
                      Text("Apakah Anda yakin akan bergabung dengan Klub Fast Archery?", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Color(0xFF474747)), textAlign: TextAlign.center,),
                      hSpace(15),
                      Container(
                        child: Button("Gabung Sekarang", colorAccentDark, true, (){
                          Get.back();
                          onJoinClick!();
                        }, fontColor: Colors.white, textSize: fontSize(12)),
                        margin: EdgeInsets.only(top: hValue(10)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      });
}