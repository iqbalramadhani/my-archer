import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myarchery_archer/utils/screen_util.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/dialog.dart';
import 'package:myarchery_archer/ui/shared/edittext.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../register/register_screen.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {

  var controller = LoginController();
  PageController pageController = PageController();

  @override
  void initState() {
    controller.initController();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterInit());
    super.initState();
  }

  afterInit(){
  }

  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(width: 360, height: 640, allowFontScaling: true)..init(context);

    return WillPopScope(child: Container(
      color: colorAccent,
      child: BaseContainer(
          child: Obx(()=> SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Container(
                    child: Image.asset("assets/img/bg_login.png", fit: BoxFit.fill,),
                    width: Get.width,
                    height: Get.height,
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text("welcome".tr, style: boldTextFont.copyWith(fontSize: fontSize(24), color: Colors.white)),
                        margin: EdgeInsets.only(top: hValue(40)),
                      ),
                      Container(
                        child: Text("Temukan berbagai event panahan di sini", style: regularTextFont.copyWith(fontSize: fontSize(14), color: Colors.white)),
                        margin: EdgeInsets.only(top: hValue(4)),
                      ),
                      Expanded(child: Container(
                        width: Get.width,
                        height: Get.height,
                        padding: EdgeInsets.all(wValue(25)),
                        margin: EdgeInsets.only(top: hValue(28)),
                        child: Column(
                          children: [
                            Expanded(child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  hSpace(10),
                                  Image.asset("assets/img/logo.png", width: wValue(64),),
                                  hSpace(24),
                                  Text("please_enter".tr, style: boldTextFont.copyWith(fontSize: fontSize(24)),),
                                  SizedBox(height: hValue(24),),

                                  Container(
                                    height: hValue(200),
                                    child: PageView(
                                        physics: NeverScrollableScrollPhysics(),
                                        controller: pageController,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          viewFirstStep(),
                                          viewSecondStep(),
                                        ],
                                        onPageChanged: (int index) =>{}
                                    ),

                                  ),
                                ],
                              ),
                            ), flex: 1,),
                            viewButtons()
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                          color: Colors.white,
                        ),
                      ), flex: 1,)
                    ],
                  )

                ],
              ),
            ),
          )),
      ),
    ), onWillPop: onWillPop);
  }

  Future<bool> onWillPop() async {
    if(controller.currentStep.value > 0){
      controller.currentStep.value = 0;
      pageController.animateToPage(controller.currentStep.value, curve: Curves.easeIn, duration: Duration(milliseconds: 500));
    }else{
      Navigator.pop(context, true);
    }
    return false;
  }

  viewButtons(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Button(controller.currentStep.value == 0 ? Translator.next.tr : Translator.login.tr, colorAccentDark,  true, (){
            if(controller.currentStep.value == 0){
              if(controller.usernameController.value.text.isEmpty){
                controller.validationEmail.value = "Email tidak boleh kosong";
                return;
              }

              if(!isEmailValid(controller.usernameController.value.text.toString())){
                return;
              }

              controller.currentStep.value += 1;
              controller.validationEmail.value = "";
              pageController.animateToPage(controller.currentStep.value, curve: Curves.easeIn, duration: Duration(milliseconds: 500));
            }else {
              controller.loginAction();
            }
          }, textSize: fontSize(12), height: hValue(40)),
          hSpace(8),
          Button(Translator.register.tr, Colors.white,  true, (){
            goToPage(RegisterScreen());
          }, textSize: fontSize(12), height: hValue(40), fontColor: colorAccent)

        ],
      ),
    );
  }

  viewFirstStep(){
    return Column(
      children: [
        Container(
          child: Text("email".tr, style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
          width: Get.width,
        ),
        hSpace(5),
        EditText(textInputType: TextInputType.emailAddress, onChange: (e){
          if(!isEmailValid(e)){
            controller.validationEmail.value = "Email tidak valid";
          }else{
            controller.validationEmail.value = "";
          }
        }, validatorText: controller.validationEmail.value, textInputAction: TextInputAction.next,  controller: controller.usernameController.value, hintText: "hint_email".tr,  onSubmit: (_){

        }),
      ],
    );
  }

  viewSecondStep(){
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("email".tr, style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
                hSpace(5),
                Text("${controller.usernameController.value.text}", style: boldTextFont.copyWith(fontSize: fontSize(12)), textAlign: TextAlign.left,),
              ],
            ), flex: 1,),
            wSpace(5),
            Button("Ubah", grey, true, (){
              controller.currentStep.value = 0;
              pageController.animateToPage(controller.currentStep.value, curve: Curves.easeIn, duration: Duration(milliseconds: 500));
            }, height: hValue(31), textSize: fontSize(12), fontColor: colorAccent)
          ],
        ),

        hSpace(15),
        Container(
          child: Text("password".tr, style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
          width: Get.width,
        ),
        hSpace(5),
        EditText(textInputType: TextInputType.text, validatorText: controller.validationPass.value, rightIcon: controller.isShowPass.value ? "assets/icons/ic_hide_pass.svg" : "assets/icons/ic_show_pass.svg",
            onRightIconClicked: (){
            controller.isShowPass.value = !controller.isShowPass.value;
        }, textInputAction : TextInputAction.done, controller: controller.passwordController.value, obsecureText: !controller.isShowPass.value, hintText: "hint_password".tr,  onSubmit: (_){

        }),
        hSpace(10),
        Align(
          child: InkWell(
            child: Text("${Translator.forgotPass.tr} ?", style: boldTextFont.copyWith(fontSize: fontSize(12), color: colorAccent),),
            onTap: (){
              showConfirmDialog(context, showIcon: true, content :  "Link atur ulang kata sandi akan dikirimkan ke ${controller.usernameController.value.text}",
                  assets: "assets/icons/ic_alert.svg", btn2: "Iya", onClickBtn2: (){
                controller.apiForgotPass();
              }, btn3: "Tidak", onClickBtn3: (){});

            },
          ),
          alignment: Alignment.centerRight,
        )
      ],
    );
  }
}
