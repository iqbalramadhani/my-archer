import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';

class CheckBox extends StatelessWidget {
  final String label;
  final bool isChecked;
  final Function onChange;
  const CheckBox({Key? key, required this.label, required this.isChecked, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: wValue(15),
            height: hValue(15),
            child: InkWell(
              child: SvgPicture.asset(isChecked ? Assets.icons.icChecked : Assets.icons.icUncheck),
              onTap: (){
                onChange();
              },
            )
        ),
        wSpace(5),
        Text(label, style: textSmRegular,)
      ],
    );
  }
}
