import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/edittext.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';
import 'package:myarchery_archer/utils/translator.dart';
import 'package:path/path.dart';

import '../verify/verify_screen.dart';
import 'edit_profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  var controller = EditProfileController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    controller.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
        child: Obx(()=> Container(
          color: colorPrimary,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: appBar("Ubah Profil", (){
                Get.back();
              }),
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (controller.user.value.verifyStatus == KEY_VERIFY_ACC_VERIFIED) ? viewCardVerified() :  viewCardVerify(),
                      hSpace(15),
                      Text("Data Diri", style: boldTextFont.copyWith(fontSize: fontSize(18)),),
                      hSpace(20),
                      InkWell(
                        child: Stack(
                          children: [
                            circleAvatar("${controller.user.value.avatar}", wValue(100), hValue(100)),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withAlpha(50),
                              ),
                              width: wValue(100),
                              height: hValue(100),
                              child: Center(
                                child: SvgPicture.asset("assets/icons/ic_camera_circle.svg"),
                              ),
                            ),
                          ],
                        ),
                        onTap: (){
                          modalBottomChooseImage(onClick: (type) async {
                            XFile? image;
                            if(type == 1){
                              image = await _picker.pickImage(source: ImageSource.gallery);
                            }else{
                              image = await _picker.pickImage(source: ImageSource.camera);
                            }

                            cropImage(path: image!.path).then((value)  async {
                              var newPath = image!.path.replaceAll(basename(image.path), "compress_${basename(image.path)}");
                              var newFile = await compressFile(file: File(image.path), quality: 50, targetPath: newPath);
                              controller.apiUpdateAvatar(avatar: newFile, idUser: controller.user.value.id.toString());
                            });
                          });
                        },
                      ),
                      Container(
                        child: Text("Nama Lengkap", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
                        width: Get.width,
                        margin: EdgeInsets.only(top: hValue(25)),
                      ),
                      hSpace(5),
                      EditText(textInputType: TextInputType.text, readOnly: controller.user.value.verifyStatus == KEY_VERIFY_ACC_VERIFIED, textInputAction: TextInputAction.next,
                          controller: controller.nameTxtCtrl.value, hintText: Translator.hintFullName.tr, bgColor: gray50, borderColor: gray50,  onSubmit: (_){

                          }),
                      Container(
                        child: Text("Jenis Kelamin", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
                        width: Get.width,
                        margin: EdgeInsets.only(top: hValue(25)),
                      ),
                      hSpace(5),
                      Row(
                        children: [
                          InkWell(
                            child: Row(
                              children: [
                                SvgPicture.asset(controller.selectedGender.value == "L" ? "assets/icons/ic_select_radio.svg" : "assets/icons/ic_unselect_radio.svg", width: wValue(20),),
                                wSpace(5),
                                Text("Laki-Laki", style: regularTextFont.copyWith(fontSize: fontSize(12)),)
                              ],
                            ),
                            onTap: (){
                              if(controller.user.value.verifyStatus != KEY_VERIFY_ACC_VERIFIED){
                                controller.selectedGender.value = "L";
                              }
                            },
                          ),
                          wSpace(20),
                          InkWell(
                            child: Row(
                              children: [
                                SvgPicture.asset(controller.selectedGender.value == "P" ? "assets/icons/ic_select_radio.svg" : "assets/icons/ic_unselect_radio.svg", width: wValue(20),),
                                wSpace(5),
                                Text("Perempuan", style: regularTextFont.copyWith(fontSize: fontSize(12)),)
                              ],
                            ),
                            onTap: (){
                              if(controller.user.value.verifyStatus != KEY_VERIFY_ACC_VERIFIED) {
                                controller.selectedGender.value = "P";
                              }
                            },
                          )
                        ],
                      ),
                      hSpace(20),
                      Container(
                        child: Text("Tanggal Lahir", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
                        width: Get.width,
                      ),
                      hSpace(5),
                      SizedBox(height: hValue(5),),
                      EditText(textInputType: TextInputType.text, readOnly: true, textInputAction: TextInputAction.next,
                          onClick: () async {
                            if(controller.user.value.verifyStatus != KEY_VERIFY_ACC_VERIFIED){
                              var selectedDate = await showDatePicker(context: context,
                                  initialDate: controller.selectedDateBirth.value != "" ? DateTime.parse(controller.selectedDateBirth.value) : DateTime(DateTime.now().year - 5, 12, 29),
                                  firstDate: DateTime(DateTime.now().year - 99, 1, 1),
                                  lastDate: DateTime(DateTime.now().year - 5, 12, 29));
                              if(selectedDate != null) {
                                controller.selectedDateBirth.value = "${selectedDate.year}-${selectedDate.month.toString().length == 1 ? "0${selectedDate.month}" : selectedDate.month}-${selectedDate.day}";
                                controller.birthDateTxtCtrl.value.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                              }
                            }
                          },
                          leftIcon: "assets/icons/ic_date.svg",
                          controller: controller.birthDateTxtCtrl.value, bgColor: gray50, borderColor: gray50, hintText: "Isi Tanggal Lahir"),

                      hSpace(20),
                      Container(
                        child: Text("No. Telepon", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
                        width: Get.width,
                      ),
                      hSpace(5),
                      SizedBox(height: hValue(5),),
                      EditText(textInputType: TextInputType.number, readOnly: controller.user.value.verifyStatus == KEY_VERIFY_ACC_VERIFIED, textInputAction: TextInputAction.done,
                          leftIcon: "assets/icons/ic_phone.svg",
                          controller: controller.phoneTxtCtrl.value, bgColor: gray50, borderColor: gray50, hintText: "Isi Nomor Telepon",  onSubmit: (_){

                          }),
                      hSpace(20),
                      Button("Simpan", colorPrimary, true, (){
                        controller.apiUpdateProfile();
                      })
                    ],
                  ),
                  padding: EdgeInsets.all(wValue(15)),
                ),
              ),
            ),
          ),
        )),
    );
  }

  viewCardVerify(){
    return Card(
      child: Container(
        padding: EdgeInsets.all(wValue(15)),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/icons/ic_alert.svg", width: wValue(17),),
                wSpace(10),
                Text("Verifikasi Data", style: boldTextFont.copyWith(fontSize: fontSize(16), color: Colors.black),),
              ],
            ),
            hSpace(15),
            Text("${controller.contentStatusVerify.value}", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black), ),
            hSpace(15),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: gray100,
              ),
              padding: EdgeInsets.all(wValue(7)),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/ic_info_white.svg"),
                  wSpace(10),
                  Text("${controller.user.value.statusVerify}", style: regularTextFont.copyWith(fontSize: fontSize(12), color: controller.user.value.verifyStatus == KEY_VERIFY_ACC_REJECTED ? Colors.red : Colors.black,),)
                ],
              ),
            ),
            hSpace(10),
            Button("${controller.btnStatusVerify.value}", colorPrimary, true, () async {
              if(controller.user.value.verifyStatus == KEY_VERIFY_ACC_REJECTED || controller.user.value.verifyStatus == KEY_VERIFY_ACC_UNVERIFIED){
                final result = await goToPageWithResult(VerifyScreen());
                if(result != null){
                  controller.apiProfile();
                }
              }else if(controller.user.value.verifyStatus == KEY_VERIFY_ACC_SENT){
                modalBottomReviewVerifyData(controller.user.value);
              }
            })
          ],
        ),
      ),
    );
  }

  viewCardVerified(){
    return Card(
      child: Container(
        padding: EdgeInsets.all(wValue(15)),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/icons/ic_check_green.svg", width: wValue(17),),
                wSpace(10),
                Text("Verifikasi Data", style: boldTextFont.copyWith(fontSize: fontSize(16), color: Colors.black),),
              ],
            ),
            hSpace(15),
            Text("${controller.contentStatusVerify.value}", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black), ),
            hSpace(15),
            Container(
              width: Get.width,
              child: Align(child: InkWell(
                child: Text("Lihat Detail", style: boldTextFont.copyWith(fontSize: fontSize(13), color: colorPrimary),),
                onTap: (){
                  modalBottomReviewVerifyData(controller.user.value);
                },
              ),
                alignment: Alignment.centerRight,),
            ),
          ],
        ),
      ),
    );
  }
}

