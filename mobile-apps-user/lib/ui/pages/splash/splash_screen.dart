import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/ui/pages/splash/splash_controller.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/utils/screen_util.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';

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

    return BaseContainer(
      child: Container(
        child: SafeArea(child: Scaffold(
          body: Container(
            width: Get.width,
            height: Get.height,
            child: Stack(
              children: [
                Center(
                  child: fadeIn(Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/img/logo.png", width: wValue(181),),
                      hSpace(5),
                    ],
                  ), 1000),
                ),
                Align(child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${controller.currentYear.value} © Design & Develop by", style: regularTextFont.copyWith(fontSize: fontSize(14), color: Color(0xFF545454)),),
                      Text("Reka Cipta Digital", style: regularTextFont.copyWith(fontSize: fontSize(14), color: Color(0xFF545454)),),
                    ],
                  ),
                  margin: EdgeInsets.only(bottom: hValue(35)),
                ), alignment: Alignment.bottomCenter,)
              ],
            ),
          ),
        )),
        color: colorPrimary,
      ),
    );
  }
}
