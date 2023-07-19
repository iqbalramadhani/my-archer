import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/ui/shared/edittext.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

showConfirmDialog(BuildContext context,
    {String? content,
    bool? dismissable,
    String? assets,
    String? typeAsset,
    bool? showIcon,
    String? btn1,
    String? btn2,
    String? btn3,
      bool? showCloseTopCorner,
    Function? onClickBtn1,
    Function? onClickBtn2,
    Function? onClickBtn3}) {
  return showDialog(
      context: context,
      barrierDismissible: dismissable ?? true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(wValue(15))),
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.all(wValue(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(showCloseTopCorner != null && showCloseTopCorner) Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: SvgPicture.asset(Assets.icons.icCloseCircle, width: wValue(20),),
                        onTap: (){
                          Get.back();
                        },
                      ),
                    ),
                    if (showIcon != null && typeAsset == "svg")
                      SvgPicture.asset(assets ?? Assets.icons.icAlert),
                    if (showIcon != null && typeAsset != "svg")
                      Image.asset(assets ?? Assets.images.imgRecheck.path),
                    hSpace(15),
                    Text(
                      "$content",
                      style: regularTextFont.copyWith(fontSize: fontSize(12)),
                      textAlign: TextAlign.center,
                    ),
                    hSpace(15),
                    btn1 != null
                        ? Button(
                            title: btn1,
                            color: AppColor.gray50,
                            enable: true,
                            onClick: () {
                              Get.back();
                              onClickBtn1!();
                            },
                            fontColor: AppColor.black,
                            textSize: fontSize(12))
                        : Container(),
                    btn2 != null
                        ? Container(
                            child: Button(
                                title: btn2,
                                color: AppColor.gray50,
                                enable: true,
                                onClick: () {
                                  Get.back();
                                  onClickBtn2!();
                                },
                                fontColor: AppColor.black,
                                textSize: fontSize(12)),
                            margin: EdgeInsets.only(top: hValue(10)),
                          )
                        : Container(),
                    btn3 != null
                        ? Container(
                            child: Button(
                                title: btn3,
                                color: AppColor.colorAccent,
                                enable: true,
                                onClick: () {
                                  Get.back();
                                  onClickBtn3!();
                                },
                                fontColor: Colors.white,
                                textSize: fontSize(12)),
                            margin: EdgeInsets.only(top: hValue(10)),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        );
      });
}

showInputWordDialog(
    {String? title,
    String? currentData,
    required Function onSubmit,
    Function? onCancel,
    String? textButtonPos,
      TextInputType? textInputType,
    String? textButtonNeg}) {
  var dataC = TextEditingController();

  if (currentData != null) {
    dataC.text = currentData;
  }

  return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(wValue(15))),
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.all(wValue(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title ?? Translator.inputData.tr,
                      style: boldTextFont.copyWith(fontSize: fontSize(14)),
                      textAlign: TextAlign.center,
                    ),
                    hSpace(15),
                    EditText(
                      controller: dataC,
                      textInputType: textInputType ?? TextInputType.text,
                      textInputAction: TextInputAction.done,
                      hintText: Translator.inputData.tr,
                    ),
                    hSpace(15),
                    if (textButtonNeg != null)
                      Button(
                          title: textButtonNeg,
                          color: AppColor.gray100,
                          fontColor: AppColor.colorPrimary,
                          enable: true,
                          onClick: () {
                            Get.back();
                          }),
                    hSpace(8),
                    Button(
                        title: textButtonPos ?? Translator.submit.tr,
                        color: AppColor.colorPrimary,
                        enable: true,
                        onClick: () {
                          Get.back();
                          onSubmit(dataC.text);
                        })
                  ],
                ),
              )
            ],
          ),
        );
      });
}

showDateDialog({DateTime? minDate, DateTime? maxDate, required DateTime initialDate, required Function onSelected}) {
  // late List<DateTime> _blackoutDates;
  // bool _selectableDayPredicateDates(DateTime date) {
  //   if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
  //     return false;
  //   }
  //
  //   return true;
  // }

  // _blackoutDates = DateHelper().getHolidaysDate();


  return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(wValue(12))),
          child: Wrap(
            children: [
              SfDateRangePicker(
                monthCellStyle: DateRangePickerMonthCellStyle(blackoutDateTextStyle: boldTextFont.copyWith(color: Colors.red, decoration: TextDecoration.lineThrough)),
                monthViewSettings: DateRangePickerMonthViewSettings(showTrailingAndLeadingDates: true,
                    // blackoutDates: _blackoutDates
                ),
                showNavigationArrow: false,
                enablePastDates: false,
                showActionButtons: true,
                confirmText: Translator.confirm.tr,
                cancelText: Translator.cancel.tr,
                onCancel: (){
                  Get.back();
                },
                onSubmit: (item){
                  // print("item => ${item}");
                  onSelected(item);
                  Get.back();
                },
                initialSelectedDate: initialDate,
                initialDisplayDate: initialDate,
                minDate: minDate ?? DateTime.now(),
                maxDate: maxDate ?? DateTime.now().add(const Duration(days: 30)),
                // selectableDayPredicate: _selectableDayPredicateDates,
              )
            ],
          ),
        );
      });
}
