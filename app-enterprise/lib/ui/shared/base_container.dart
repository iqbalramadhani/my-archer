import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/ui/shared/label_banner.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/endpoint.dart';

class BaseContainer extends StatelessWidget {
  final Widget child;
  const BaseContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: AppColor.colorPrimary,
      child: Stack(
        children: [
          SafeArea(child: child),
          baseUrl.contains("staging") ? const LabelBanner() : Container()
        ],
      ),
    );
  }
}
