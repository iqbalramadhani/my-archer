import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/core/models/objects/schedule_holiday_model.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/holiday_schedule/holiday_schedule_controller.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/holiday_schedule/widget/item_schedule_holiday.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/holiday_schedule/widget/modal_bottom_holiday.dart';
import 'package:myarcher_enterprise/ui/shared/appbar.dart';
import 'package:myarcher_enterprise/ui/shared/base_container.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/ui/shared/dialog.dart';
import 'package:myarcher_enterprise/ui/shared/shimmer_loading.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HolidayScheduleScreen extends StatefulWidget {
  final int id;
  const HolidayScheduleScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<HolidayScheduleScreen> createState() => _HolidayScheduleScreenState();
}

class _HolidayScheduleScreenState extends State<HolidayScheduleScreen> {

  var controller = HolidayScheduleController();

  @override
  void initState() {
    controller.apiListScheduleHoliday(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(child: WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                CustomAppBar(title: Translator.operationalSchedule.tr, onClick: (){
                  onWillPop();
                }),
                Expanded(flex: 1,child: Padding(
                  padding: EdgeInsets.all(wValue(15)),
                  child: Obx(()=> controller.isLoading.value ? showShimmerList() : Column(
                    children: [
                      Text(Translator.descHolidaySchedule.tr, style: textSmRegular.copyWith(color: AppColor.gray400)),
                      controller.schedules.isEmpty ? Container(
                        margin: EdgeInsets.all(wValue(15)),
                        child: Text(Translator.noData.tr, style: textLgBold,),
                      ) : SingleChildScrollView(
                        child: Column(
                          children: [
                            for(var item in controller.schedules) ItemScheduleHoliday(placeId: widget.id, onReload: (){
                              controller.apiListScheduleHoliday(id: widget.id, isClear: true);
                            }, startDate: item.startAt ?? "", endDate: item.endAt ?? "", onDelete: (){
                              showConfirmDialog(Get.context!, content: Translator.msgConfirmDeleteScheduleHoliday.tr, showIcon: true, assets: Assets.icons.icAlert, typeAsset: "svg", btn1: Translator.cancel.tr, btn3: Translator.delete.tr, onClickBtn1: (){

                              }, onClickBtn3: (){
                                controller.apiDeleteScheduleHoliday(
                                    id: item.id!, placeId: widget.id);
                              });
                            }, onClick: (){
                              modalBottomSetHolidaySchedule(placeId: widget.id, currentData: item, onDelete: (){
                                showConfirmDialog(Get.context!, content: Translator.msgConfirmDeleteScheduleHoliday.tr, showIcon: true, assets: Assets.icons.icAlert, typeAsset: "svg", btn1: Translator.cancel.tr, btn3: Translator.delete.tr, onClickBtn1: (){

                                }, onClickBtn3: (){
                                  controller.apiDeleteScheduleHoliday(id: item.id!, placeId: widget.id);
                                });
                              }, onSave: (){
                                controller.apiListScheduleHoliday(id: widget.id, isClear: true);
                              });
                            },)
                          ],
                        ),
                      ),
                    ],
                  )),
                ),)
              ],
            ),
            _viewButtonsCompleteData()
          ],
        ),
      ),
    ));
  }

  _viewButtonsCompleteData(){
    return Positioned(
      bottom: 0,
      child:  Column(
        children: [
          SimpleShadow(
            sigma: 6,
            opacity: 0.3,
            child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  color: AppColor.white,
                ),
                padding: EdgeInsets.all(wValue(15)),
                child: Column(
                  children: [
                    Button(title: Translator.addSchedule.tr, color: AppColor.colorPrimary, borderColor: AppColor.colorPrimary, fontColor: AppColor.white, enable: true, onClick: (){
                      modalBottomSetHolidaySchedule(placeId: widget.id, currentData: null, onDelete: (){
                      }, onSave: (){
                        controller.apiListScheduleHoliday(id: widget.id, isClear: true);
                      });
                    }),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> onWillPop() async {
    Navigator.pop(context, true);
    return false;
  }
}
