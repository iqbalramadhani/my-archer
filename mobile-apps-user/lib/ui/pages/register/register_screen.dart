import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/ui/pages/register/registe_controller.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/edittext.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../main/main_screen.dart';
import '../profile/verify/verify_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {

  var controller = RegisterController();

  RxString selectedGender = "".obs;

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
    return WillPopScope(child: Container(
      color: colorAccent,
      child: BaseContainer(
          child: Obx(()=> SafeArea(
            child: Scaffold(
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
                        child: Text(Translator.pleaseRegister.tr, style: boldTextFont.copyWith(fontSize: fontSize(24), color: Colors.white)),
                        margin: EdgeInsets.only(top: hValue(40)),
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
                                  if(controller.currentStep.value < 2) viewHeader(),

                                  Container(
                                    height: controller.currentStep.value == 2 ? hValue(350) : hValue(300),
                                    child: PageView(
                                        physics: NeverScrollableScrollPhysics(),
                                        controller: controller.pageController.value,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          viewFirstStep(),
                                          viewSecondStep(),
                                          viewCompleteRegister()
                                        ],
                                        onPageChanged: (int index) =>{}
                                    ),

                                  ),

                                ],
                              ),
                            ), flex: 1,),
                            (controller.currentStep.value == 2) ? viewButtonFindEvent() : viewButtons()
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

  viewHeader(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hSpace(10),
        Image.asset("assets/img/logo.png", width: wValue(64),),
        hSpace(24),
        Text(Translator.dataUser.tr, style: boldTextFont.copyWith(fontSize: fontSize(24)),),
        SizedBox(height: hValue(24),),
      ],
    );
  }

  Future<bool> onWillPop() async {
    if(controller.currentStep.value > 0){
      controller.currentStep.value -= 1;
    }else{
      Navigator.pop(context, true);
    }
    return true;
  }

  viewButtons(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Button(controller.currentStep.value == 0 ? "next".tr : "register".tr, colorAccentDark,  true, (){
            if(controller.currentStep.value == 0){
              if(controller.fullNameTxtController.value.text.isEmpty){
                controller.validationNama.value = "Nama Lengkap tidak boleh kosong";
                return;
              }

              if(controller.birthDateTxtController.value.text.isEmpty){
                controller.validationBirthdate.value = "Tanggal Lahir tidak boleh kosong";
                return;
              }

              controller.currentStep.value += 1;

              controller.validationNama.value = "";
              controller.validationBirthdate.value = "";

              controller.pageController.value.animateToPage(controller.currentStep.value, curve: Curves.easeIn, duration: Duration(milliseconds: 500));
            }else {
              controller.registerAction();
            }
          }, textSize: fontSize(12), height: hValue(40)),
          hSpace(10),
          (controller.currentStep.value == 0) ?  Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "${Translator.alreadyHaveAccount.tr} ?",
                  style: regularTextFont.copyWith(color: Colors.black, fontSize: fontSize(12)),
                  children: <TextSpan>[
                    TextSpan(text: '${"login".tr}', style: regularTextFont.copyWith(color: colorAccent, fontSize: fontSize(12)),
                        recognizer: TapGestureRecognizer()..onTap = (){
                          onWillPop();
                        }),
                  ]
              ),
            ),
          ) :
          Button(Translator.back.tr, grey,  true, (){
            controller.currentStep.value = 0;
            controller.pageController.value.animateToPage(controller.currentStep.value, curve: Curves.easeIn, duration: Duration(milliseconds: 300));
          }, textSize: fontSize(12), height: hValue(40), fontColor: colorAccent),
        ],
      ),
    );
  }
  viewButtonFindEvent(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Button('Ya, Lengkapi Data', colorAccentDark,  true, (){
            // goToPage(MainScreen(), dismissAllPage: true);
            goToPage(VerifyScreen(from: key_register_page,), dismissAllPage: true);
          }, textSize: fontSize(12), height: hValue(40)),
          hSpace(10),
          Button('Nanti Saja', Colors.white,  true, (){
            // goToPage(LandingProfileScreen(from : key_register_page), dismissAllPage: true);
            goToPage(MainScreen(index : 2), dismissAllPage: true);
          }, fontColor: colorPrimaryDark, textSize: fontSize(12), height: hValue(40)),
        ],
      ),
    );
  }

  viewFirstStep(){
    return Column(
      children: [
        Container(
          child: Text(Translator.fullName.tr.tr, style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
          width: Get.width,
        ),
        SizedBox(height: hValue(5),),
        EditText(textInputType: TextInputType.text, validatorText: controller.validationNama.value, textInputAction: TextInputAction.next,  controller: controller.fullNameTxtController.value, hintText: "hint_full_name".tr,  onSubmit: (_){

        }),

        hSpace(15),
        Container(
          child: Text(Translator.birthdate.tr, style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
          width: Get.width,
        ),
        SizedBox(height: hValue(5),),
        EditText(textInputType: TextInputType.text, readOnly: true, leftIcon: "assets/icons/ic_date.svg", validatorText: controller.validationBirthdate.value, textInputAction: TextInputAction.done,  controller: controller.birthDateTxtController.value,
            hintText: Translator.hintBirthday.tr, onClick: () async {
          var selectedDate = await showDatePicker(context: context, initialDate: DateTime(DateTime.now().year - 17, DateTime.now().month, DateTime.now().day), firstDate: DateTime(DateTime.now().year - 99, 1, 1), lastDate: DateTime(DateTime.now().year - 5, 12, 29));
          controller.birthDateTxtController.value.text = "${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}";
        }),

        hSpace(15),
        Row(
          children: [
            InkWell(
              child: Row(
                children: [
                  SvgPicture.asset(controller.selectedGender.value == "L" ? "assets/icons/ic_select_radio.svg" : "assets/icons/ic_unselect_radio.svg", width: wValue(20),),
                  wSpace(5),
                  Text(Translator.male.tr, style: regularTextFont.copyWith(fontSize: fontSize(12)),)
                ],
              ),
              onTap: (){
                controller.selectedGender.value = "L";
              },
            ),
            wSpace(20),
            InkWell(
              child: Row(
                children: [
                  SvgPicture.asset(controller.selectedGender.value == "P" ? "assets/icons/ic_select_radio.svg" : "assets/icons/ic_unselect_radio.svg", width: wValue(20),),
                  wSpace(5),
                  Text(Translator.female.tr, style: regularTextFont.copyWith(fontSize: fontSize(12)),)
                ],
              ),
              onTap: (){
                controller.selectedGender.value = "P";
              },
            )
          ],
        )
      ],
    );
  }

  viewSecondStep(){
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
        }, validatorText: controller.validationEmail.value, textInputAction: TextInputAction.next,  controller: controller.emailTxtController.value, hintText: "hint_email".tr,  onSubmit: (_){

        }),

        hSpace(15),
        Container(
          child: Text("password".tr, style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
          width: Get.width,
        ),
        hSpace(5),
        EditText(textInputType: TextInputType.text, validatorText: controller.validationPass.value, rightIcon: controller.isShowPass.value ? "assets/icons/ic_hide_pass.svg" : "assets/icons/ic_show_pass.svg",
            onRightIconClicked: (){
              controller.isShowPass.value = !controller.isShowPass.value;
            }, textInputAction : TextInputAction.next, controller: controller.passwordTxtController.value, obsecureText: !controller.isShowPass.value, hintText: "hint_password".tr,  onSubmit: (_){

        }),

        hSpace(15),
        Container(
          child: Text("confirm".tr, style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
          width: Get.width,
        ),
        hSpace(5),
        EditText(textInputType: TextInputType.text, validatorText: controller.validationConfirmPass.value, rightIcon: controller.isShowConfirmPass.value ? "assets/icons/ic_hide_pass.svg" : "assets/icons/ic_show_pass.svg",
            onRightIconClicked: (){
              controller.isShowConfirmPass.value = !controller.isShowConfirmPass.value;
            }, textInputAction : TextInputAction.done, controller: controller.confirmPasswordTxtController.value, obsecureText: !controller.isShowConfirmPass.value, hintText: "hint_confirm_password".tr,  onSubmit: (_){

        }),
      ],
    );
  }

  viewCompleteRegister(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SvgPicture.asset("assets/img/img_success_register.svg"),
          hSpace(25),
          Text("Buat Akun", style: boldTextFont.copyWith(fontSize: fontSize(20), color: colorAccent), textAlign: TextAlign.center,),
          hSpace(10),
          Text("Akun Anda telah berhasil dibuat, namun belum terverifikasi. Silakan lengkapi data untuk dapat mengikuti berbagai event panahan.",
            style: regularTextFont.copyWith(fontSize: fontSize(12), color: Color(0xFF474747)), textAlign: TextAlign.center,),
          hSpace(15),
        ],
      ),
    );
  }

  viewCompleteRegisterOld(){
    return Column(
      children: [
        SvgPicture.asset("assets/img/img_success_register.svg"),
        hSpace(25),
        Text("Selamat Akun Anda\nberhasil dibuat", style: boldTextFont.copyWith(fontSize: fontSize(20), color: colorAccent), textAlign: TextAlign.center,),
        hSpace(10),
        Text("Yuk mulai ikuti berbagai event panahan!", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Color(0xFF474747)),),
        hSpace(15),
      ],
    );
  }
}
