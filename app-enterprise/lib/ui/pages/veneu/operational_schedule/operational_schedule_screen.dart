import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/operational_schedule/operational_schedule_controller.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/operational_schedule/widget/item_schedule_operational.dart';
import 'package:myarcher_enterprise/ui/shared/appbar.dart';
import 'package:myarcher_enterprise/ui/shared/base_container.dart';
import 'package:myarcher_enterprise/ui/shared/loading.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class OperationScheduleScreen extends StatefulWidget {
  final int id;
  const OperationScheduleScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<OperationScheduleScreen> createState() => _OperationScheduleScreenState();
}

class _OperationScheduleScreenState extends State<OperationScheduleScreen> {
  var controller = OperationalScheduleController();

  @override
  void initState() {
    controller.apiListScheduleOperational(id: widget.id);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BaseContainer(child: WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomAppBar(title: Translator.operationalSchedule.tr, onClick: (){
              onWillPop();
            }),
            Expanded(flex: 1,child: SingleChildScrollView(
              child: Obx(()=> controller.isLoading.value ? loading() : Column(
                children: [
                  ItemSchedulOperational(placeId : widget.id, day: Translator.monday.tr, data: controller.schedules.any((p0) => p0.day! == Translator.monday.tr) ? controller.schedules.where((p0) => p0.day! == Translator.monday.tr).first : null, onReload: (){
                    controller.apiListScheduleOperational(id: widget.id, isClear: true);
                  },),
                  ItemSchedulOperational(placeId : widget.id, day: Translator.tuesday.tr, data: controller.schedules.any((p0) => p0.day! == Translator.tuesday.tr) ? controller.schedules.where((p0) => p0.day! == Translator.tuesday.tr).first : null, onReload: (){
                    controller.apiListScheduleOperational(id: widget.id, isClear: true);
                  }),
                  ItemSchedulOperational(placeId : widget.id, day: Translator.wednesday.tr, data: controller.schedules.any((p0) => p0.day! == Translator.wednesday.tr) ? controller.schedules.where((p0) => p0.day! == Translator.wednesday.tr).first : null, onReload: (){
                    controller.apiListScheduleOperational(id: widget.id, isClear: true);
                  }),
                  ItemSchedulOperational(placeId : widget.id, day: Translator.thursday.tr, data: controller.schedules.any((p0) => p0.day! == Translator.thursday.tr) ? controller.schedules.where((p0) => p0.day! == Translator.thursday.tr).first : null, onReload: (){
                    controller.apiListScheduleOperational(id: widget.id, isClear: true);
                  }),
                  ItemSchedulOperational(placeId : widget.id, day: Translator.friday.tr, data: controller.schedules.any((p0) => p0.day! == Translator.friday.tr) ? controller.schedules.where((p0) => p0.day! == Translator.friday.tr).first : null, onReload: (){
                    controller.apiListScheduleOperational(id: widget.id, isClear: true);
                  }),
                  ItemSchedulOperational(placeId : widget.id, day: Translator.saturday.tr, data: controller.schedules.any((p0) => p0.day! == Translator.saturday.tr) ? controller.schedules.where((p0) => p0.day! == Translator.saturday.tr).first : null, onReload: (){
                    controller.apiListScheduleOperational(id: widget.id, isClear: true);
                  }),
                  ItemSchedulOperational(placeId : widget.id, day: Translator.sunday.tr, data: controller.schedules.any((p0) => p0.day! == Translator.sunday.tr) ? controller.schedules.where((p0) => p0.day! == Translator.sunday.tr).first : null, onReload: (){
                    controller.apiListScheduleOperational(id: widget.id, isClear: true);
                  }),
                ],
              )),
            ),)
          ],
        ),
      ),
    ));
  }

  Future<bool> onWillPop() async {
    Navigator.pop(context, true);
    return false;
  }
}
