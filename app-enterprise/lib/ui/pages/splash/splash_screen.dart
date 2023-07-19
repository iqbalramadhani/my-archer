import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/splash/splash_controller.dart';
import 'package:myarcher_enterprise/ui/shared/base_container.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/screen_util.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var controller = SplashController();

  @override
  void initState() {
    initializeDateFormatting("id_ID").then((value) => controller.initController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 360, height: 640, allowFontScaling: true)..init(context);

    return BaseContainer(child: Scaffold(
      body: Stack(
        children: [
          Center(
            child: GlobalHelper().fadeIn(widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.logo.image(width: wValue(181)),
                hSpace(5),
              ],
            ), durationms: 1000),
          ),
          Align(alignment: Alignment.bottomCenter,child: Container(
            margin: EdgeInsets.only(bottom: hValue(35)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${controller.currentYear.value} © ${Translator.designDevelopBy.tr}", style: regularTextFont.copyWith(fontSize: fontSize(14), color: const Color(0xFF545454)),),
                Text(Translator.rekaCiptaDigital.tr, style: regularTextFont.copyWith(fontSize: fontSize(14), color: const Color(0xFF545454)),),
              ],
            ),
          ),)
        ],
      ),
    ));
  }
}
