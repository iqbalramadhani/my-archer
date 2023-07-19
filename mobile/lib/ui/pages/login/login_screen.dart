import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/global_helper.dart';
import 'package:my_archery/utils/screen_util.dart';
import 'package:my_archery/utils/theme.dart';
import 'package:my_archery/utils/translator.dart';

import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var controller = LoginController();

  @override
  void initState() {
    controller.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: BaseContainer(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: bgPage,
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ScreenUtil().setHeight(70),),
                      Image.asset("assets/img/logo.png", width: ScreenUtil().setWidth(75),),
                      SizedBox(height: ScreenUtil().setHeight(15),),
                      Text(Translator.welcome.tr, style: boldTextFont.copyWith(fontSize: ScreenUtil().setSp(24))),
                      SizedBox(height: ScreenUtil().setHeight(5),),
                      Text(Translator.loginAsAdmin.tr, style: boldTextFont.copyWith(fontSize: ScreenUtil().setSp(20))),
                      SizedBox(height: ScreenUtil().setHeight(25),),

                      Text(Translator.usernameOrEmail.tr, style: boldTextFont.copyWith(fontSize: ScreenUtil().setSp(12))),
                      SizedBox(height: ScreenUtil().setHeight(5),),
                      EditText(textInputType: TextInputType.text, textInputAction: TextInputAction.next,  controller: controller.usernameController.value, hintText: Translator.hintUsername.tr,  onSubmit: (_){

                      }),
                      SizedBox(height: ScreenUtil().setHeight(15),),
                      Text(Translator.password.tr, style: boldTextFont.copyWith(fontSize: ScreenUtil().setSp(12))),
                      SizedBox(height: ScreenUtil().setHeight(5),),
                      EditText(textInputType: TextInputType.text, textInputAction : TextInputAction.done, controller: controller.passwordController.value, obsecureText: true, hintText: Translator.hintPassword.tr,  onSubmit: (_){

                      }),
                      SizedBox(height: ScreenUtil().setHeight(15),),
                      Container(
                        child: Button(title: Translator.login.tr, color : colorAccentDark,  enable : true, onClick: (){
                          controller.loginAction();
                        }, fontSize: ScreenUtil().setSp(12), height: ScreenUtil().setHeight(40)),
                        width: Get.width,
                      )
                    ],
                  ),
                  margin: EdgeInsets.all(ScreenUtil().setWidth(15)),
                ),
                Positioned(child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(ScreenUtil().setHeight(15)),
                  width: Get.width,
                  child: Text("${getCurrentFormatedTime('yyyy')} © Design & Develop by Reka Cipta Digital", style: regularTextFont.copyWith(fontSize: ScreenUtil().setSp(10)), textAlign: TextAlign.center,),
                ), bottom: 0,)
              ],
            ),
          ),
        ),
      )
    );
  }
}
