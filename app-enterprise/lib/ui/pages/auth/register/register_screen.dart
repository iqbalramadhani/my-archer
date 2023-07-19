import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/core/models/objects/region_model.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/auth/register/register_controller.dart';
import 'package:myarcher_enterprise/ui/shared/base_container.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/ui/shared/dialog.dart';
import 'package:myarcher_enterprise/ui/shared/edittext.dart';
import 'package:myarcher_enterprise/ui/shared/loading.dart';
import 'package:myarcher_enterprise/ui/shared/modal_bottom.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/generated_data.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();
  var controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(wValue(25)),
            child: WillPopScope(
              onWillPop: onWillPop,
              child: Obx(()=> Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 1,child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: Form(
                      child: setForm(),
                      key: _formKey,
                    ),
                  ),),
                  viewButtons()
                ],
              )),
            ),
          ),
        ));
  }

  Future<bool> onWillPop() async {
    if(controller.stateView.value > 0){
      controller.stateView.value -= 1;
    }else{
      Get.back();
    }
    return false;
  }

  _viewStep1(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hSpace(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Translator.createAccount.tr,
                style: boldTextFont.copyWith(fontSize: fontSize(24))),
            Assets.images.logo.image(width: wValue(60)),
          ],
        ),
        hSpace(30),
        Text(Translator.nameBusiness.tr,
            style: boldTextFont.copyWith(fontSize: fontSize(12))),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: controller.nameC.value,
            hintText: Translator.hintName.tr,
            validatorText: controller.errorName.value == "" ? null : controller.errorName.value,
            onChange: (String v){
              controller.errorName.value = (v.isEmpty) ? Translator.nameMustFill.tr : "";
            }
        ),


        hSpace(15),
        Text(Translator.emailBusiness.tr,
            style: boldTextFont.copyWith(fontSize: fontSize(12))),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: controller.emailC.value,
            hintText: Translator.hintEmailRegister.tr,
            validatorText: controller.errorEmail.value == "" ? null : controller.errorEmail.value,
            onChange: (String v){
              if(v.isEmpty){
                controller.errorEmail.value = Translator.emailMustFill.tr;
              }else{
                if(!GlobalHelper().isEmailValid(v)){
                  controller.errorEmail.value = Translator.emailFormatNotValid.tr;
                }else{
                  controller.errorEmail.value = "";
                  Timer(const Duration(milliseconds: 700), () {
                    controller.apiCheckEmail(email: v);
                  });
                }
              }
            }
        ),
        if(controller.isLoadingCheck.value) Row(
          children: [
            loading(),
            wSpace(5),
            Text("Mengecek Email", style: textBaseRegular,)
          ],
        ),


        hSpace(15),
        Text(Translator.phoneNumberBusiness.tr,
            style: boldTextFont.copyWith(fontSize: fontSize(12))),
        hSpace(5),
        EditText(
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            controller: controller.phoneC.value,
            hintText: Translator.hintPhoneNumber.tr,
            validatorText: controller.errorPhone.value == "" ? null : controller.errorPhone.value,
            onChange: (String v){
              controller.errorPhone.value = (v.isEmpty) ? Translator.phoneMustFill.tr : "";
            }
        ),

        hSpace(15),
        Text(Translator.password.tr, style: boldTextFont.copyWith(fontSize: fontSize(12))),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            rightIcon: controller.isShowPass.value
                ? Assets.icons.icShowPass
                : Assets.icons.icHidePass,
            textInputAction: TextInputAction.next,
            controller: controller.passC.value,
            obsecureText: !controller.isShowPass.value,
            hintText: Translator.hintPass.tr,
            onRightIconClicked: (){
              controller.isShowPass.value = !controller.isShowPass.value;
            },
            validatorText: controller.errorPass.value == "" ? null : controller.errorPass.value,
            onChange: (String v){
              if(v.isEmpty){
                controller.errorPass.value = Translator.passwordMustFill.tr;
              }else{
                if(controller.confirmPassC.value.text.isNotEmpty){
                  controller.errorPass.value = (controller.passC.value.text != controller.confirmPassC.value.text) ? Translator.passwordNotSame.tr : "";
                }else{
                  controller.errorPass.value = "";
                }
              }
            }
        ),

        hSpace(15),
        Text(Translator.confirmPass.tr, style: boldTextFont.copyWith(fontSize: fontSize(12))),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            rightIcon: controller.isShowConfirmPass.value
                ? Assets.icons.icShowPass
                : Assets.icons.icHidePass,
            textInputAction: TextInputAction.done,
            controller: controller.confirmPassC.value,
            obsecureText: !controller.isShowConfirmPass.value,
            hintText: Translator.hintConfirmPass.tr,
            onRightIconClicked: (){
              controller.isShowConfirmPass.value = !controller.isShowConfirmPass.value;
            },
            validatorText: controller.errorConfirmPass.value == "" ? null : controller.errorConfirmPass.value,
            onChange: (String v){
              if(v.isEmpty){
                controller.errorConfirmPass.value = Translator.confirmPassMustFill.tr;
              }else{
                if(controller.passC.value.text.isNotEmpty) {
                  controller.errorConfirmPass.value =
                  (controller.passC.value.text !=
                      controller.confirmPassC.value.text) ? Translator
                      .passwordNotSame.tr : "";
                }else{
                  controller.errorPass.value = "";
                }
              }
            }
        ),
        hSpace(25),
      ],
    );
  }

  _viewStep2(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hSpace(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Translator.createAccount.tr,
                style: boldTextFont.copyWith(fontSize: fontSize(24))),
            Assets.images.logo.image(width: wValue(60)),
          ],
        ),
        hSpace(30),

        Text(Translator.province.tr,
            style: boldTextFont.copyWith(fontSize: fontSize(12))),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: controller.provinceC.value,
            hintText: Translator.chooseProvince.tr,
            readOnly: true,
            rightIcon: Assets.icons.icArrowDown,
            onClick: (){
              modalBottomProvince(onItemSelected: (item){
                controller.selectedProvince.value = item;
                controller.provinceC.value.text = item.name;
                controller.selectedCity.value = RegionModel();
                controller.cityC.value.text = "";
                controller.errorProvince.value = "";
              });
            },
            validatorText: controller.errorProvince.value == "" ? null : controller.errorProvince.value,
            onChange: (String v){
              controller.errorProvince.value = (v.isEmpty) ? Translator.provinceMustFill.tr : "";
            }
        ),

        hSpace(15),
        Text(Translator.city.tr,
            style: boldTextFont.copyWith(fontSize: fontSize(12))),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: controller.cityC.value,
            hintText: Translator.chooseCity.tr,
            rightIcon: Assets.icons.icArrowDown,
            readOnly: true,
            onClick: (){
              modalBottomCity(idProvince: controller.selectedProvince.value.id.toString(), onItemSelected: (item){
                controller.selectedCity.value = item;
                controller.cityC.value.text = controller.selectedCity.value.name!;
                controller.errorCity.value = "";
              });
            },
            validatorText: controller.errorCity.value == "" ? null : controller.errorCity.value,
            onChange: (String v){
              controller.errorCity.value = (v.isEmpty) ? Translator.cityMustFill.tr : "";
            }
        ),

        hSpace(15),
        Text(Translator.whereKnowMyArchery.tr,
            style: boldTextFont.copyWith(fontSize: fontSize(12))),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            rightIcon: Assets.icons.icArrowDown,
            onClick: (){
              modalBottomDynamicAction(actions: GeneratedData().sourceInformation(), onItemSelected: (item){
                if(item.toString().toLowerCase() == "lainnya"){
                  showInputWordDialog(onSubmit: (data){
                    controller.whereKnowC.value.text = data;
                  });
                }else{
                  controller.whereKnowC.value.text = item;
                }
              });
            },
            readOnly: true,
            textInputAction: TextInputAction.next,
            controller: controller.whereKnowC.value,
            hintText: Translator.chooseOption.tr,
            validatorText: controller.errorWhere.value == "" ? null : controller.errorWhere.value,
        ),


        hSpace(15),
        Text(Translator.whyUseMyArchery.tr, style: boldTextFont.copyWith(fontSize: fontSize(12))),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: controller.whyUseC.value,
            hintText: Translator.whyUseMyArchery.tr,
            validatorText: controller.errorWhy.value == "" ? null : controller.errorWhy.value,
            onChange: (String v){
              controller.errorWhy.value = (v.isEmpty) ? Translator.cantEmpty.tr : "";
            }
        ),

        hSpace(15),
        Text(Translator.whatActivityHeld.tr, style: boldTextFont.copyWith(fontSize: fontSize(12))),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: controller.activityUsuallC.value,
            hintText: Translator.hintActivityUsuall.tr,
            validatorText: controller.errorWhatUsuall.value == "" ? null : controller.errorWhatUsuall.value,
            onChange: (String v){
              controller.errorWhatUsuall.value = (v.isEmpty) ? Translator.cantEmpty.tr : "";
            }
        ),

        hSpace(15),
        Text(Translator.whatNearbyEvent.tr, style: boldTextFont.copyWith(fontSize: fontSize(12))),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: controller.activityNearbyC.value,
            hintText: Translator.mentionNameActivity.tr,
            validatorText: controller.errorWhatNearby.value == "" ? null : controller.errorWhatNearby.value,
            onChange: (String v){
              controller.errorWhatNearby.value = (v.isEmpty) ? Translator.cantEmpty.tr : "";
            }
        ),

        hSpace(15),
        Text(Translator.descActivityHeld.tr, style: boldTextFont.copyWith(fontSize: fontSize(12))),
        hSpace(5),
        EditText(
            textInputType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: 4,
            contentPadding: EdgeInsets.symmetric(horizontal: wValue(10), vertical: hValue(10)),
            controller: controller.descActivityC.value,
            hintText: Translator.inputShortDesc.tr,
            validatorText: controller.errorDescNearby.value == "" ? null : controller.errorDescNearby.value,
            onChange: (String v){
              controller.errorDescNearby.value = (v.isEmpty) ? Translator.cantEmpty.tr : "";
            }
        ),
      ],
    );
  }

  setForm(){
    if(controller.stateView.value == 0){
      return _viewStep1();
    }else if(controller.stateView.value == 1){
      return _viewStep2();
    }
  }

  viewButtons(){
    return Column(
      children: [
        hSpace(10),
        SizedBox(
          child: Button(
              title: (controller.stateView.value == 1) ? Translator.createAccount.tr : Translator.next.tr,
              color: AppColor.colorAccent,
              enable: true,
              onClick: () {
                if(controller.isValid()){
                  if(controller.stateView.value < 1){
                    controller.stateView.value += 1;
                    GlobalHelper().closeKeyboard(context);
                  }else{
                    controller.apiRegister();
                  }
                }
              },
              textSize: fontSize(12),
              height: hValue(40)),
          width: Get.width,
        ),
        hSpace(10),
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "${Translator.alreadyHaveAccount.tr} ? ",
                style: regularTextFont.copyWith(color: Colors.black, fontSize: fontSize(12)),
                children: <TextSpan>[
                  TextSpan(text: Translator.login.tr, style: regularTextFont.copyWith(color: AppColor.colorPrimary, fontSize: fontSize(12)),
                      recognizer: TapGestureRecognizer()..onTap = (){
                        Get.back();
                      }),
                ]
            ),
          ),
        )
      ],
    );
  }
}
