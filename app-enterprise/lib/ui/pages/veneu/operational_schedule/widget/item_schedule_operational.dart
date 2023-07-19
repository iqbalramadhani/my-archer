import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:myarcher_enterprise/core/models/objects/time_operational_model.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/operational_schedule/widget/item_jam.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/operational_schedule/widget/modal_bottom_operational.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class ItemSchedulOperational extends StatelessWidget {
  final int placeId;
  final String day;
  final TimeOperationalModel? data;
  final Function onReload;

  const ItemSchedulOperational({Key? key, required this.day, this.data, required this.placeId, required this.onReload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool libur = false;

    String openTime = "";
    String closeTime = "";

    String startBreak = "";
    String endBreak = "";

    if (data != null) {
      libur = data!.isOpen == 0;
      openTime = data!.openTime != null ? data!.openTime! :  libur ? Translator.holiday.tr : "";
      closeTime = data!.closedTime != null ? data!.closedTime! :  libur ? Translator.holiday.tr : "";

      startBreak = data!.startBreakTime != null ? data!.startBreakTime! :  libur ? Translator.holiday.tr : "";
      endBreak = data!.endBreakTime != null ? data!.endBreakTime! :  libur ? Translator.holiday.tr : "";
    }

    return Container(
      margin: EdgeInsets.only(top: hValue(17)),
      padding: EdgeInsets.only(left: wValue(25), right: wValue(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: textBaseBold,
          ),
          hSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: ItemJam(
                  holiday: libur,
                  time: openTime,
                  hint: Translator.open.tr,
                  onClick: () {
                    modalBottomSetOperationalSchedule(currentData: data, onSave: (){
                      onReload();
                    }, onDelete: (){
                      onReload();
                    }, placeId: placeId, day: day);
                  },
                ),
              ),
              wSpace(17),
              Expanded(
                flex: 1,
                child: ItemJam(
                  holiday: libur,
                  time: closeTime,
                  onClick: () {
                    modalBottomSetOperationalSchedule(currentData: data, onSave: (){
                      onReload();
                    }, onDelete: (){
                      onReload();
                    }, placeId: placeId, day: day);
                  },
                  hint: Translator.close.tr,
                ),
              ),
            ],
          ),
          if((data?.startBreakTime != null && data!.startBreakTime!.isNotEmpty) && (data?.endBreakTime != null && data!.endBreakTime!.isNotEmpty)) Container(
            margin: EdgeInsets.only(top: hValue(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Translator.breakTime.tr, style: textSmRegular,),
                hSpace(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ItemJam(
                        holiday: libur,
                        time: startBreak,
                        hint: Translator.open.tr,
                        onClick: () {
                          modalBottomSetOperationalSchedule(currentData: data, onSave: (){
                            onReload();
                          }, onDelete: (){
                            onReload();
                          }, placeId: placeId, day: day);
                        },
                      ),
                    ),
                    wSpace(17),
                    Expanded(
                      flex: 1,
                      child: ItemJam(
                        holiday: libur,
                        time: endBreak,
                        onClick: () {
                          modalBottomSetOperationalSchedule(currentData: data, onSave: (){
                            onReload();
                          }, onDelete: (){
                            onReload();
                          }, placeId: placeId, day: day);
                        },
                        hint: Translator.close.tr,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          hSpace(10),
          Divider(),
        ],
      ),
    );
  }
}
