import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:myarchery_archer/gen/assets.gen.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../main/main_screen.dart';

class CompleteVerifyScreen extends StatelessWidget {
  const CompleteVerifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: SafeArea(
        child: WillPopScope(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Assets.img.imgVerifySent.path, width: wValue(250),),
                  hSpace(15),
                  Text(Translator.msgSuccessRequestVerify.tr, style: regularTextFont.copyWith(fontSize: fontSize(14), color: Colors.black), textAlign: TextAlign.center,),
                  hSpace(25),
                  Container(
                    child: Button(Translator.backToMainpage.tr, colorPrimaryDark, true, (){
                      onWillPop();
                    }, textSize: fontSize(12)),
                    width: wValue(250),
                  )
                ],
              ),
              padding: EdgeInsets.all(wValue(25)),
            ),
          ),
          onWillPop: onWillPop,
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    goToPage(MainScreen(), dismissAllPage: true);
    return true;
  }
}
