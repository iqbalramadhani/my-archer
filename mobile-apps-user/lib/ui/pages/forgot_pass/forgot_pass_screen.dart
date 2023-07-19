import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/dialog.dart';
import 'package:myarchery_archer/ui/shared/edittext.dart';
import 'package:myarchery_archer/utils/translator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'forgot_pass_controller.dart';

class ForgotPassScreen extends StatefulWidget {
  final String email;

  const ForgotPassScreen({Key? key, required this.email}) : super(key: key);

  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen>
    with SingleTickerProviderStateMixin {
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
        child: Container(
          color: colorAccent,
          child: BaseContainer(
            child: Obx(() => SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/bg_login.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Text(Translator.resetOtp.tr,
                                style: boldTextFont.copyWith(
                                    fontSize: fontSize(24),
                                    color: Colors.white)),
                            margin: EdgeInsets.only(top: hValue(40)),
                          ),
                          Expanded(
                            child: Container(
                              width: Get.width,
                              height: Get.height,
                              padding: EdgeInsets.all(wValue(25)),
                              margin: EdgeInsets.only(top: hValue(28)),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: SingleChildScrollView(
                                        child: controller.currentStep.value == 0
                                            ? viewFirstStep()
                                            : controller.currentStep.value == 1
                                            ? viewSecondStep()
                                            : viewThirdStep(),
                                      )),
                                  viewButtons()
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(24),
                                    topLeft: Radius.circular(24)),
                                color: Colors.white,
                              ),
                            ),
                            flex: 1,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
          ),
        ),
        onWillPop: onWillPop);
  }

  Future<bool> onWillPop() async {
    Navigator.pop(context, true);
    return false;
  }

  viewButtons() {
    return (controller.currentStep.value == 2)
        ? Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Button(Translator.login.tr, colorAccentDark, true, () {
                  Get.back();
                },
                    textSize: fontSize(12),
                    fontColor: Colors.white,
                    height: hValue(40)),
              ],
            ),
          )
        : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Button(
                    controller.currentStep.value == 0 ? Translator.verify.tr : Translator.save.tr,
                    controller.isValid.value ? colorAccentDark : gray400,
                    controller.isValid.value, () {
                  if (controller.isValid.value) {
                    printLog(msg: "index => ${controller.currentStep.value}");

                    if (controller.currentStep.value == 0)
                      controller.apiValidate();
                    else if (controller.currentStep.value == 1) {
                      controller.apiResetPass();
                    }
                  }
                },
                    textSize: fontSize(12),
                    fontColor: Colors.white,
                    height: hValue(40)),
                hSpace(10),
                Button(Translator.cancel.tr, grey, true, () {
                  Get.back();
                },
                    textSize: fontSize(12),
                    height: hValue(40),
                    fontColor: colorAccent),
              ],
            ),
          );
  }

  viewFirstStep() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            hSpace(15),
            Text(
              Translator.inputCode.tr,
              style:
                  boldTextFont.copyWith(fontSize: fontSize(20), color: gray600),
            ),
            hSpace(12),
            Text(
              "Kode telah dikirimkan ke email ${controller.email.value}",
              textAlign: TextAlign.center,
              style: regularTextFont.copyWith(
                  fontSize: fontSize(12), color: gray500),
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
                selectedColor: colorAccent,
                inactiveColor: grey,
                errorBorderColor: Colors.red,
                activeFillColor: Colors.white,
              ),
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: false,
              // errorAnimationController: errorController,
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
                            ? colorAccent
                            : gray400),
                  ),
                  onTap: () {
                    if (controller.countdown.value == 0) {
                      if (controller.requestOtp.value == 2) {
                        showConfirmDialog(context,
                            showIcon: true,
                            content:
                                "Batas kirim ulang kode per hari akan mencapai maksimal. Kirim ulang?",
                            assets: "assets/icons/ic_alert.svg",
                            btn2: "Kirim Ulang", onClickBtn2: () {
                          controller.apiForgotPass();
                        }, btn3: "Batalkan", onClickBtn3: () {});
                        return;
                      }
                      controller.requestOtp.value += 1;
                      controller.apiForgotPass();
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
        margin: EdgeInsets.only(left: wValue(19), right: wValue(19)),
      ),
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    );
  }

  viewSecondStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hSpace(10),
        Image.asset(
          "assets/img/logo.png",
          width: wValue(64),
        ),
        hSpace(24),
        Text(
          Translator.createNewPassword.tr,
          style: boldTextFont.copyWith(fontSize: fontSize(24)),
        ),
        hSpace(15),
        Container(
          child: Text(
            Translator.newPass.tr,
            style: regularTextFont.copyWith(
                fontSize: fontSize(14)),
            textAlign: TextAlign.left,
          ),
          width: Get.width,
        ),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            validatorText: controller.validationPass.value,
            rightIcon: controller.isShowPass.value
                ? "assets/icons/ic_hide_pass.svg"
                : "assets/icons/ic_show_pass.svg",
            onRightIconClicked: () {
              controller.isShowPass.value = !controller.isShowPass.value;
            },
            textInputAction: TextInputAction.done,
            controller: controller.newPassController.value,
            obsecureText: !controller.isShowPass.value,
            hintText: Translator.inputMin6Char.tr,
            onChange: (v) {
              if (v.toString().length < 6) {
                controller.validationPass.value = "Kata sandi min 6 Karakter";
              } else {
                controller.validationPass.value = "";
                if (controller.confirmNewPassController.value.text != "") {
                  if (v.toString() !=
                      controller.confirmNewPassController.value.text)
                    controller.validationConfirmPass.value =
                        "Kata sandi tidak sama";
                } else {
                  controller.validationConfirmPass.value = "";
                }
              }
            }),
        hSpace(15),
        Container(
          child: Text(
            Translator.confirmNewPass.tr,
            style: regularTextFont.copyWith(
                fontSize: fontSize(14)),
            textAlign: TextAlign.left,
          ),
          width: Get.width,
        ),
        hSpace(5),
        EditText(
            textInputType: TextInputType.text,
            validatorText: controller.validationConfirmPass.value,
            rightIcon: controller.isShowConfirmPass.value
                ? "assets/icons/ic_hide_pass.svg"
                : "assets/icons/ic_show_pass.svg",
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
                    "Kata sandi min 6 Karakter";
              } else {
                controller.validationPass.value = "";
                if (controller.newPassController.value.text != v.toString()) {
                  controller.validationConfirmPass.value =
                      "Kata sandi tidak sama";
                } else {
                  controller.validationConfirmPass.value = "";
                }
              }
            }),
      ],
    );
  }

  viewThirdStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        hSpace(45),
        Image.asset("assets/img/img_unlock.png"),
        hSpace(24),
        Text(
          "Selamat kata sandi Anda berhasil diubah",
          style:
              boldTextFont.copyWith(fontSize: fontSize(20), color: colorAccent),
          textAlign: TextAlign.center,
        ),
        hSpace(12),
        Text(
          "Yuk sekarang coba masuk",
          style: regularTextFont.copyWith(fontSize: fontSize(14), color: gray600), textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
