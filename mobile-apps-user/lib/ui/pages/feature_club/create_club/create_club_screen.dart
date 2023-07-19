import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/edittext.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';

import '../../../../core/models/objects/club_model.dart';
import '../../../../core/models/objects/region_model.dart';
import '../../my_club_screen/my_club_controller.dart';
import '../detail_club/detail_club_screen.dart';
import 'create_club_controller.dart';

class CreateClubScreen extends StatefulWidget {
  final DetailClubModel? currentData;
  const CreateClubScreen({Key? key, this.currentData}) : super(key: key);

  @override
  _CreateClubScreenState createState() => _CreateClubScreenState();
}

class _CreateClubScreenState extends State<CreateClubScreen> {
  final ImagePicker _picker = ImagePicker();
  var controller = CreateClubController();
  var clubController = MyClubController();

  @override
  void initState() {
    if(widget.currentData != null){
      controller.currentData.value = widget.currentData!;
    }

    controller.initController();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<CreateClubController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: BaseContainer(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: gray50,
            appBar: appBar("Klub Saya", (){
              Get.back();
            }, bgColor: colorAccent, textColor: Colors.white, iconColor: Colors.white),
            body: Obx(()=> controller.isSuccess.value ? viewSuccess() : viewForm()),
          ),
        ),
      ),
    );
  }

  viewForm(){
    return Column(
      children: [
        Expanded(child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              Container(
                height: hValue(190),
                child: Stack(
                  children: [
                    InkWell(
                      child: Container(
                        color: Color(0xFFD4E2FC),
                        child: Stack(
                          children: [
                            if(controller.selectedBanner.value.path != "") Container(
                              child: Stack(
                                children: [
                                  Image.file(File(controller.selectedBanner.value.path), fit: BoxFit.cover, width: Get.width, height: hValue(133),),
                                  Container(
                                    width: Get.width,
                                    height: hValue(133),
                                    color: Colors.black.withAlpha(57),
                                  )
                                ],
                              ),
                            ),
                            if(controller.selectedBanner.value.path == "" && (widget.currentData != null && controller.currentBanner.value.isNotEmpty)) Container(
                              child: Stack(
                                children: [
                                  Image.network(widget.currentData!.banner!, fit: BoxFit.cover, width: Get.width, height: hValue(133),),
                                  Container(
                                    width: Get.width,
                                    height: hValue(133),
                                    color: Colors.black.withAlpha(57),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/ic_camera_circle.svg"),
                                  hSpace(5),
                                  if(controller.selectedBanner.value.path == "" && (widget.currentData != null &&  controller.currentBanner.value.isNotEmpty)) Text("Banner", style: regularTextFont.copyWith(fontSize: fontSize(10)),),
                                ],
                              ),
                              width: Get.width,
                              height: hValue(133),
                            )
                          ],
                        ),
                        height: hValue(133),
                      ),
                      onTap: (){
                        modalBottomChooseImage(onClick: (type) async {
                          XFile? image;
                          if(type == 1){
                            image = await _picker.pickImage(source: ImageSource.gallery);
                          }else{
                            image = await _picker.pickImage(source: ImageSource.camera);
                          }

                          controller.selectedBanner.value = image!;
                        });
                      },
                    ),
                    Positioned(child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          shape: BoxShape.circle,
                          color: Color(0xFFE7EDF6),
                        ),
                        child: Stack(
                          children: [
                            if(controller.selectedLogo.value.path.isNotEmpty) circleAvatarLocal("${controller.selectedLogo.value.path}", wValue(101), hValue(101)),
                            if(controller.selectedBanner.value.path == "" && (widget.currentData != null && widget.currentData!.logo!.isNotEmpty)) circleAvatar("${widget.currentData!.logo}", wValue(101), hValue(101)),
                            Container(
                              width: wValue(101),
                              height: hValue(101),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/ic_camera_circle.svg"),
                                  hSpace(5),
                                  if(controller.selectedLogo.value.path == "" && (widget.currentData != null && widget.currentData!.logo! == "")) Text("Foto Profil", style: regularTextFont.copyWith(fontSize: fontSize(10)),),
                                ],
                              ),
                            )
                          ],
                        ),
                        width: wValue(101),
                        height: hValue(101),
                        margin: EdgeInsets.only(left: wValue(22), right: wValue(22)),
                      ),
                      onTap: (){
                        modalBottomChooseImage(onClick: (type) async {
                          XFile? image;
                          if(type == 1){
                            image = await _picker.pickImage(source: ImageSource.gallery);
                          }else{
                            image = await _picker.pickImage(source: ImageSource.camera);
                          }

                          controller.selectedLogo.value = image!;
                        });
                      },
                    ), bottom: 0,)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(wValue(25)),
                child: Column(
                  children: [
                    itemTitle(title: "Nama Klub", required: true),
                    hSpace(10),
                    EditText(hintText: "Masukkan nama  Klub, contoh: “Pro Archery”", validatorText: controller.errorNameClub.value, controller: controller.nameClubTxtController.value, borderColor: Colors.white, bgColor: Colors.white, onChange: (v){
                      if(v.isEmpty){
                        controller.errorNameClub.value = "Nama Klub tidak boleh kosong";
                      }else{
                        controller.errorNameClub.value = "";
                      }
                    }),
                    hSpace(15),

                    itemTitle(title: "Nama Tempat Latihan", required: true),
                    hSpace(10),
                    EditText(hintText: "Contoh: GOR KEBON JERUK", validatorText: controller.errorTempatLatihan.value, controller: controller.namePlaceTxtController.value, borderColor: Colors.white, bgColor: Colors.white, onChange: (v){
                      if(v.isEmpty){
                        controller.errorTempatLatihan.value = "Nama Tempat Latihan tidak boleh kosong";
                      }else{
                        controller.errorTempatLatihan.value = "";
                      }
                    }),
                    hSpace(15),

                    itemTitle(title: "Alamat Tempat Latihan", required: true),
                    hSpace(10),
                    EditText(hintText: "Contoh: Nama Jalan, Kecamatan, Keluarahan", validatorText: controller.errorAddress.value, controller: controller.addressTxtController.value, borderColor: Colors.white, bgColor: Colors.white, onChange: (v){
                      if(v.isEmpty){
                        controller.errorAddress.value = "Alamat Tempat Latihan tidak boleh kosong";
                      }else{
                        controller.errorAddress.value = "";
                      }
                    }),
                    hSpace(15),

                    itemTitle(title: "Pilih Provinsi / Wilayah", required: true),
                    hSpace(10),
                    EditText(hintText: "--Pilih Provinsi--", readOnly: true, validatorText: controller.errorProvince.value, controller: controller.provinceTxtController.value, borderColor: Colors.white, bgColor: Colors.white, rightIcon: "assets/icons/ic_arrow_down.svg", onClick: (){
                      modalBottomProvince(onItemSelected: (item){
                        controller.selectedProvince.value = item;
                        controller.provinceTxtController.value.text = item.name;
                        controller.selectedCity.value = RegionModel();
                        controller.cityTxtController.value.text = "";
                      });
                    }),
                    hSpace(15),

                    itemTitle(title: "Pilih Kota", required: true),
                    hSpace(10),
                    EditText(hintText: "--Pilih Kota--", readOnly: true, validatorText: controller.errorCity.value, controller: controller.cityTxtController.value, borderColor: Colors.white, bgColor: Colors.white, rightIcon: "assets/icons/ic_arrow_down.svg", onClick: (){
                      if(controller.selectedProvince.value.id == null){
                        errorToast(msg: "Harap pilih Provinsi terlebih dahulu");
                        return;
                      }
                      modalBottomCity(idProvince: controller.selectedProvince.value.id.toString(), onItemSelected: (item){
                        controller.selectedCity.value = item;
                        controller.cityTxtController.value.text = controller.selectedCity.value.name!;
                      });
                    }),
                    hSpace(15),


                    itemTitle(title: "Deskripsi Singkat (Opsional)", required: false),
                    hSpace(10),
                    Container(
                      height: hValue(160),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: hValue(160),
                        ),
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: true,
                            child: SizedBox(
                              height: hValue(150),
                              child: TextFormField(
                                controller: controller.descTxtController.value,
                                maxLines: 100,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  errorText: controller.errorDesc.value == "" ? null : controller.errorDesc.value,
                                  focusedBorder : border(Colors.white, radius:4.0),
                                  border: border(Colors.white, radius:4.0),
                                  enabledBorder: border(Colors.white, radius:4.0),
                                  hintText: 'Masukkan Deskripsi Singkat Klub',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    hSpace(15),
                  ],
                ),
              )
            ],
          ),
        ), flex: 1,),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(wValue(25)),
          child: Row(
            children: [
              Expanded(child: Button("Batal", gray100, true, (){
                Get.back();
              }, fontColor: colorPrimary, height: hValue(36), textSize: fontSize(12)), flex: 1,),
              wSpace(10),
              Expanded(child: Button(widget.currentData != null ? "Simpan" : "Buat Klub", colorAccent, true, (){
                controller.createClub();
              }, fontColor: Colors.white, height: hValue(36), textSize: fontSize(12)), flex: 2,),
            ],
          ),
        )
      ],
    );
  }

  itemTitle({String? title, bool? required}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title", style: boldTextFont.copyWith(color: Colors.black, fontSize: fontSize(12)),),
        wSpace(2),
        if(required != null && required) Text("*", style: regularTextFont.copyWith(color: Colors.red, fontSize: fontSize(10)),)
      ],
    );
  }

  viewSuccess(){
    return Container(
      padding: EdgeInsets.all(wValue(40)),
      color: gray50,
      width: Get.width,
      height: Get.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/img/img_success_create_club.svg"),
          hSpace(28),
          Text("Berhasil", style: boldTextFont.copyWith(fontSize: fontSize(12), color: colorAccent),),
          hSpace(8),
          Text("Klub Anda telah berhasil dibuat", style: regularTextFont.copyWith(fontSize: fontSize(12), color: gray600),),
          hSpace(20),
          Button("Lihat Profil", colorAccent, true, (){
            goToPage(DetailClubScreen(idClub: controller.dataDetail.value.id!), dismissPage: true);
          }, textSize: fontSize(12), height: hValue(34))
        ],
      ),
    );
  }
}

