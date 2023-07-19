import 'package:flutter/material.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
enum StatusTime{
  open,
  close
}
class ItemJam extends StatelessWidget {
  final String? time;
  final String hint;
  final bool holiday;
  final Function onClick;
  final bool? showRightIcon;
  const ItemJam({Key? key, this.time, required this.holiday, required this.onClick, required this.hint, this.showRightIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: wValue(16), vertical: hValue(8)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: holiday ? AppColor.gray200 : Colors.white,
            border: Border.all(
              color: AppColor.gray400,
              width: 1,
            )
        ),
        child: Row(
          children: [
            Expanded(flex: 1,child: Text((time == null || time!.isEmpty) ? hint : time!, style: regularTextFont.copyWith(fontSize: fontSize(14), color:(time == null || time!.isEmpty) ? AppColor.gray400 : Colors.black),),),
            if(showRightIcon == null || showRightIcon!) Container(
              margin: EdgeInsets.only(left: wValue(5)),
              child: const Icon(Icons.keyboard_arrow_down),
            )
          ],
        ),
      ),
      onTap: (){
        onClick();
      },
    );
  }
}
