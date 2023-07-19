import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/auth/forgot_pass/forgot_pass_controller.dart';
import 'package:myarcher_enterprise/ui/shared/base_container.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/ui/shared/dialog.dart';
import 'package:myarcher_enterprise/ui/shared/edittext.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPassScreen extends StatefulWidget {
  final String email;
  const ForgotPassScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> with SingleTickerProviderStateMixin{

  var controller = ForgotPassController();
  PageController pageController = PageController();

  @override
  void initState() {
    controller.email.value = widget.email;
    controller.initController();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterInit());
    super.initState();
  }

  afterInit() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          color: AppColor.colorAccent,
          child: BaseContainer(
            child: Obx(() => SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  padding: EdgeInsets.all(wValue(15)),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            hSpace(30),
                            Assets.images.logo.image(width: wValue(75)),
                            hSpace(15),
                            Text(controller.currentStep.value == 0 ? Translator.verifyCode.tr : Translator.createNewPassword.tr,
                                style: headingSmall),
                            Expanded(
                                child: SingleChildScrollView(
                                  child: controller.currentStep.value == 0
                                      ? viewFirstStep()
                                      : viewSecondStep(),
                                )),
                            viewButtons()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
          ),
        ));
  }

  Future<bool> onWillPop() async {
    Navigator.pop(context, true);
    return false;
  }

  viewButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Button(
            title : controller.currentStep.value == 0 ? Translator.verify.tr : Translator.save.tr,
            color : controller.isValid.value ? AppColor.colorAccent : AppColor.gray400,
            enable : controller.isValid.value, onClick:  () {
          if (controller.isValid.value) {
            printLog(msg: "index => ${controller.currentStep.value}");

            if (controller.currentStep.value == 0) {
              controller.apiValidate();
            } else if (controller.currentStep.value == 1) {
              controller.apiResetPass();
            }
          }
        },
            textSize: fontSize(12),
            fontColor: Colors.white,
            height: hValue(40)),
        hSpace(10),
        Button(title : Translator.cancel.tr, color : AppColor.grey, enable : true, onClick:  () {
          Get.back();
        },
            textSize: fontSize(12),
            height: hValue(40),
            fontColor: AppColor.colorAccent),
      ],
    );
  }

  viewFirstStep() {
    return SingleChildScrollView(
      physics:
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Container(
        margin: EdgeInsets.only(left: wValue(19), right: wValue(19)),
        child: Column(
          children: [
            hSpace(15),
            Text(
              Translator.inputCode.tr,
              style:
              textLgBold.copyWith(color: AppColor.gray600),
            ),
            hSpace(5),
            Text(
              "${Translator.codeWasSentToEmail.tr}\n${controller.email.value}",
              textAlign: TextAlign.center,
              style: textXsRegular.copyWith(color: AppColor.gray500),
            ),
            hSpace(28),
            PinCodeTextField(
              length: 5,
              obscureText: false,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 48,
                fieldWidth: 48,
                selectedColor: AppColor.colorAccent,
                inactiveColor: AppColor.grey,
                errorBorderColor: Colors.red,
                activeFillColor: Colors.white,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: false,
              controller: controller.pinController.value,
              onCompleted: (v) {
                controller.otpCode.value = v;
              },
              onChanged: (value) {
                controller.isValid.value = value.length >= 5;
                if (value.length < 5) {
                  controller.otpCode.value = "";
                }
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
              appContext: context,
            ),
            hSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Text(
                    Translator.resendOtp.tr,
                    style: boldTextFont.copyWith(
                        fontSize: fontSize(12),
                        color: controller.requestOtp.value < 3 &&
                            controller.countdown.value == 0
                            ? AppColor.colorAccent
                            : AppColor.gray400),
                  ),
                  onTap: () {
                    if (controller.countdown.value == 0) {
                      if (controller.requestOtp.value == 3) {
                        showConfirmDialog(context,
                            showIcon: true,
                            content: Translator.msgReachLimitSendOtp.tr,
                            assets: Assets.icons.icAlert,
                            typeAsset: "svg",
                            btn2: Translator.resend.tr, onClickBtn2: () {
                              controller.apiForgotPass(
                                email: widget.email,
                                onFinish: (){
                                  controller.resetTimer();
                                }
                              );
                            }, btn3: Translator.cancel.tr, onClickBtn3: () {});
                        return;
                      }
                      controller.requestOtp.value += 1;
                      controller.apiForgotPass(
                          email: widget.email,
                          onFinish: (){
                            controller.resetTimer();
                          }
                      );
                    }
                  },
                ),
                Text(
                  "00:${controller.countdown.value < 10 ? "0${controller.countdown.value}" : controller.countdown.value}",
                  style: regularTextFont.copyWith(
                      fontSize: fontSize(14), color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  viewSecondStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hSpace(15),
        SizedBox(
          width: Get.width,
          child: Text(
            Translator.newPass.tr,
            style: textSmRegular,
            textAlign: TextAlign.left,
          ),
        ),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            validatorText: controller.validationPass.value,
            rightIcon: controller.isShowPass.value
                ? Assets.icons.icHidePass
                : Assets.icons.icShowPass,
            onRightIconClicked: () {
              controller.isShowPass.value = !controller.isShowPass.value;
            },
            textInputAction: TextInputAction.done,
            controller: controller.newPassController.value,
            obsecureText: !controller.isShowPass.value,
            hintText: Translator.inputMin6Char.tr,
            onChange: (v) {
              if (v.toString().length < 6) {
                controller.validationPass.value = Translator.inputMin6Char.tr;
              } else {
                controller.validationPass.value = "";
                if (controller.confirmNewPassController.value.text != "") {
                  if (v.toString() !=
                      controller.confirmNewPassController.value.text) {
                    controller.validationConfirmPass.value =
                    Translator.passwordNotSame.tr;
                  }
                } else {
                  controller.validationConfirmPass.value = "";
                }
              }
            }),
        hSpace(15),
        SizedBox(
          width: Get.width,
          child: Text(
            Translator.confirmPass.tr,
            style: textSmRegular,
            textAlign: TextAlign.left,
          ),
        ),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            validatorText: controller.validationConfirmPass.value,
            rightIcon: controller.isShowConfirmPass.value
                ? Assets.icons.icHidePass
                : Assets.icons.icShowPass,
            onRightIconClicked: () {
              controller.isShowConfirmPass.value =
              !controller.isShowConfirmPass.value;
            },
            textInputAction: TextInputAction.done,
            controller: controller.confirmNewPassController.value,
            obsecureText: !controller.isShowConfirmPass.value,
            hintText: Translator.repeatPass.tr,
            onSubmit: (_) {},
            onChange: (v) {
              if (v.toString().length < 6) {
                controller.validationConfirmPass.value =
                Translator.inputMin6Char.tr;
              } else {
                controller.validationPass.value = "";
                if (controller.newPassController.value.text != v.toString()) {
                  controller.validationConfirmPass.value =
                  Translator.passwordNotSame.tr;
                } else {
                  controller.validationConfirmPass.value = "";
                }
              }
            }),
      ],
    );
  }
}
