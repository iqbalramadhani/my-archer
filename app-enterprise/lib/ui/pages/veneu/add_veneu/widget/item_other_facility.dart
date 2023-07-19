import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myarcher_enterprise/core/models/objects/facility_model.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';

class ItemOtherFacility extends StatelessWidget {
  final FacilityModel item;
  final bool isEditable;
  final Function onAction;
  const ItemOtherFacility({Key? key, required this.item, required this.onAction, required this.isEditable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: hValue(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.name ?? "-", style: textSmRegular,),
          if(isEditable) InkWell(
            child: SvgPicture.asset(Assets.icons.icThreeDots),
            onTap: (){
              onAction();
            },
          )
        ],
      ),
    );
  }
}
