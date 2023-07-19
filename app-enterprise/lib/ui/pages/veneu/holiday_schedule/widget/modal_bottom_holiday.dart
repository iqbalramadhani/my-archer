import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/core/models/objects/schedule_holiday_model.dart';
import 'package:myarcher_enterprise/core/models/objects/time_operational_model.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/holiday_schedule/holiday_schedule_controller.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/operational_schedule/operational_schedule_controller.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/operational_schedule/widget/item_jam.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/ui/shared/checkbox.dart';
import 'package:myarcher_enterprise/ui/shared/dialog.dart';
import 'package:myarcher_enterprise/ui/shared/toast.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/date_helper.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

modalBottomSetHolidaySchedule({required int placeId, ScheduleHolidayModel? currentData, required Function onSave, required Function onDelete}) {

  var controller = HolidayScheduleController();

  RxString startTimeStr = "".obs;
  RxString endTimeStr = "".obs;

  Rx<DateTime> startTime = DateTime.now().obs;
  Rx<DateTime> endTime = DateTime.now().obs;

  if(currentData != null){

    startTimeStr.value = currentData.startAt!.split(" ").first;
    endTimeStr.value = currentData.endAt!.split(" ").first;

    if(currentData.startAt != null && currentData.startAt!.isNotEmpty) {
      startTime.value = DateHelper().formattingDateIntoDateTime(currentData.startAt!, "yyyy-MM-dd HH:mm:ss");
      endTime.value = DateHelper().formattingDateIntoDateTime(currentData.endAt!, "yyyy-MM-dd HH:mm:ss");
    }
  }

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(wValue(25)),
          margin: EdgeInsets.only(top: hValue(100)),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currentData == null ? Translator.addSchedule.tr : Translator.updateSchedule.tr, style: textSmBold),
                  hSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Translator.start.tr, style: boldTextFont.copyWith(fontSize: fontSize(14)),),
                            hSpace(5),
                            Obx(()=> ItemJam(
                              holiday: false,
                              time: startTimeStr.value,
                              hint: Translator.formatDate.tr,
                              onClick: () {
                                showDateDialog(initialDate: startTime.value, onSelected: (value){
                                  startTime.value = value;
                                  startTimeStr.value = DateHelper().converTimestampIntoFormattedDate(timestamp: startTime.value.millisecondsSinceEpoch);

                                  endTime.value = startTime.value.add(const Duration(days: 30));
                                  endTimeStr.value = "";
                                });
                              },
                            ))
                          ],
                        ),
                      ),
                      wSpace(17),
                      Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Translator.end.tr, style: boldTextFont.copyWith(fontSize: fontSize(14)),),
                              hSpace(5),
                              Obx(()=> ItemJam(
                                holiday: false,
                                time: endTimeStr.value,
                                onClick: () {
                                  if(startTimeStr.value.isEmpty){
                                    Toast().errorToast(msg: Translator.chooseStartDateFirst.tr);
                                    return;
                                  }

                                  showDateDialog(initialDate: endTime.value, onSelected: (value){
                                    if(value.isBefore(startTime.value)){
                                      Toast().errorToast(msg: Translator.endDateCantBeforeStartDate.tr);
                                      return;
                                    }

                                    endTime.value = value;
                                    endTimeStr.value = DateHelper().converTimestampIntoFormattedDate(timestamp: endTime.value.millisecondsSinceEpoch);
                                  });
                                },
                                hint: Translator.formatDate.tr,
                              )),
                            ],
                          )
                      ),
                    ],
                  ),
                  hSpace(10),
                  if(currentData != null) Button(title: Translator.deleteSchedule.tr, color: Colors.white, borderColor: AppColor.colorPrimary, fontColor: AppColor.colorPrimary, enable: true, onClick: (){
                    Get.back();
                   onDelete();
                  }),
                  hSpace(5),
                  Button(title: Translator.save.tr, color: AppColor.colorPrimary, enable: true, onClick: (){
                    if(startTimeStr.value.isEmpty || endTimeStr.value.isEmpty){
                      Toast().errorToast(msg: Translator.chooseStartDateAndEndDateFirst.tr);
                      return;
                    }else{
                      if(endTime.value.isBefore(startTime.value)){
                        Toast().errorToast(msg: Translator.endDateCantBeforeStartDate.tr);
                        return;
                      }
                    }

                    if(currentData == null) {
                      controller.apiAddScheduleHoliday(id: placeId,
                          startAt: DateHelper()
                              .converTimestampIntoFormattedDate(
                              timestamp: startTime.value.millisecondsSinceEpoch,
                              outFormat: "yyyy-MM-dd"),
                          endAt: DateHelper().converTimestampIntoFormattedDate(
                              timestamp: endTime.value.millisecondsSinceEpoch,
                              outFormat: "yyyy-MM-dd"),
                          onFinish: () {
                            Get.back();
                            onSave();
                          });
                    }else{
                      controller.apiUpdateScheduleHoliday(id: currentData.id!,
                          startAt: DateHelper()
                              .converTimestampIntoFormattedDate(
                              timestamp: startTime.value.millisecondsSinceEpoch,
                              outFormat: "yyyy-MM-dd"),
                          endAt: DateHelper().converTimestampIntoFormattedDate(
                              timestamp: endTime.value.millisecondsSinceEpoch,
                              outFormat: "yyyy-MM-dd"),
                          onFinish: () {
                            Get.back();
                            onSave();
                          });
                    }
                  }),
                ],
              )
            ],
          ),
        );
      });
}