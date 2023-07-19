import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myarchery_archer/ui/pages/profile/edit_profile/edit_profile_controller.dart';
import 'package:myarchery_archer/ui/pages/profile/verify/verify_controller.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/edittext.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:path/path.dart';

import '../../../../core/models/objects/region_model.dart';
import '../../../../utils/key_storage.dart';
import '../../main/main_screen.dart';
import '../../main/profile/profile_controller.dart';

class VerifyScreen extends StatefulWidget {
  final from;
  const VerifyScreen({Key? key, this.from}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {

  var controller = VerifyController();
  var profileController = ProfileController();
  var editProfileController = EditProfileController();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    profileController.apiProfile(
      onFinish: (){
        controller.getCurrentData();
      }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Container(
        color: colorPrimary,
        child: WillPopScope(
          child: SafeArea(
            child: Obx(()=> Scaffold(
              backgroundColor: Colors.white,
              appBar: appBar("Verifikasi Data", (){
                onWillPop();
              }),
              body: SingleChildScrollView(
                child: Padding(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Verifikasi", style: boldTextFont.copyWith(fontSize: fontSize(16), color: Colors.black),),
                      hSpace(15),
                      Center(
                        child: InkWell(
                          child: Stack(
                            children: [
                              circleAvatar("${controller.user.value.avatar}", wValue(100), hValue(100)),
                              if(controller.user.value.avatar == null || controller.user.value.avatar == "") Container(
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
                                editProfileController.apiUpdateAvatar(avatar: newFile, idUser: controller.user.value.id.toString());
                              });
                            });
                          },
                        ),
                      ),
                      hSpace(5),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: gray50,
                        ),
                        padding: EdgeInsets.all(wValue(15)),
                        child: Text("Unggah foto Anda dengan ukuran 4x3, min. besar file 500kb, format PNG/JPEG untuk keperluan berkas cetak (ID card, dsb)", style: regularTextFont.copyWith(fontSize: fontSize(12), color: gray500),),
                      ),
                      Container(
                        child: Text("Nama Lengkap", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
                        width: Get.width,
                        margin: EdgeInsets.only(top: hValue(25)),
                      ),
                      hSpace(5),
                      EditText(textInputType: TextInputType.text, readOnly: true, textInputAction: TextInputAction.next,
                          controller: controller.nameTxtCtrl.value, hintText: "hint_full_name".tr, bgColor: gray50, borderColor: gray50,  onSubmit: (_){

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
                              // controller.selectedGender.value = "L";
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
                              // controller.selectedGender.value = "P";
                            },
                          )
                        ],
                      ),
                      Container(
                        child: Text("Tanggal Lahir", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
                        width: Get.width,
                        margin: EdgeInsets.only(top: hValue(25)),
                      ),
                      hSpace(5),
                      SizedBox(height: hValue(5),),
                      EditText(textInputType: TextInputType.text, readOnly: true, textInputAction: TextInputAction.next,
                          onClick: () async {
                            // var selectedDate = await showDatePicker(context: context, initialDate: DateTime.parse(controller.selectedDateBirth.value), firstDate: DateTime(DateTime.now().year - 99, 1, 1), lastDate: DateTime(DateTime.now().year - 5, 12, 29));
                            // controller.selectedDateBirth.value = "${selectedDate?.year}-${selectedDate?.month.toString().length == 1 ? "0${selectedDate?.month}" : selectedDate?.month}-${selectedDate?.day}";
                            // controller.birthDateTxtCtrl.value.text = "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}";
                          },
                          leftIcon: "assets/icons/ic_date.svg",
                          controller: controller.birthDateTxtCtrl.value, bgColor: gray50, borderColor: gray50, hintText: "Isi Tanggal Lahir"),

                      Container(
                        child: Text("NIK", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
                        width: Get.width,
                        margin: EdgeInsets.only(top: hValue(25)),
                      ),
                      hSpace(5),
                      SizedBox(height: hValue(5),),
                      EditText(textInputType: TextInputType.number, validatorText: controller.errorNik.value, textInputAction: TextInputAction.next,
                          onChange: (v){
                            controller.validating();
                          },
                          controller: controller.nikTxtCtrl.value, bgColor: gray50, borderColor: gray50, hintText: "Isi NIK Sesuai KTP anda"),

                      Container(
                        child: Text("Alamat (Sesuai dengan KTP/KK)", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
                        width: Get.width,
                        margin: EdgeInsets.only(top: hValue(25)),
                      ),
                      hSpace(5),
                      SizedBox(height: hValue(5),),
                      EditText(textInputType: TextInputType.text, validatorText: controller.errorAddress.value, textInputAction: TextInputAction.next,
                          onChange: (v){
                            controller.validating();
                          },
                          controller: controller.addressTxtCtrl.value, bgColor: gray50, borderColor: gray50, hintText: "Isi Alamat Sesuai KTP Anda"),

                      Container(
                        child: Text("Provinsi/Wilayah (Sesuai dengan KTP)", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
                        width: Get.width,
                        margin: EdgeInsets.only(top: hValue(25)),
                      ),
                      hSpace(5),
                      EditText(hintText: "--Pilih Provinsi--", readOnly: true, bgColor: gray50, borderColor: gray50,  validatorText: controller.errorProvince.value, controller: controller.provTxtCtrl.value, rightIcon: "assets/icons/ic_arrow_down.svg", onClick: (){
                        modalBottomProvince(onItemSelected: (item){
                          controller.selectedProvince.value = item;
                          controller.provTxtCtrl.value.text = item.name;
                          controller.selectedCity.value = RegionModel();
                          controller.cityTxtCtrl.value.text = "";
                          controller.validating();
                        });
                      }),

                      Container(
                        child: Text("Kota", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
                        width: Get.width,
                        margin: EdgeInsets.only(top: hValue(25)),
                      ),
                      hSpace(5),
                      EditText(hintText: "--Pilih Kota--", readOnly: true, validatorText: controller.errorCity.value, controller: controller.cityTxtCtrl.value, bgColor: gray50, borderColor: gray50,  rightIcon: "assets/icons/ic_arrow_down.svg", onClick: (){
                        if(controller.selectedProvince.value.id == null){
                          errorToast(msg: "Harap pilih Provinsi terlebih dahulu");
                          return;
                        }
                        modalBottomCity(idProvince: controller.selectedProvince.value.id.toString(), onItemSelected: (item){
                          controller.selectedCity.value = item;
                          controller.cityTxtCtrl.value.text = controller.selectedCity.value.name!;
                          controller.validating();
                        });
                      }),

                      Container(
                        child: Text("Foto KTP/KK", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
                        width: Get.width,
                        margin: EdgeInsets.only(top: hValue(25)),
                      ),
                      hSpace(5),
                      Container(
                        padding: EdgeInsets.all(wValue(15)),
                        color: blue50,
                        child: InkWell(
                          child: (controller.selectedKtpPhoto.value.isEmpty ? viewStatePhotoEmpty() : viewStatePhotoPicked(photo: File(controller.selectedKtpPhoto.value))),
                          onTap: (){
                            modalBottomChooseImage(onClick: (type) async {
                              XFile? image;
                              if(type == 1){
                                image = await _picker.pickImage(source: ImageSource.gallery);
                              }else{
                                image = await _picker.pickImage(source: ImageSource.camera);
                              }

                              var newPath = image!.path.replaceAll(basename(image.path), "compress_${basename(image.path)}");
                              var newFile = await compressFile(file: File(image.path), targetPath: newPath);
                              controller.selectedKtpPhoto.value = newFile.path;
                              controller.validating();
                            });
                          },
                        ),
                        width: Get.width,
                      ),
                      if(controller.errorKtp.value.isNotEmpty) Text("${controller.errorKtp.value}", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.red),),

                      // Container(
                      //   child: Text("Foto Selfie dengan KTP/KK", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.left,),
                      //   width: Get.width,
                      //   margin: EdgeInsets.only(top: hValue(25)),
                      // ),
                      // hSpace(5),
                      // Container(
                      //   padding: EdgeInsets.all(wValue(15)),
                      //   color: blue50,
                      //   child: InkWell(
                      //     child: (controller.selectedSelfiePhoto.value.isEmpty ? viewStatePhotoEmpty() : viewStatePhotoPicked(photo: File(controller.selectedSelfiePhoto.value))),
                      //     onTap: (){
                      //       modalBottomChooseImage(onClick: (type) async {
                      //         XFile? image;
                      //         if(type == 1){
                      //           image = await _picker.pickImage(source: ImageSource.gallery);
                      //         }else{
                      //           image = await _picker.pickImage(source: ImageSource.camera);
                      //         }
                      //
                      //         var newPath = image!.path.replaceAll(basename(image.path), "compress_${basename(image.path)}");
                      //         var newFile = await compressFile(file: File(image.path), targetPath: newPath);
                      //         controller.selectedSelfiePhoto.value = newFile.path;
                      //         controller.validating();
                      //       });
                      //     },
                      //   ),
                      //   width: Get.width,
                      // ),
                      // if(controller.errorSelfie.value.isNotEmpty) Text("${controller.errorSelfie.value}", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.red),),

                      hSpace(20),
                      Button("Kirim", controller.btnIsValid.value ? colorPrimary : gray400, controller.btnIsValid.value, (){
                        if(controller.btnIsValid.value){
                          modalBottomAlertDialog(title: "Verifikasi Akun", typeAsset: "png", image: "assets/img/img_recheck.png",  content: "Apakah anda yakin data sudah benar?", btnPos: "Sudah Benar", btnNeg: "Cek Kembali",
                              btnPosClicked: (){
                                controller.apiSendVerifyReq();
                              }, btnNegClicked: (){});
                        }
                      })

                    ],
                  ),
                  padding: EdgeInsets.all(wValue(25)),
                ),
              ),
            )),
          ),
          onWillPop: onWillPop,
        ),
      ),
    );
  }

  viewStatePhotoEmpty(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/icons/ic_camera_circle.svg"),
        hSpace(10),
        Text("Unggah Foto/\nGambar PNG/\nJPEG", style: regularTextFont.copyWith(fontSize: fontSize(12)), textAlign: TextAlign.center,)
      ],
    );
  }

  viewStatePhotoPicked({required File photo}){
    return Image.file(photo);
  }

  Future<bool> onWillPop() async {
    modalBottomAlertDialog(title: "Verifikasi Akun", typeAsset: "png", image: "assets/img/img_recheck.png",  content: "Apakah Anda yakin akan membatalkan proses verifikasi Data?", btnPos: "Tidak, Lanjutkan Isi Data", btnNeg: "Ya, Kembali ke atur profil",
        btnPosClicked: (){

        }, btnNegClicked: (){
          if(widget.from != null && widget.from == key_register_page){
            goToPage(MainScreen(), dismissAllPage: true);
          }else{
            Navigator.pop(Get.context!, true);
          }
        });

    // showConfirmDialog(Get.context!, content: "Apakah Anda yakin akan membatalkan proses verifikasi Data?", btn1: "Iya", btn3: "Tidak", onClickBtn1: (){
    //   if(widget.from != null && widget.from == key_register_page){
    //     goToPage(MainScreen(), dismissAllPage: true);
    //   }else{
    //     Navigator.pop(Get.context!, true);
    //   }
    // }, onClickBtn3: (){});
    return true;
  }
}
