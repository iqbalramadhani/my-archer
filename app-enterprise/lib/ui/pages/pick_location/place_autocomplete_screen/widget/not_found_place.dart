import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

import '../../../../../utils/theme.dart';

class NotFoundPlace extends StatelessWidget {
  const NotFoundPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translator.placeNotFound.tr, style: textBaseBold),
          Text(Translator.descPlaceNotFound.tr, style: textXsRegular),
        ],
      ),
    );
  }
}
