import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/auth/forgot_pass/forgot_pass_controller.dart';
import 'package:myarcher_enterprise/ui/pages/auth/forgot_pass/forgot_pass_screen.dart';
import 'package:myarcher_enterprise/ui/pages/auth/login/login_controller.dart';
import 'package:myarcher_enterprise/ui/pages/auth/register/register_screen.dart';
import 'package:myarcher_enterprise/ui/shared/base_container.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/ui/shared/edittext.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/screen_util.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class LoginScreen extends StatefulWidget {
  final String? email;
  const LoginScreen({Key? key, this.email}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = LoginController();
  var forgotPassCtrl = ForgotPassController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if(widget.email != null){
      controller.emailC.value.text = widget.email!;
    }
    controller.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 360, height: 640, allowFontScaling: true)..init(context);

    return BaseContainer(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(wValue(25)),
        child: Column(
          children: [
            hSpace(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Translator.loginAccount.tr,
                    style: boldTextFont.copyWith(fontSize: fontSize(24))),
                Assets.images.logo.image(width: wValue(60)),
              ],
            ),

            Expanded(flex: 1,child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    hSpace(45),
                    Text(Translator.email.tr,
                        style: boldTextFont.copyWith(fontSize: fontSize(12))),
                    hSpace(5),
                    Obx(()=> EditText(
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: controller.emailC.value,
                        hintText: Translator.hintEmail.tr,
                        validatorText: controller.errorEmail.value == "" ? null : controller.errorEmail.value,
                        onChange: (String v){
                          if(v.isEmpty){
                            controller.errorEmail.value = Translator.emailMustFill.tr;
                          }else{
                            if(!GlobalHelper().isEmailValid(v)){
                              controller.errorEmail.value = Translator.emailFormatNotValid.tr;
                            }else{
                              controller.errorEmail.value = "";
                            }
                          }
                        }
                    )),

                    hSpace(15),
                    Text(Translator.password.tr,
                        style: boldTextFont.copyWith(fontSize: fontSize(12))),
                    hSpace(5),
                    Obx(()=> EditText(
                        textInputType: TextInputType.text,
                        rightIcon: controller.isShowPass.value
                            ? Assets.icons.icShowPass
                            : Assets.icons.icHidePass,
                        textInputAction: TextInputAction.done,
                        controller: controller.passC.value,
                        obsecureText: !controller.isShowPass.value,
                        hintText: Translator.hintPass.tr,
                        validatorText: controller.errorPass.value == "" ? null : controller.errorPass.value,
                        onRightIconClicked: (){
                          controller.isShowPass.value = !controller.isShowPass.value;
                        },
                        onChange: (String v){
                          controller.errorPass.value = (v.isEmpty) ? Translator.passwordMustFill.tr : "";
                        }
                    )),

                    hSpace(15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child : Text(Translator.forgotPassword.tr, style: boldTextFont.copyWith(fontSize: fontSize(12), color: AppColor.colorPrimary),),
                        onTap: (){
                          if(controller.emailC.value.text.isEmpty){
                            controller.errorEmail.value = Translator.emailMustFill.tr;
                            return;
                          }

                          forgotPassCtrl.apiForgotPass(
                              email: controller.emailC.value.text,
                              onFinish: (){
                                Get.to(()=> ForgotPassScreen(email: controller.emailC.value.text,));
                              });
                        },
                      ),
                    ),
                    hSpace(25),
                  ],
                ),
              ),
            ),),
            viewButtons()
          ],
        ),
      ),
    ));
  }

  viewButtons(){
    return Column(
      children: [
        hSpace(10),
        SizedBox(
          child: Button(
              title: Translator.login.tr,
              color: AppColor.colorAccent,
              enable: true,
              onClick: () {
                controller.loginAction();
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
                text: "${Translator.dontHaveAccount.tr} ? ",
                style: regularTextFont.copyWith(color: Colors.black, fontSize: fontSize(12)),
                children: <TextSpan>[
                  TextSpan(text: Translator.createAccount.tr, style: regularTextFont.copyWith(color: AppColor.colorPrimary, fontSize: fontSize(12)),
                      recognizer: TapGestureRecognizer()..onTap = (){
                        Get.to(()=> const RegisterScreen());
                      }),
                ]
            ),
          ),
        )
      ],
    );
  }
}
