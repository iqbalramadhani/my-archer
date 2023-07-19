import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/operational_schedule/widget/item_jam.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/date_helper.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class ItemScheduleHoliday extends StatelessWidget {
  final int placeId;
  final String startDate;
  final String endDate;
  final Function onReload;
  final Function onClick;
  final Function onDelete;

  const ItemScheduleHoliday({Key? key, required this.placeId, required this.onReload, required this.startDate, required this.endDate, required this.onClick, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxString startDateTimeStr = startDate.obs;
    RxString endDateTimeStr = endDate.obs;

    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: hValue(17)),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_){
                  onDelete();
                },
                backgroundColor: Colors.white,
                foregroundColor: AppColor.negativeRed,
                icon: Icons.delete,
                label: Translator.delete.tr,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          time: DateHelper().formattingDate(startDateTimeStr.value, "yyyy-MM-dd HH:mm:ss", "dd/MM/yyyy"),
                          hint: Translator.formatDate.tr,
                          onClick: () {
                            onClick();
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
                            time: DateHelper().formattingDate(endDateTimeStr.value, "yyyy-MM-dd HH:mm:ss", "dd/MM/yyyy"),
                            onClick: () {
                              onClick();
                            },
                            hint: Translator.formatDate.tr,
                          )),
                        ],
                      )
                  ),
                ],
              ),
              hSpace(10),
              const Divider(),
            ],
          ),
        ),
      ),
      onTap: (){
        onClick();
      },
    );
  }
}
