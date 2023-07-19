import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/core/models/objects/facility_model.dart';
import 'package:myarcher_enterprise/core/models/objects/option_distance_model.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';

class ItemOptionDistance extends StatelessWidget {
  final OptionDistanceModel data;
  final Function onCheked;
  const ItemOptionDistance({Key? key, required this.data, required this.onCheked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(bottom: hValue(10)),
        width: Get.width,
        padding: EdgeInsets.all(wValue(15)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.gray50,
        ),
        child: Row(
          children: [
            Expanded(flex: 1,child: Text(
              data.distance == null ? "-" : "${data.distance}m",
              style: boldTextFont.copyWith(fontSize: fontSize(13)),
            ),),
            wSpace(10),
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
          ],
        ),
      ),
      onTap: (){
        bool checked = false;
        if(data.checked == null){
          checked = true;
        }else{
          checked = !data.checked!;
        }
        onCheked(checked);
      },
    );
  }
}
