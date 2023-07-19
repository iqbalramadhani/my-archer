import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';

class ItemTypeField extends StatelessWidget {
  final String item;
  final bool isSelected;
  final Function onClick;
  const ItemTypeField({Key? key, required this.item, required this.isSelected, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onClick();
      },
      child: Row(
        children: [
          SvgPicture.asset(isSelected ? Assets.icons.icRadioSelected : Assets.icons.icRadioUnselected),
          wSpace(5),
          Text(item, style: textBaseRegular,),
        ],
      ),
    );
  }
}
