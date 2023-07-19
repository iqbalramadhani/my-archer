import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/core/models/objects/option_distance_model.dart';
import 'package:myarcher_enterprise/core/models/objects/schedule_holiday_model.dart';
import 'package:myarcher_enterprise/core/models/objects/time_operational_model.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/add_veneu/config_operational/widget/item_schedule.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/holiday_schedule/holiday_schedule_screen.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/operational_schedule/operational_schedule_screen.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/ui/shared/dialog.dart';
import 'package:myarcher_enterprise/ui/shared/edittext.dart';
import 'package:myarcher_enterprise/ui/shared/modal_bottom.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/date_helper.dart';
import 'package:myarcher_enterprise/utils/generated_data.dart';
import 'package:myarcher_enterprise/utils/sliver_grid_delegate_fixed.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class ConfigOperationalScreen extends StatelessWidget {
  final int id;
  final List<TimeOperationalModel> schedules;
  final List<ScheduleHolidayModel> holidaySchedules;
  final List<OptionDistanceModel> optionDistances;
  final int budrestQty;
  final int targetQty;
  final int arrowQty;
  final int peopleQty;
  final Function onReload;
  final Function onCheckValid;
  final Function onAssignData;
  const ConfigOperationalScreen({Key? key, required this.id, required this.schedules, required this.onReload, required this.holidaySchedules, required this.onCheckValid, required this.optionDistances, required this.budrestQty, required this.targetQty, required this.arrowQty, required this.peopleQty, required this.onAssignData}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String jamOperasionalSenin = Translator.notSet.tr;
    String jamIstirahatSenin = "-";
    if(schedules.any((element) => element.day == Translator.monday.tr)){
      var data = schedules.where((element) => element.day == Translator.monday.tr).first;
      if(data.isOpen == 0){
        jamOperasionalSenin = Translator.holiday.tr;
      }else{
        if(data.openTime != null && data.openTime!.isNotEmpty){
          jamOperasionalSenin = "${data.openTime!} - ${data.closedTime!}";
        }
        if(data.startBreakTime != null && data.startBreakTime!.isNotEmpty){
          jamIstirahatSenin = "${data.startBreakTime!}-${data.endBreakTime}";
        }
      }
    }

    String jamOperasionalSelasa = Translator.notSet.tr;
    String jamIstirahatSelasa = "-";
    if(schedules.any((element) => element.day == Translator.tuesday.tr)){
      var data = schedules.where((element) => element.day == Translator.tuesday.tr).first;
      if(data.isOpen == 0){
        jamOperasionalSelasa = Translator.holiday.tr;
      }else{
        if(data.openTime != null && data.openTime!.isNotEmpty){
          jamOperasionalSelasa = "${data.openTime!} - ${data.closedTime!}";
        }
        if(data.startBreakTime != null && data.startBreakTime!.isNotEmpty){
          jamIstirahatSelasa = "${data.startBreakTime!}-${data.endBreakTime}";
        }
      }
    }

    String jamOperasionalRabu = Translator.notSet.tr;
    String jamIstirahatRabu = "-";

    if(schedules.any((element) => element.day == Translator.wednesday.tr)){
      var data = schedules.where((element) => element.day == Translator.wednesday.tr).first;
      if(data.isOpen == 0){
        jamOperasionalRabu = Translator.holiday.tr;
      }else{
        if(data.openTime != null && data.openTime!.isNotEmpty){
          jamOperasionalRabu = "${data.openTime!} - ${data.closedTime!}";
        }
        if(data.startBreakTime != null && data.startBreakTime!.isNotEmpty){
          jamIstirahatRabu = "${data.startBreakTime!}-${data.endBreakTime}";
        }
      }
    }

    String jamOperasionalKamis = Translator.notSet.tr;
    String jamIstirahatKamis = "-";
    if(schedules.any((element) => element.day == Translator.thursday.tr)){
      var data = schedules.where((element) => element.day == Translator.thursday.tr).first;
      if(data.isOpen == 0){
        jamOperasionalKamis = Translator.holiday.tr;
      }else{
        if(data.openTime != null && data.openTime!.isNotEmpty){
          jamOperasionalKamis = "${data.openTime!} - ${data.closedTime!}";
        }
        if(data.startBreakTime != null && data.startBreakTime!.isNotEmpty){
          jamIstirahatKamis = "${data.startBreakTime!}-${data.endBreakTime}";
        }
      }
    }

    String jamOperasionalJumat = Translator.notSet.tr;
    String jamIstirahatJumat = "-";
    if(schedules.any((element) => element.day == Translator.friday.tr)){
      var data = schedules.where((element) => element.day == Translator.friday.tr).first;
      if(data.isOpen == 0){
        jamOperasionalJumat = Translator.holiday.tr;
      }else{
        if(data.openTime != null && data.openTime!.isNotEmpty){
          jamOperasionalJumat = "${data.openTime!} - ${data.closedTime!}";
        }
        if(data.startBreakTime != null && data.startBreakTime!.isNotEmpty){
          jamIstirahatJumat = "${data.startBreakTime!}-${data.endBreakTime}";
        }
      }
    }

    String jamOperasionalSabtu = Translator.notSet.tr;
    String jamIstirahatSabtu = "-";
    if(schedules.any((element) => element.day == Translator.saturday.tr)){
      var data = schedules.where((element) => element.day == Translator.saturday.tr).first;
      if(data.isOpen == 0){
        jamOperasionalSabtu = Translator.holiday.tr;
      }else{
        if(data.openTime != null && data.openTime!.isNotEmpty){
          jamOperasionalSabtu = "${data.openTime!} - ${data.closedTime!}";
        }
        if(data.startBreakTime != null && data.startBreakTime!.isNotEmpty){
          jamIstirahatSabtu = "${data.startBreakTime!}-${data.endBreakTime}";
        }
      }
    }

    String jamOperasionalMinggu = Translator.notSet.tr;
    String jamIstirahatMinggu = "-";
    if(schedules.any((element) => element.day == Translator.sunday.tr)){
      var data = schedules.where((element) => element.day == Translator.sunday.tr).first;
      if(data.isOpen == 0){
        jamOperasionalMinggu = Translator.holiday.tr;
      }else{
        if(data.openTime != null && data.openTime!.isNotEmpty){
          jamOperasionalMinggu = "${data.openTime!} - ${data.closedTime!}";
        }
        if(data.startBreakTime != null && data.startBreakTime!.isNotEmpty){
          jamIstirahatMinggu = "${data.startBreakTime!}-${data.endBreakTime}";
        }
      }
    }


    ///setting for field capacity
    var bantalanC = TextEditingController().obs;
    var targetC = TextEditingController().obs;
    var arrowC = TextEditingController().obs;
    var peopleC = TextEditingController().obs;

    RxList<OptionDistanceModel> selectedExistDistance = <OptionDistanceModel>[].obs;
    selectedExistDistance.addAll(optionDistances);

    RxInt budrest = budrestQty.obs;
    RxInt target = targetQty.obs;
    RxInt arrow = arrowQty.obs;
    RxInt people = peopleQty.obs;

    bantalanC.value.text = "$budrest";
    targetC.value.text = "$target";
    arrowC.value.text = "$arrow";
    peopleC.value.text = "$people";

    assignData(){
      onAssignData(
          budrest.value,
          target.value,
          arrow.value,
          people.value
      );
    }

    EventBus eventBus = EventBus();
    eventBus.on().listen((event) {
      if(event == "assign_data_distance"){
        assignData();
      }
    });

    return Container(
      color: AppColor.gray50,
      child: SingleChildScrollView(
        child: InkWell(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(wValue(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Translator.operationalSchedule.tr, style: textBaseBold),
                        InkWell(
                          child: Text(Translator.setSchedule.tr, style: textSmBold.copyWith(color: AppColor.colorPrimary)),
                          onTap: () async {
                            final result = await Navigator.push(
                              Get.context!,
                              MaterialPageRoute(builder: (context) => OperationScheduleScreen(id: id,)),
                            );

                            if(result  != null){
                              onReload();
                            }
                          },
                        ),
                      ],
                    ),
                    hSpace(12),
                    Text((schedules.isEmpty) ? Translator.descOperationalSchedule.tr : Translator.useWib.tr, style: textSmRegular.copyWith(color: AppColor.gray400)),
                    hSpace(15),
                    if(schedules.isNotEmpty) Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemSchedule(text1: Translator.day.tr, isHeader: true, text2: Translator.time.tr, text3: Translator.istirahat.tr),
                        ItemSchedule(text1: Translator.monday.tr, isHeader: false, text2: jamOperasionalSenin, text3: jamIstirahatSenin),
                        ItemSchedule(text1: Translator.tuesday.tr, isHeader: false, text2: jamOperasionalSelasa, text3: jamIstirahatSelasa),
                        ItemSchedule(text1: Translator.wednesday.tr, isHeader: false, text2: jamOperasionalRabu, text3: jamIstirahatRabu),
                        ItemSchedule(text1: Translator.thursday.tr, isHeader: false, text2: jamOperasionalKamis, text3: jamIstirahatKamis),
                        ItemSchedule(text1: Translator.friday.tr, isHeader: false, text2: jamOperasionalJumat, text3: jamIstirahatJumat),
                        ItemSchedule(text1: Translator.saturday.tr, isHeader: false, text2: jamOperasionalSabtu, text3: jamIstirahatSabtu),
                        ItemSchedule(text1: Translator.sunday.tr, isHeader: false, text2: jamOperasionalMinggu, text3: jamIstirahatMinggu),
                      ],
                    ),

                    hSpace(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Translator.holidaySchedule.tr, style: textBaseBold),
                        InkWell(
                          child: Text(Translator.setSchedule.tr, style: textSmBold.copyWith(color: AppColor.colorPrimary)),
                          onTap: () async {
                            final result = await Navigator.push(
                              Get.context!,
                              MaterialPageRoute(builder: (context) => HolidayScheduleScreen(id: id,)),
                            );

                            if(result  != null){
                              onReload();
                            }
                          },
                        ),
                      ],
                    ),
                    hSpace(12),
                    Text((holidaySchedules.isEmpty) ? Translator.descHolidaySchedule.tr : Translator.fieldCantRentDuringHoliday.tr, style: textSmRegular.copyWith(color: AppColor.gray400)),
                    hSpace(15),
                    if(holidaySchedules.isNotEmpty) Column(
                      children: [
                        for(var item in holidaySchedules) Text("${DateHelper().formattingDate(item.startAt!, "yyyy-MM-dd HH:mm:ss", "EEEE, dd MMMM yyyy")} - ${DateHelper().formattingDate(item.endAt!, "yyyy-MM-dd HH:mm:ss", "EEEE, dd MMMM yyyy")}", style: textSmRegular,)
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: hValue(15)),
                padding: EdgeInsets.all(wValue(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Translator.fieldCapacity.tr, style: textBaseBold),
                    hSpace(12),
                    Text(Translator.descFieldCapacity.tr, style: textSmRegular.copyWith(color: AppColor.gray400)),
                    hSpace(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Translator.distance.tr, style: textSmBold),
                        InkWell(
                          child: Text(Translator.addNew.tr, style: textSmBold.copyWith(color: AppColor.colorPrimary)),
                          onTap: (){
                            showInputWordDialog(textInputType : TextInputType.number, onSubmit: (String item){
                              selectedExistDistance.add(OptionDistanceModel(
                                  distance: int.parse(item),
                                  eoId: 100000000,
                                  checked: true,
                                  createdAt: "",
                                  updatedAt: "",
                                  id: 0
                              ));

                              bool isValid = holidaySchedules.isNotEmpty && schedules.isNotEmpty && selectedExistDistance.isNotEmpty;
                              onCheckValid(isValid, selectedExistDistance);
                            }, textButtonNeg: Translator.cancel.tr, textButtonPos: Translator.save.tr, title: Translator.addDistance.tr);
                          },
                        )
                      ],
                    ),
                    hSpace(10),
                    Obx(()=> (selectedExistDistance.isEmpty)? Text(Translator.fillDistanceAvailable.tr, style: textSmRegular.copyWith(color: AppColor.gray400)) : Container()),
                    Obx(()=> (selectedExistDistance.isNotEmpty) ? Container(
                      padding: EdgeInsets.only(left: wValue(10), right: wValue(10)),
                      child: GridView.builder(
                        itemCount: selectedExistDistance.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          var data = selectedExistDistance[index];
                          return Row(
                            children: [
                              Expanded(flex : 1, child: Text("${data.distance}m", style: textSmRegular)),
                              InkWell(
                                child: SvgPicture.asset(Assets.icons.icVerticalDot),
                                onTap: (){
                                  modalBottomDynamicAction(actions: GeneratedData().actionDistance(), onItemSelected: (action){
                                    if(action.toString().contains(Translator.editDistance.tr)){
                                      if(data.id == 0){
                                        showInputWordDialog(onSubmit: (String item){
                                          selectedExistDistance[index] = OptionDistanceModel(
                                              id: data.id,
                                              updatedAt: data.updatedAt,
                                              createdAt: data.createdAt,
                                              checked: data.checked,
                                              eoId: data.eoId,
                                              distance: int.parse(item)
                                          );

                                          bool isValid = holidaySchedules.isNotEmpty && schedules.isNotEmpty && selectedExistDistance.isNotEmpty;
                                          onCheckValid(isValid, selectedExistDistance);

                                        }, title: Translator.editDistance.tr, currentData: "${data.distance}");
                                      }else{
                                        modalBottomCurrentDistance(currentData: selectedExistDistance, onItemSelected: (data){
                                          selectedExistDistance.removeWhere((element) => element.id != 0);
                                          selectedExistDistance.addAll(data);

                                          bool isValid = holidaySchedules.isNotEmpty && schedules.isNotEmpty && selectedExistDistance.isNotEmpty;
                                          onCheckValid(isValid, selectedExistDistance);
                                        });
                                      }
                                    }else{
                                      showConfirmDialog(Get.context!, content: Translator.msgDeleteDistance.tr, showIcon: true,
                                          assets: Assets.icons.icAlert, typeAsset: "svg",
                                          showCloseTopCorner: true,
                                          btn1: Translator.canceling.tr,
                                          btn3: Translator.delete.tr,
                                          onClickBtn1: (){
                                            Get.back();
                                          }, onClickBtn3: (){
                                            selectedExistDistance.removeAt(index);

                                            bool isValid = holidaySchedules.isNotEmpty && schedules.isNotEmpty && selectedExistDistance.isNotEmpty;
                                            onCheckValid(isValid, selectedExistDistance);
                                          });
                                    }
                                  });
                                },
                              )
                            ],
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            crossAxisCount: 4,
                            crossAxisSpacing: wValue(10),
                            mainAxisSpacing: hValue(10),
                            height: hValue(20)
                        ),
                      ),
                    ) : Container()),
                    hSpace(10),
                    Button(title: Translator.chooseFromCurrent.tr, textSize: fontSize(10), enable: true, onClick: (){
                      modalBottomCurrentDistance(currentData: selectedExistDistance, onItemSelected: (data){
                        selectedExistDistance.removeWhere((element) => element.id != 0);
                        selectedExistDistance.addAll(data);

                        bool isValid = holidaySchedules.isNotEmpty && schedules.isNotEmpty && selectedExistDistance.isNotEmpty;
                        onCheckValid(isValid, selectedExistDistance);
                      });
                    }, borderColor: AppColor.colorPrimary, color: Colors.white,  fontColor: AppColor.colorPrimary, height: hValue(34)),
                    hSpace(15),
                    Row(
                      children: [
                        Expanded(flex: 1,child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Translator.bantalanCount.tr, style: textLabelSmall),
                            hSpace(5),
                            Obx(()=> EditText(
                                onChange: (String v){
                                  budrest.value = v.toString().isNotEmpty ? int.parse(v) : 0;
                                },
                                onSubmit: (v){
                                  assignData();
                                },
                                controller: bantalanC.value,
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.number,
                                borderColor: AppColor.gray200,
                                contentPadding: EdgeInsets.symmetric(horizontal: wValue(10), vertical: hValue(5))
                            ))
                          ],
                        ),),
                        wSpace(10),
                        Expanded(flex: 1,child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Translator.targetCount.tr, style: textLabelSmall),
                            hSpace(5),
                            EditText(
                                onChange: (v){
                                  target.value = v.toString().isNotEmpty ? int.parse(v) : 0;
                                },
                                onSubmit: (v){
                                  assignData();
                                },
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.number,
                                controller: targetC.value,
                                borderColor: AppColor.gray200,
                                contentPadding: EdgeInsets.symmetric(horizontal: wValue(10), vertical: hValue(5))
                            )
                          ],
                        ),),
                      ],
                    ),
                    hSpace(15),
                    Row(
                      children: [
                        Expanded(flex: 1,child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Translator.arrowCount.tr, style: textLabelSmall),
                            hSpace(5),
                            EditText(
                                onChange: (v){
                                  arrow.value = v.toString().isNotEmpty ? int.parse(v) : 0;
                                },
                                onSubmit: (v){
                                  assignData();
                                },
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.number,
                                controller: arrowC.value,
                                borderColor: AppColor.gray200,
                                contentPadding: EdgeInsets.symmetric(horizontal: wValue(10), vertical: hValue(5))
                            )
                          ],
                        ),),
                        wSpace(10),
                        Expanded(flex: 1,child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Translator.peopleCapacity.tr, style: textLabelSmall),
                            hSpace(5),
                            EditText(
                                onChange: (v){
                                  people.value = v.toString().isNotEmpty ? int.parse(v) : 0;
                                },
                                onSubmit: (v){
                                  assignData();
                                },
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.number,
                                controller: peopleC.value,
                                borderColor: AppColor.gray200,
                                contentPadding: EdgeInsets.symmetric(horizontal: wValue(10), vertical: hValue(5))
                            )
                          ],
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
              hSpace(110),
            ],
          ),
          onTap: (){
            assignData();
          },
        ),
      ),
    );
  }
}


