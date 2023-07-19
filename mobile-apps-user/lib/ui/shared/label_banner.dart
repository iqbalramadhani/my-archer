import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/utils/theme.dart';

class LabelBanner extends StatelessWidget {
  final String? title;
  const LabelBanner({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Align(
        child: Banner(
          message: title ?? "Testing",
          textStyle:
              boldTextFont.copyWith(color: Colors.black, fontSize: fontSize(8)),
          location: BannerLocation.topEnd,
          color: Colors.yellow,
        ),
        alignment: Alignment.topRight,
      ),
    );
  }
}
