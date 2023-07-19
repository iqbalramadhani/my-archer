import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';

class ItemPlace extends StatelessWidget {
  final AutocompletePrediction data;
  final Function onClick;
  const ItemPlace({Key? key, required this.data, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: hValue(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.structuredFormatting?.mainText ?? "", style: textBaseBold),
            Text(data.description ?? "", style: textXsRegular),
          ],
        ),
      ),
      onTap: (){
        onClick();
      },
    );
  }
}
