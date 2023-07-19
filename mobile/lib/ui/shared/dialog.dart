import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';

showNormalDialog({String? title, String? content, String? btnYes, String? btnNo, Function? onClickYes, Function? onClickNo}){
  return showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {

        return AlertDialog(
            title: new Text("$title"),
            content: new Text("$content"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("$btnYes"),
                onPressed: () {
                  Get.back();
                  onClickYes!();
                },
              ),
              new FlatButton(
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

showConfirmDialog(BuildContext context, {String? content, String? assets, String? btn1, String? btn2, String? btn3, Function? onClickBtn1, Function? onClickBtn2, Function? onClickBtn3}){
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
                      SvgPicture.asset(assets != null ? assets : "assets/icons/ic_alert.svg"),
                      hSpace(15),
                      Text("$content", style: regularTextFont.copyWith(fontSize: fontSize(12)), textAlign: TextAlign.center,),
                      hSpace(25),
                      btn1 != null ? Button(title : "$btn1", color : grey, enable : true,  onClick: (){
                        Get.back();
                        onClickBtn1!();
                      }, fontColor: Colors.black, fontSize: fontSize(12)) : Container(),
                      btn2 != null ? Container(
                        child: Button(title : "$btn2", color : grey, enable :true,  onClick: (){
                          Get.back();
                          onClickBtn2!();
                        }, fontColor: Colors.black, fontSize: fontSize(12)),
                        margin: EdgeInsets.only(top: hValue(10)),
                      ) : Container(),
                      btn3 != null ? Container(
                        child: Button(title : "$btn3", color : colorAccentDark, enable : true, onClick: (){
                          Get.back();
                          onClickBtn3!();
                        }, fontColor: Colors.white, fontSize: fontSize(12)),
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

showShootOffDistanceDialog(BuildContext context, {String? firstMemberName, String? secondMemberName, String? distance1, String? distance2, Function? onClick}){
  print("shoot off dialog distance");
  var member1Distance = TextEditingController();
  var member2Distance = TextEditingController();
  var list = <String>[];

  if(distance1 != null && distance2 != null){
    member1Distance.text = distance1;
    member2Distance.text = distance2;
  }

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            child: SvgPicture.asset("assets/icons/ic_close_border_circle.svg"),
                            onTap: (){
                              Get.back();
                            },
                          ),
                        ),
                      ),
                      hSpace(15),
                      Text("Point Shoot Terakhir Sama!", style: boldTextFont.copyWith(fontSize: fontSize(18), color: Color(0xFF181C1A)), textAlign: TextAlign.start,),
                      hSpace(5),
                      Text("Silakan input jarak antara shoot dan X untuk menentukan pemenang", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Color(0xFF8C8E8D)), textAlign: TextAlign.start,),
                      hSpace(15),
                      Text("$firstMemberName", style: boldTextFont.copyWith(fontSize: fontSize(14), color: Color(0xFF757575)), textAlign: TextAlign.start,),
                      hSpace(10),
                      EditText(
                        controller: member1Distance,
                        hintText: "Masukkan Jarak (mm)",
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                      hSpace(15),
                      Text("$secondMemberName", style: boldTextFont.copyWith(fontSize: fontSize(14), color: Color(0xFF757575)), textAlign: TextAlign.start,),
                      hSpace(10),
                      EditText(
                        controller: member2Distance,
                        hintText: "Masukkan Jarak (mm)",
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                      ),
                      hSpace(15),
                      Button(title : "Simpan", color : colorAccent, enable : true,  onClick: (){
                        if(member1Distance.text.isEmpty || member2Distance.text.isEmpty){
                          errorToast(msg: "Harap isi semua isian");
                          return;
                        }

                        list.add(member1Distance.text.toString());
                        list.add(member2Distance.text.toString());
                        onClick!(list);
                        Get.back();
                      })
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      });
}