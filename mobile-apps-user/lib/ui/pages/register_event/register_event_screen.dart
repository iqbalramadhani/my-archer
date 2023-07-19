import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/ui/pages/register_event/register_event_controller.dart';
import 'package:myarchery_archer/ui/pages/register_event/review_register_event/review_participant_screen.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/edittext.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';

import '../../../core/models/objects/club_model.dart';
import '../../../core/models/objects/event_model.dart';
import '../../../core/models/objects/profile_model.dart';
import 'detail_payment/review_detail_payment_screen.dart';

class RegisterEvent extends StatefulWidget {
  final EventModel data;
  final int? selectedCategoryId;
  const RegisterEvent({Key? key, required this.data, this.selectedCategoryId}) : super(key: key);

  @override
  _RegisterEventState createState() => _RegisterEventState();
}

class _RegisterEventState extends State<RegisterEvent> {

  var controller = RegisterEventController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterInit());
    super.initState();
  }

  afterInit(){
    controller.currentData.value = widget.data;
    if(widget.selectedCategoryId != null){
      controller.selectedCategoryId.value = widget.selectedCategoryId!;
    }

    controller.initController();
    controller.participants[0] = controller.user.value;
    controller.participant1TxtCtrl.value.text = controller.user.value.name!;
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
            }),
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
                      viewDataPesertaIndividu(),
                      // if(controller.type.value == STR_INDIVIDU) viewDataPesertaIndividu(),
                      // if(controller.type.value == STR_TIM) viewDataPesertaClub(),
                      // if(controller.type.value == STR_MIX) viewDataPesertaMix(),
                    ],
                  ),
                ), flex: 1,),
                Container(
                  child: Button("Selanjutnya", controller.checkValidButton() ? colorPrimary : gray400, controller.checkValidButton(), (){
                    if(controller.type.value == STR_INDIVIDU) {
                      goToPage(ReviewParticipantScreen(
                        participants: controller.participants.where((p0) => p0
                            .name != null).toList(),
                        selectedClub: controller.selectedClub.value,
                        selectedCategory: controller.selectedCategory.value,
                        type: controller.type.value,
                        teamName: controller.nameTeamTxtCtrl.value.text,));
                    }else{
                      goToPage(ReviewDetailPaymentScreen(
                        participants: controller.participants.where((p0) => p0
                            .name != null).toList(),
                        event: widget.data,
                        selectedClub: controller.selectedClub.value,
                        selectedCategory: controller.selectedCategory.value,
                        type: controller.type.value,
                        teamName: controller.nameTeamTxtCtrl.value.text,));
                    }
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
            child: EditText(hintText: "Pilih Kategori", rightIcon: "assets/icons/ic_arrow_down.svg", enable: false, controller: controller.categoryTxtCtrl.value,  bgColor: Colors.white, borderColor: Colors.black),
            onTap: (){
              modalBottomCategoryRegisterEvent(data: controller.allCategoryRegister, selectedCategory: controller.selectedCategory.value, onItemSelected: (value){
                if(value.isOpen) {
                  controller.selectedCategory.value = value;
                  // controller.categoryTxtCtrl.value.text = controller.selectedCategory.value.categoryLabel!;
                  controller.categoryTxtCtrl.value.text = "${controller.selectedCategory.value.teamCategoryDetail?.label!} - ${controller.selectedCategory.value.categoryLabel!}";

                  if(controller.selectedCategory.value.teamCategoryDetail!.id!.toLowerCase().contains("individu")){
                    controller.type.value = STR_INDIVIDU;
                    controller.isWakilClub.value = 1;
                  }

                  if(controller.selectedCategory.value.teamCategoryDetail!.id!.toLowerCase().contains("team")){
                    printLog(msg: "team");
                    controller.type.value = STR_TIM;
                  }

                  if(controller.selectedCategory.value.teamCategoryDetail!.id!.toLowerCase().contains("mix")){
                    printLog(msg: "mix");
                    controller.type.value = STR_MIX;
                  }

                  // clearInput();
                }else{
                  errorToast(msg: "Kuota kategori ini telah terpenuhi atau sudah di tutup");
                }
              });
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

  viewDataPesertaIndividu(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Data Peserta", style: boldTextFont.copyWith(fontSize: fontSize(20)),),
          hSpace(4),
          Text("Pilih peserta yang terdaftar di klub & kategori yang sama", style: regularTextFont.copyWith(fontSize: fontSize(12)),),


          if(controller.type.value == STR_INDIVIDU) Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(15),
              Text("Apakah Anda mewakili Klub?", style: boldTextFont.copyWith(fontSize: fontSize(12)),),
              hSpace(5),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: controller.isWakilClub.value,
                    onChanged: (value) {
                      controller.isWakilClub.value = int.parse("$value");
                    },
                  ),
                  // InkWell(
                  //   child: SvgPicture.asset(controller.isWakilClub.value ? "assets/icons/ic_checked.svg" : "assets/icons/ic_uncheck.svg"),
                  //   onTap: (){
                  //     controller.isWakilClub.value = !controller.isWakilClub.value;
                  //     if(!controller.isWakilClub.value){
                  //       controller.selectedClub.value = ClubModel();
                  //       controller.clubNameTxtCtrl.value.text = "";
                  //     }
                  //   },
                  // ),
                  wSpace(5),
                  Text("Iya, Saya mewakili Klub", style: regularTextFont.copyWith(fontSize: fontSize(12)),)
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: controller.isWakilClub.value,
                    onChanged: (value) {
                      controller.isWakilClub.value = int.parse("$value");
                    },
                  ),
                  // InkWell(
                  //   child: SvgPicture.asset(controller.isWakilClub.value ? "assets/icons/ic_checked.svg" : "assets/icons/ic_uncheck.svg"),
                  //   onTap: (){
                  //     controller.isWakilClub.value = !controller.isWakilClub.value;
                  //     if(!controller.isWakilClub.value){
                  //       controller.selectedClub.value = ClubModel();
                  //       controller.clubNameTxtCtrl.value.text = "";
                  //     }
                  //   },
                  // ),
                  wSpace(5),
                  Text("Tidak, saya Individu", style: regularTextFont.copyWith(fontSize: fontSize(12)),)
                ],
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(15),
              labelText("Nama Klub", required: controller.isWakilClub.value == 1),
              hSpace(5),
              InkWell(
                child: EditText(hintText: "Pilih Klub", enable: false, readOnly: controller.isWakilClub.value != 1, rightIcon: "assets/icons/ic_arrow_right.svg", controller: controller.clubNameTxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
                onTap: (){
                  if(controller.type.value == STR_INDIVIDU && controller.isWakilClub.value == 1 || controller.type.value != STR_INDIVIDU) {
                    modalBottomSearchClub(onClickClub: (ClubModel itm) {
                      if (itm.isJoin! == 0) {
                        errorToast(
                            msg: "Anda harus bergabung dulu ke grup ini terlebih dahulu");
                        return;
                      }

                      controller.selectedClub.value = itm;
                      controller.clubNameTxtCtrl.value.text = itm.detail!.name!;

                      controller.participants[0] = controller.user.value;
                      controller.participant1TxtCtrl.value.text =
                      controller.user.value.name!;
                    });
                  }
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

  viewDataPesertaClub(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Data Peserta", style: boldTextFont.copyWith(fontSize: fontSize(20)),),
          hSpace(4),
          Text("Pilih peserta yang terdaftar di klub & kategori yang sama", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
          hSpace(10),
          if(!controller.isMinParticipantValid(3)) viewCardInfo((!controller.isMinParticipantValid(3)) ? "error" : "info", "Pendaftaran untuk ${controller.selectedCategory.value.teamCategoryDetail!.label!} minimal terdiri dari 3 peserta"),

          hSpace(24),
          labelText("Nama Tim", required: true),
          hSpace(5),
          EditText(hintText: "Masukkan Nama Tim", controller: controller.nameTeamTxtCtrl.value,  bgColor: Colors.white, borderColor: Colors.black,),

          hSpace(15),
          labelText("Nama Klub", required: true),
          hSpace(5),
          InkWell(
            child: EditText(hintText: "Pilih Klub", enable: false, rightIcon: "assets/icons/ic_arrow_right.svg", controller: controller.clubNameTxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
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

          hSpace(35),
          labelText("Peserta 1", required: true),
          hSpace(5),
          InkWell(
            child: EditText(hintText: "Pilih Peserta", enable: false, rightIcon: "assets/icons/ic_arrow_down.svg", controller: controller.participant1TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
            onTap: (){
              if(controller.selectedClub.value.detail == null){
                errorToast(msg: "Harap pilih klub terlebih dahulu");
                return;
              }

              modalBottomSearchMemberRegisterEvent(teamName : controller.nameTeamTxtCtrl.value.text, categoryId: controller.selectedCategory.value.id!.toString(),
                  clubId: controller.selectedClub.value.detail!.id!,
                  onClickItem: (itm){
                if(controller.participants.any((p0) => p0.id == itm.id)){
                  errorToast(msg: "Peserta ${itm.name} sudah ditambahkan sebelumnya");
                  return;
                }

                controller.participants[0] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                controller.participant1TxtCtrl.value.text = itm.name!;
              });
            },
          ),
          //
          // hSpace(5),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("Sama dengan pendaftar", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
          //     Switch(value: controller.sameWithRegistrant.value, onChanged: (v){
          //       controller.sameWithRegistrant.value = v;
          //       controller.setParticipant1(v);
          //     })
          //   ],
          // ),

          hSpace(15),
          labelText("Peserta 2", required: true),
          hSpace(5),
          InkWell(
            child: EditText(hintText: "Pilih Peserta", enable: false, rightIcon: "assets/icons/ic_arrow_down.svg", controller: controller.participant2TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
            onTap: (){
              if(controller.selectedClub.value.detail == null){
                errorToast(msg: "Harap pilih klub terlebih dahulu");
                return;
              }

              if(controller.participants[0].name == null){
                errorToast(msg: "Harap pilih Peserta 1 terlebih dahulu");
                return;
              }

              modalBottomSearchMemberRegisterEvent(teamName : controller.nameTeamTxtCtrl.value.text, categoryId: controller.selectedCategory.value.id!.toString(),
                  clubId: controller.selectedClub.value.detail!.id!,
                  onClickItem: (itm){
                    if(controller.participants.any((p0) => p0.id == itm.id)){
                      errorToast(msg: "Peserta ${itm.name} sudah ditambahkan sebelumnya");
                      return;
                    }

                    controller.participants[1] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                    controller.participant2TxtCtrl.value.text = itm.name!;
                  });

              // modalBottomSearchMemberClub(teamName : controller.nameTeamTxtCtrl.value.text,idClub: controller.selectedClub.value.detail!.id!,
              //     categoryId: controller.selectedCategory.value.id!.toString(), clubId: controller.selectedClub.value.detail!.id!.toString(),
              //     onClickItem: (MemberClubModel itm){
              //   if(controller.participants.any((p0) => p0.id == itm.id)){
              //     errorToast(msg: "Peserta ${itm.name} sudah ditambahkan sebelumnya");
              //     return;
              //   }
              //
              //   controller.participants[1] = ProfileModel(id: itm.id, name: itm.name);
              //   controller.participant2TxtCtrl.value.text = itm.name!;
              // });
            },
          ),

          hSpace(15),
          labelText("Peserta 3", required: true),
          hSpace(5),
          InkWell(
            child: EditText(hintText: "Pilih Peserta", enable: false, rightIcon: "assets/icons/ic_arrow_down.svg", controller: controller.participant3TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
            onTap: (){
              if(controller.selectedClub.value.detail == null){
                errorToast(msg: "Harap pilih klub terlebih dahulu");
                return;
              }

              if(controller.participants[1].name == null){
                errorToast(msg: "Harap pilih Peserta 2 terlebih dahulu");
                return;
              }
              modalBottomSearchMemberRegisterEvent(teamName : controller.nameTeamTxtCtrl.value.text, categoryId: controller.selectedCategory.value.id!.toString(),
                  clubId: controller.selectedClub.value.detail!.id!,
                  onClickItem: (itm){
                    if(controller.participants.any((p0) => p0.id == itm.id)){
                      errorToast(msg: "Peserta ${itm.name} sudah ditambahkan sebelumnya");
                      return;
                    }

                    controller.participants[2] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                    controller.participant3TxtCtrl.value.text = itm.name!;
                  });
            },
          ),

          hSpace(15),
          labelText("Peserta 4", required: false),
          hSpace(5),
          InkWell(
            child: EditText(hintText: "Pilih Peserta", enable: false, rightIcon: "assets/icons/ic_arrow_down.svg", controller: controller.participant4TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
            onTap: (){
              if(controller.selectedClub.value.detail == null){
                errorToast(msg: "Harap pilih klub terlebih dahulu");
                return;
              }

              if(controller.participants[2].name == null){
                errorToast(msg: "Harap pilih Peserta 3 terlebih dahulu");
                return;
              }
              modalBottomSearchMemberRegisterEvent(teamName : controller.nameTeamTxtCtrl.value.text, categoryId: controller.selectedCategory.value.id!.toString(),
                  clubId: controller.selectedClub.value.detail!.id!,
                  onClickItem: (itm){
                    if(controller.participants.any((p0) => p0.id == itm.id)){
                      errorToast(msg: "Peserta ${itm.name} sudah ditambahkan sebelumnya");
                      return;
                    }

                    controller.participants[3] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                    controller.participant2TxtCtrl.value.text = itm.name!;
                  });
            },
          ),

          hSpace(15),
          labelText("Peserta 5", required: false),
          hSpace(5),
          InkWell(
            child: EditText(hintText: "Pilih Peserta", enable: false, rightIcon: "assets/icons/ic_arrow_down.svg", controller: controller.participant5TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
            onTap: (){
              if(controller.selectedClub.value.detail == null){
                errorToast(msg: "Harap pilih klub terlebih dahulu");
                return;
              }

              if(controller.participants[3].name == null){
                errorToast(msg: "Harap pilih Peserta 4 terlebih dahulu");
                return;
              }
              modalBottomSearchMemberRegisterEvent(teamName : controller.nameTeamTxtCtrl.value.text, categoryId: controller.selectedCategory.value.id!.toString(),
                  clubId: controller.selectedClub.value.detail!.id!,
                  onClickItem: (itm){
                    if(controller.participants.any((p0) => p0.id == itm.id)){
                      errorToast(msg: "Peserta ${itm.name} sudah ditambahkan sebelumnya");
                      return;
                    }

                    controller.participants[4] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                    controller.participant2TxtCtrl.value.text = itm.name!;
                  });
            },
          ),

        ],
      ),
      padding: EdgeInsets.all(wValue(15)),
    );
  }

  viewDataPesertaMix(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Data Peserta", style: boldTextFont.copyWith(fontSize: fontSize(20)),),
          hSpace(4),
          Text("Pilih peserta yang terdaftar di klub & kategori yang sama", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
          hSpace(10),
          viewCardInfo((!controller.genderMixValid.value) ? "error" : "info", "Pendaftaran untuk Mix Team minimal terdiri dari 1 peserta putra dan 1 peserta putri"),
          // if(!controller.checkGenderMixTeam()) viewCardInfo("error", "Pendaftaran untuk Mix Team minimal terdiri dari 1 peserta putra dan 1 peserta putri"),
          hSpace(24),
          labelText("Nama Tim", required: true),
          hSpace(5),
          EditText(hintText: "Masukkan Nama Tim", controller: controller.nameTeamTxtCtrl.value,  bgColor: Colors.white, borderColor: Colors.black,),

          hSpace(15),
          labelText("Nama Klub", required: true),
          hSpace(5),
          InkWell(
            child: EditText(hintText: "Pilih Klub", enable: false, rightIcon: "assets/icons/ic_arrow_right.svg", controller: controller.clubNameTxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
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

          hSpace(35),
          labelText("Peserta 1", required: true),
          hSpace(5),
          InkWell(
            child: EditText(hintText: "Pilih Peserta", enable: false, rightIcon: "assets/icons/ic_arrow_down.svg", controller: controller.participant1TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
            onTap: (){
              if(controller.selectedClub.value.detail == null){
                errorToast(msg: "Harap pilih klub terlebih dahulu");
                return;
              }

              modalBottomSearchMemberRegisterEvent(teamName : controller.nameTeamTxtCtrl.value.text, categoryId: controller.selectedCategory.value.id!.toString(),
                  clubId: controller.selectedClub.value.detail!.id!,
                  onClickItem: (itm){
                    if(controller.participants.any((p0) => p0.id == itm.id)){
                      errorToast(msg: "Peserta ${itm.name} sudah ditambahkan sebelumnya");
                      return;
                    }

                    controller.participants[0] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                    controller.participant1TxtCtrl.value.text = itm.name!;

                    controller.checkGenderMixTeam();
                  });
            },
          ),

          // hSpace(5),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("Sama dengan pendaftar", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
          //     Switch(value: controller.sameWithRegistrant.value, onChanged: (v){
          //       controller.sameWithRegistrant.value = v;
          //       controller.setParticipant1(v);
          //     })
          //   ],
          // ),

          hSpace(15),
          labelText("Peserta 2", required: true),
          hSpace(5),
          InkWell(
            child: EditText(hintText: "Pilih Peserta", enable: false, rightIcon: "assets/icons/ic_arrow_down.svg", controller: controller.participant2TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
            onTap: (){
              if(controller.selectedClub.value.detail == null){
                errorToast(msg: "Harap pilih klub terlebih dahulu");
                return;
              }

              if(controller.participants[0].name == null){
                errorToast(msg: "Harap pilih Peserta 1 terlebih dahulu");
                return;
              }

              modalBottomSearchMemberRegisterEvent(teamName : controller.nameTeamTxtCtrl.value.text, categoryId: controller.selectedCategory.value.id!.toString(),
                  clubId: controller.selectedClub.value.detail!.id!,
                  onClickItem: (itm){
                    if(controller.participants.any((p0) => p0.id == itm.id)){
                      errorToast(msg: "Peserta ${itm.name} sudah ditambahkan sebelumnya");
                      return;
                    }

                    controller.participants[1] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                    controller.participant2TxtCtrl.value.text = itm.name!;

                    controller.checkGenderMixTeam();
                  });
            },
          ),

          hSpace(15),
          labelText("Peserta 3"),
          hSpace(5),
          InkWell(
            child: EditText(hintText: "Pilih Peserta", enable: false, rightIcon: "assets/icons/ic_arrow_down.svg", controller: controller.participant3TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
            onTap: (){
              if(controller.selectedClub.value.detail == null){
                errorToast(msg: "Harap pilih klub terlebih dahulu");
                return;
              }

              if(controller.participants[1].name == null){
                errorToast(msg: "Harap pilih Peserta 2 terlebih dahulu");
                return;
              }

              modalBottomSearchMemberRegisterEvent(teamName : controller.nameTeamTxtCtrl.value.text, categoryId: controller.selectedCategory.value.id!.toString(),
                  clubId: controller.selectedClub.value.detail!.id!,
                  onClickItem: (itm){
                    if(controller.participants.any((p0) => p0.id == itm.id)){
                      errorToast(msg: "Peserta ${itm.name} sudah ditambahkan sebelumnya");
                      return;
                    }

                    controller.participants[2] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                    controller.participant2TxtCtrl.value.text = itm.name!;

                    controller.checkGenderMixTeam();
                  });
            },
          ),

          hSpace(15),
          labelText("Peserta 4", required: false),
          hSpace(5),
          InkWell(
            child: EditText(hintText: "Pilih Peserta", enable: false, rightIcon: "assets/icons/ic_arrow_down.svg", controller: controller.participant4TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
            onTap: (){
              if(controller.selectedClub.value.detail == null){
                errorToast(msg: "Harap pilih klub terlebih dahulu");
                return;
              }

              if(controller.participants[2].name == null){
                errorToast(msg: "Harap pilih Peserta 3 terlebih dahulu");
                return;
              }

              modalBottomSearchMemberRegisterEvent(teamName : controller.nameTeamTxtCtrl.value.text, categoryId: controller.selectedCategory.value.id!.toString(),
                  clubId: controller.selectedClub.value.detail!.id!,
                  onClickItem: (itm){
                    if(controller.participants.any((p0) => p0.id == itm.id)){
                      errorToast(msg: "Peserta ${itm.name} sudah ditambahkan sebelumnya");
                      return;
                    }

                    controller.participants[3] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                    controller.participant2TxtCtrl.value.text = itm.name!;

                    controller.checkGenderMixTeam();
                  });
            },
          ),


          hSpace(15),
          labelText("Peserta 5", required: false),
          hSpace(5),
          InkWell(
            child: EditText(hintText: "Pilih Peserta", enable: false, rightIcon: "assets/icons/ic_arrow_down.svg", controller: controller.participant5TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
            onTap: (){
              if(controller.selectedClub.value.detail == null){
                errorToast(msg: "Harap pilih klub terlebih dahulu");
                return;
              }

              if(controller.participants[3].name == null){
                errorToast(msg: "Harap pilih Peserta 4 terlebih dahulu");
                return;
              }

              modalBottomSearchMemberRegisterEvent(teamName : controller.nameTeamTxtCtrl.value.text, categoryId: controller.selectedCategory.value.id!.toString(),
                  clubId: controller.selectedClub.value.detail!.id!,
                  onClickItem: (itm){
                    if(controller.participants.any((p0) => p0.id == itm.id)){
                      errorToast(msg: "Peserta ${itm.name} sudah ditambahkan sebelumnya");
                      return;
                    }

                    controller.participants[4] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                    controller.participant2TxtCtrl.value.text = itm.name!;

                    controller.checkGenderMixTeam();
                  });
            },
          ),

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
}
