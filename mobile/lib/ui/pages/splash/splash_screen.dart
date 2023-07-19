import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:my_archery/gen/assets.gen.dart';
import 'package:my_archery/ui/pages/splash/splash_controller.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/global_helper.dart';
import 'package:my_archery/utils/screen_util.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';
import 'package:my_archery/utils/translator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var controller = SplashController();

  @override
  void initState() {
    controller.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 360, height: 640, allowFontScaling: true)..init(context);

    return Container(
      color: Colors.white,
      child: BaseContainer(
        child: Scaffold(
          body: Center(
            child: fadeIn(Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.img.logo.image(width: wValue(200)),
                hSpace(5),
                Text(Translator.scoringApp.tr, style: boldTextFont.copyWith(fontSize: fontSize(12)),),
                hSpace(15)
              ],
            ), 1000),
          ),
        ),
      )
    );
  }
}
