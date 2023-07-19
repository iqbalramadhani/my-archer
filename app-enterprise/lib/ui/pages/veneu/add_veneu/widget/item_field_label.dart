import 'package:flutter/material.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';

class ItemFieldLabel extends StatelessWidget {
  final String title;
  final bool required;
  const ItemFieldLabel({Key? key, required this.title, required this.required}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
          text: "$title ",
          style: textLabelSmall.copyWith(fontSize: fontSize(12)),
          children: <TextSpan>[
            if(required) TextSpan(
                text: "*",
                style: textLabelSmall.copyWith(
                    color: Colors.red, fontSize: fontSize(12))),
          ]),
    );
  }
}
