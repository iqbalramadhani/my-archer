import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/core/models/objects/time_operational_model.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/operational_schedule/operational_schedule_controller.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/operational_schedule/widget/item_jam.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/ui/shared/checkbox.dart';
import 'package:myarcher_enterprise/ui/shared/toast.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

modalBottomSetOperationalSchedule({required int placeId, required String day,
  TimeOperationalModel? currentData, required Function onSave, required Function onDelete}) {

  var controller = OperationalScheduleController();

  RxBool isHoliday = false.obs;
  RxBool isAnyBreak = false.obs;

  RxString openTimeStr = "".obs;
  RxString closeTimeStr = "".obs;

  RxString startTimeBreakStr = "".obs;
  RxString endTimeBreakStr = "".obs;

  Rx<TimeOfDay> openTime = TimeOfDay(hour: 08, minute: 00).obs;
  Rx<TimeOfDay> closeTime = TimeOfDay(hour: 17, minute: 00).obs;

  Rx<TimeOfDay> startTimeBreak = TimeOfDay(hour: 12, minute: 00).obs;
  Rx<TimeOfDay> endTimeBreak = TimeOfDay(hour: 13, minute: 00).obs;

  if(currentData != null){
    isHoliday.value = currentData.isOpen == 0;
    isAnyBreak.value = (currentData.startBreakTime != null && currentData.startBreakTime!.isNotEmpty) && (currentData.endBreakTime != null && currentData.endBreakTime!.isNotEmpty);

    if(!isHoliday.value) {
      if(currentData.openTime != null && currentData.openTime!.isNotEmpty) {
        openTime.value = TimeOfDay(
            hour: int.parse(currentData.openTime!.split(":").first),
            minute: int.parse(currentData.openTime!.split(":")[1]));

        openTimeStr.value = currentData.openTime!;
      }

      if(currentData.closedTime != null && currentData.closedTime!.isNotEmpty) {
        closeTime.value = TimeOfDay(
            hour: int.parse(currentData.closedTime!.split(":").first),
            minute: int.parse(currentData.closedTime!.split(":")[1]));
        closeTimeStr.value = currentData.closedTime!;
      }

      if(currentData.startBreakTime != null && currentData.startBreakTime!.isNotEmpty) {
        startTimeBreak.value = TimeOfDay(
            hour: int.parse(currentData.startBreakTime!.split(":").first),
            minute: int.parse(currentData.startBreakTime!.split(":")[1]));

        startTimeBreakStr.value = currentData.startBreakTime ?? "";
      }

      if(currentData.endBreakTime != null && currentData.endBreakTime!.isNotEmpty) {
        endTimeBreak.value = TimeOfDay(
            hour: int.parse(currentData.endBreakTime!.split(":").first),
            minute: int.parse(currentData.endBreakTime!.split(":")[1]));

        endTimeBreakStr.value = currentData.endBreakTime ?? "";
      }
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Translator.setTime.tr, style: textSmBold),
                      Obx(() => CheckBox(label: Translator.holiday.tr, isChecked: isHoliday.value, onChange: (){
                        isHoliday.value = !isHoliday.value;
                        if(isHoliday.value){
                          isAnyBreak.value = false;
                        }

                        openTimeStr.value = "";
                        closeTimeStr.value = "";

                        startTimeBreakStr.value = "";
                        endTimeBreakStr.value = "";
                      }))
                    ],
                  ),
                  hSpace(12),
                  Row(
                    children: [
                      Obx(()=> Expanded(flex: 1,child: ItemJam(holiday: isHoliday.value,
                        time: openTimeStr.value, hint : Translator.open.tr, onClick: () async {
                        if(!isHoliday.value){
                          final timeOfDay = await showTimePicker(
                              context: context,
                              initialTime: openTime.value,
                              initialEntryMode: TimePickerEntryMode.dial,
                              confirmText: Translator.confirm.tr,
                              cancelText: Translator.cancel.tr,
                              helpText: Translator.open.tr
                          );

                          if(timeOfDay != null)
                          {
                            openTime.value = timeOfDay;
                            openTimeStr.value = "${timeOfDay.hour.toString().length == 1 ? "0${timeOfDay.hour}" : timeOfDay.hour}:${timeOfDay.minute.toString().length <= 1 ? "0${timeOfDay.minute}" : timeOfDay.minute}";
                          }
                        }
                      }),)),
                      wSpace(17),
                      Obx(()=> Expanded(flex: 1,child: ItemJam(holiday: isHoliday.value, hint: Translator.close.tr, time: closeTimeStr.value, onClick: () async {
                        if(!isHoliday.value){
    if(openTimeStr.value.isEmpty){
      Toast().errorToast(msg: Translator.chooseOpenTimeFirst.tr);
      return;
    }
    final timeOfDay = await showTimePicker(
        context: context,
        initialTime: closeTime.value,
        initialEntryMode: TimePickerEntryMode.dial,
        confirmText: Translator.confirm.tr,
        cancelText: Translator.cancel.tr,
        helpText: Translator.close.tr
    );

    if(timeOfDay != null)
    {
      if(timeOfDay.hour < openTime.value.hour){
        Toast().errorToast(msg: Translator.closeCantBeforeOpen.tr);
        return;
      }
      closeTime.value = timeOfDay;
      closeTimeStr.value = "${timeOfDay.hour.toString().length == 1 ? "0${timeOfDay.hour}" : timeOfDay.hour}:${timeOfDay.minute.toString().length <= 1 ? "0${timeOfDay.minute}" : timeOfDay.minute}";
    }
  }
                      }),))
                    ],
                  ),
                  hSpace(15),

                  ///break
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Translator.breakTime.tr, style: textSmRegular),
                      Obx(()=> Switch(
                        onChanged: (_){
                          if(!isHoliday.value) {
                            isAnyBreak.value = !isAnyBreak.value;

                            startTimeBreakStr.value = "";
                            endTimeBreakStr.value = "";
                          }
                        },
                        value: isAnyBreak.value,
                        activeColor: AppColor.colorPrimary,
                        activeTrackColor: AppColor.colorPrimaryBlue,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: AppColor.grey,
                      )),
                    ],
                  ),
                  hSpace(12),
                  Obx(()=> Row(
                    children: [
                      Expanded(flex: 1,child: ItemJam(holiday: !isAnyBreak.value, time: startTimeBreakStr.value, hint : Translator.start.tr, onClick: () async {
                        if(!isHoliday.value || !isAnyBreak.value) {
                          final timeOfDay = await showTimePicker(
                              context: context,
                              initialTime: startTimeBreak.value,
                              initialEntryMode: TimePickerEntryMode.dial,
                              confirmText: Translator.confirm.tr,
                              cancelText: Translator.cancel.tr,
                              helpText: Translator.close.tr
                          );

                          if(timeOfDay != null)
                          {
                            startTimeBreak.value = timeOfDay;
                            startTimeBreakStr.value = "${timeOfDay.hour.toString().length <= 1 ? "0${timeOfDay.hour}" : timeOfDay.hour}:${timeOfDay.minute.toString().length <= 1 ? "0${timeOfDay.minute}" : timeOfDay.minute}";
                          }
                        }
                      })),
                      wSpace(17),
                      Expanded(flex: 1,child: ItemJam(holiday: !isAnyBreak.value, time: endTimeBreakStr.value, hint : Translator.end.tr, onClick: () async {
                        if(!isHoliday.value || !isAnyBreak.value) {
                          if(startTimeBreakStr.value.isEmpty){
                            Toast().errorToast(msg: Translator.chooseStartTimeFirst.tr);
                            return;
                          }
                          final timeOfDay = await showTimePicker(
                              context: context,
                              initialTime: endTimeBreak.value,
                              initialEntryMode: TimePickerEntryMode.dial,
                              confirmText: Translator.confirm.tr,
                              cancelText: Translator.cancel.tr,
                              helpText: Translator.close.tr
                          );

                          if(timeOfDay != null)
                          {
                            if(timeOfDay.hour < startTimeBreak.value.hour){
                              Toast().errorToast(msg: Translator.endCantBeforeStart.tr);
                              return;
                            }
                            endTimeBreak.value = timeOfDay;
                            endTimeBreakStr.value = "${timeOfDay.hour.toString().length <= 1 ? "0${timeOfDay.hour}" : timeOfDay.hour}:${timeOfDay.minute.toString().length <= 1 ? "0${timeOfDay.minute}" : timeOfDay.minute}";
                          }
                        }
                      }))
                    ],
                  )),
                  if(currentData != null) Container(
                    child: Button(title: Translator.deleteTime.tr, color: Colors.white, borderColor: AppColor.colorPrimary, enable: true, fontColor: AppColor.colorPrimary, onClick: (){
                      Get.back();
                      controller.apiUpdateScheduleOperational(id: currentData.id, isDelete: true, day: day, isOpen: !isHoliday.value, onFinish: (){
                        onDelete();
                      });
                    }),
                    margin: EdgeInsets.only(top: hValue(10)),
                  ),
                  hSpace(10),
                  Button(title: Translator.save.tr, color: AppColor.colorPrimary, enable: true, onClick: (){
                    if(!isHoliday.value){
                      if(openTimeStr.value.isEmpty || closeTimeStr.value.isEmpty){
                        Toast().errorToast(msg: Translator.chooseOpenAndCloseTimeFirst.tr);
                        return;
                      }else{
                        if(closeTime.value.hour <= openTime.value.hour){
                          Toast().errorToast(msg: Translator.closeCantBeforeOpen.tr);
                          return;
                        }
                      }

                      if(isAnyBreak.value){
                        if(startTimeBreakStr.value.isEmpty || endTimeBreakStr.value.isEmpty){
                          Toast().errorToast(msg: Translator.chooseStartAndEndTimeFirst.tr);
                          return;
                        }else{
                          if(endTimeBreak.value.hour <= startTimeBreak.value.hour){
                            Toast().errorToast(msg: Translator.endCantBeforeStart.tr);
                            return;
                          }
                        }
                      }
                    }

                    Get.back();
                    if(currentData != null){
                      controller.apiUpdateScheduleOperational(id: currentData.id, day: day, isOpen: !isHoliday.value, openTime: openTimeStr.value, closeTime: closeTimeStr.value, breakTime: startTimeBreakStr.value, endBreakTime: endTimeBreakStr.value, onFinish: (){
                        onSave();
                      });
                    }else{
                      controller.apiAddScheduleOperational(id: placeId, day: day, isOpen: !isHoliday.value, openTime: openTimeStr.value, closeTime: closeTimeStr.value, breakTime: startTimeBreakStr.value, endBreakTime: endTimeBreakStr.value, onFinish: (){
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