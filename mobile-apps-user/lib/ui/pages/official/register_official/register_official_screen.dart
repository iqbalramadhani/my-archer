import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/core/models/response/detail_official_response.dart';
import 'package:myarchery_archer/ui/pages/official/detail_participant_official/detail_register_official_screen.dart';
import 'package:myarchery_archer/ui/pages/official/register_official/register_official_controller.dart';
import 'package:myarchery_archer/utils/global_helper.dart';

import '../../../../core/models/objects/club_model.dart';
import '../../../../core/models/objects/event_model.dart';
import '../../../../utils/spacing.dart';
import '../../../../utils/theme.dart';
import '../../../shared/appbar.dart';
import '../../../shared/base_container.dart';
import '../../../shared/button.dart';
import '../../../shared/edittext.dart';
import '../../../shared/modal_bottom.dart';
import '../../../shared/toast.dart';

class RegisterOfficialScreen extends StatefulWidget {
  final EventModel event;
  final DataDetailOfficialModel official;
  const RegisterOfficialScreen({Key? key, required this.event, required this.official}) : super(key: key);

  @override
  _RegisterOfficialScreenState createState() => _RegisterOfficialScreenState();
}

class _RegisterOfficialScreenState extends State<RegisterOfficialScreen> {

  var controller = RegisterOfficialController();

  @override
  void initState() {
    controller.currentData.value = widget.event;
    WidgetsBinding.instance.addPostFrameCallback((_) => afterInit());
    super.initState();
  }

  afterInit(){
    controller.initController();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Container(
        color: colorPrimary,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar("Pendaftaran", (){
              Get.back();
            }, bgColor: colorPrimary, textColor: Colors.white, iconColor: Colors.white),
            body: Obx(()=> Column(
              children: [
                Expanded(child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      viewDataPendaftar(),
                      Container(
                        margin: EdgeInsets.only(top: hValue(15), bottom: hValue(15)),
                        color: bgPage,
                        height: hValue(15),
                      ),
                      viewDataOfficial()
                    ],
                  ),
                ), flex: 1,),
                Container(
                  child: Button("Selanjutnya", controller.checkValidButton() ? colorPrimary : gray400, controller.checkValidButton(), (){
                    goToPage(DetailRegisterOfficialScreen(event: widget.event, selectedClub: controller.selectedClub.value, selectedCategory: controller.selectedCategory.value,
                      official: widget.official,));
                  }),
                  padding: EdgeInsets.all(wValue(15)),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }

  viewDataPendaftar(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Data Pendaftar", style: boldTextFont.copyWith(fontSize: fontSize(20)),),
          hSpace(24),
          labelText("Kategori"),
          hSpace(5),
          InkWell(
            child: EditText(hintText: "Pilih Kategori", enable: false, controller: controller.categoryFirstTxtCtrl.value,  bgColor: Colors.white, borderColor: Colors.black),
            onTap: (){

            },
          ),

          hSpace(15),
          labelText("Nama Pendaftar", textColor: gray400),
          hSpace(5),
          EditText(hintText: "Masukkan Nama Pendaftar", enable: false, textStyle: regularTextFont.copyWith(
              fontSize: fontSize(12),
              color: gray400
          ), controller: controller.namePendaftarTxtCtrl.value, bgColor: Color(0xFFF6F6F6), borderColor: Color(0xFFF6F6F6)),

          hSpace(15),
          labelText("Email", textColor: gray400),
          hSpace(5),
          EditText(hintText: "Masukkan Email", enable: false, textStyle: regularTextFont.copyWith(
              fontSize: fontSize(12),
              color: gray400
          ), controller: controller.emailPendaftarTxtCtrl.value, bgColor: Color(0xFFF6F6F6), borderColor: Color(0xFFF6F6F6)),

          hSpace(15),
          labelText("No. Telepon", textColor: gray400),
          hSpace(5),
          EditText(hintText: "Masukkan Nomor Telepon", enable: false, textStyle: regularTextFont.copyWith(
              fontSize: fontSize(12),
              color: gray400
          ), controller: controller.phonePendaftarTxtCtrl.value, bgColor: Color(0xFFF6F6F6), borderColor: Color(0xFFF6F6F6)),
        ],
      ),
      padding: EdgeInsets.all(wValue(15)),
    );
  }

  viewDataOfficial(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Data Official", style: boldTextFont.copyWith(fontSize: fontSize(20)),),
          hSpace(4),
          Text("Masukan email peserta yang telah terdaftar", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
          hSpace(5),
          viewCardInfo("info", "Kartu ID Official tidak bisa dipindahtangankan"),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(15),
              labelText("Nama Klub", required: true),
              hSpace(5),
              InkWell(
                child: EditText(hintText: "Pilih Klub", enable: false, onChange: (v){
                  if(v.toString().isEmpty){
                    controller.errorClubMsg.value = "Harap pilih Klub terlebih dahulu";
                  }
                }, validatorText: controller.errorClubMsg.value.isEmpty ? null : controller.errorClubMsg.value,
                  rightIcon: "assets/icons/ic_arrow_right.svg", controller: controller.clubNameTxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
                onTap: (){
                  modalBottomSearchClub(onClickClub: (ClubModel itm){
                    if(itm.isJoin! == 0){
                      errorToast(msg: "Anda harus bergabung dulu ke grup ini terlebih dahulu");
                      return;
                    }

                    controller.selectedClub.value = itm;
                    controller.clubNameTxtCtrl.value.text = itm.detail!.name!;

                  });
                },
              ),

              hSpace(15),
              labelText("Kategori Pertandingan", required: true),
              hSpace(5),
              InkWell(
                child: EditText(hintText: "Pilih Kategori Pertandingan", enable: false, onChange: (v){
                  if(v.toString().isEmpty){
                    controller.errorCategoryMsg.value = "Harap pilih Kategori terlebih dahulu";
                  }
                }, validatorText: controller.errorCategoryMsg.value.isEmpty ? null : controller.errorCategoryMsg.value,
                  rightIcon: "assets/icons/ic_arrow_right.svg", controller: controller.categoryTxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
                onTap: (){
                  modalBottomCategoryRegisterEvent(data: controller.allCategoryRegister, selectedCategory: controller.selectedCategory.value, onItemSelected: (value){
                    if(value.isOpen) {
                      controller.selectedCategory.value = value;
                      controller.categoryTxtCtrl.value.text = "${controller.selectedCategory.value.teamCategoryDetail?.label!} - ${controller.selectedCategory.value.categoryLabel!}";
                    }else{
                      errorToast(msg: "Kuota kategori ini telah terpenuhi atau sudah di tutup");
                    }
                  });
                },
              ),
            ],
          ),

          hSpace(25),
        ],
      ),
      padding: EdgeInsets.all(wValue(15)),
    );
  }

  viewCardInfo(String type, String content){
    return Container(
      padding: EdgeInsets.all(wValue(15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: (type == "info") ? green50 : orange50,
      ),
      child: Row(
        children: [
          SvgPicture.asset(type == "info" ? "assets/icons/ic_info.svg" : "assets/icons/ic_info_red.svg"),
          wSpace(10),
          Expanded(child: Text(content, style: regularTextFont.copyWith(fontSize: fontSize(12), color: type == "info" ? colorPrimary : Colors.red),), flex: 1,)
        ],
      ),
    );
  }

  labelText(String label, {Color? textColor, double? textSize, bool? required}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label", style: regularTextFont.copyWith(fontSize: textSize ?? fontSize(12), color: textColor ?? Colors.black),),
        wSpace(5),
        if(required != null && required) Text("*", style: boldTextFont.copyWith(fontSize: textSize ?? fontSize(10), color: Colors.red),),
      ],
    );
  }
}
