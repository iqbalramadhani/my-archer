import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/core/models/objects/facility_model.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';

class ItemExistFacility extends StatelessWidget {
  final FacilityModel data;
  final Function onCheked;
  final Function onDelete;
  const ItemExistFacility({Key? key, required this.data, required this.onCheked, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: hValue(10)),
      width: Get.width,
      padding: EdgeInsets.all(wValue(15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.gray50,
      ),
      child: Row(
        children: [
          SizedBox(
              width: wValue(15),
              height: hValue(15),
              child: InkWell(
                child: SvgPicture.asset(data.checked != null && data.checked! ? Assets.icons.icChecked : Assets.icons.icUncheck),
                onTap: (){
                  bool checked = false;
                  if(data.checked == null){
                    checked = true;
                  }else{
                    checked = !data.checked!;
                  }
                  onCheked(checked);
                },
              )
          ),
          wSpace(10),
          Expanded(flex: 1,child: Text(
            data.name ?? "-",
            style: boldTextFont.copyWith(fontSize: fontSize(13)),
          ),),
          wSpace(10),
          InkWell(
            child: SvgPicture.asset(Assets.icons.icClose),
            onTap: (){
              onDelete();
            },
          )
        ],
      ),
    );
  }
}
