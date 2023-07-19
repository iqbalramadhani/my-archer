import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/gen/assets.gen.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/edittext.dart';
import 'package:myarchery_archer/ui/shared/item_list.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';
import 'package:myarchery_archer/ui/shared/shimmer_loading.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/category_detail_model.dart';
import '../../../../core/models/objects/profile_model.dart';
import '../../../../core/models/response/detail_event_response.dart';
import 'detail_my_event_category_controller.dart';
import 'item/item.dart';

class DetailMyEventCategoryScreen extends StatefulWidget {
  final CategoryDetailModel category;
  final DataDetailEventModel event;
  const DetailMyEventCategoryScreen({Key? key, required this.category, required this.event}) : super(key: key);

  @override
  _DetailMyEventCategoryScreenState createState() => _DetailMyEventCategoryScreenState();
}

class _DetailMyEventCategoryScreenState extends State<DetailMyEventCategoryScreen> {
  
  var controller = DetailMyEventCategoryController();
  
  @override
  void initState() {
    controller.category.value = widget.category;
    controller.event.value = widget.event;
    controller.initController();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Container(
        child: SafeArea(
          child: Obx(()=> Scaffold(
            backgroundColor: bgPage,
            appBar: appBar("${widget.category.categoryLabel}", (){
              Get.back();
            }),
            body: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(child: itemMenuTop("ic_event.svg", Translator.event.tr, controller.selectedMenu.value == 0, (){
                        controller.selectedMenu.value = 0;
                      }) ,flex: 1,),
                      Expanded(child: itemMenuTop("ic_users.svg", Translator.participant.tr, controller.selectedMenu.value == 1, (){
                        controller.selectedMenu.value = 1;
                      }) ,flex: 1,),
                      Expanded(child: itemMenuTop("ic_shot.svg", Translator.match.tr, controller.selectedMenu.value == 2, (){
                        generalToast(msg: Translator.comingSoon.tr);
                        // controller.selectedMenu.value = 2;
                      }) ,flex: 1,),
                      Expanded(child: itemMenuTop("ic_document.svg", Translator.document.tr, controller.selectedMenu.value == 3, (){
                        generalToast(msg: Translator.comingSoon.tr);
                        // controller.selectedMenu.value = 3;
                      }) ,flex: 1,),
                    ],
                  ),
                  margin: EdgeInsets.all(wValue(15)),
                ),
                setPage()
              ],
            ),
          )),
        ),
      ),
    );
  }

  viewEvent(){
    return Container(
      padding: EdgeInsets.all(wValue(15)),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageRadius("${widget.event.publicInformation!.eventBanner}", wValue(64), hValue(60), wValue(12)),
          wSpace(10),
          Expanded(child: Column(
            children: [
              itemInfoEvent(Translator.eventName.tr, "${widget.event.publicInformation!.eventName}"),
              itemInfoEvent(Translator.eventType.tr, "${widget.event.eventCompetition}"),
              itemInfoEvent(Translator.location.tr, "${widget.event.publicInformation!.eventCity!.nameCity}"),
              itemInfoEvent(Translator.date.tr, "${convertDateFormat("yyyy-MM-dd", "dd MMMM yyyy", widget.event.publicInformation!.eventStart!)} - ${convertDateFormat("yyyy-MM-dd", "dd MMMM yyyy", widget.event.publicInformation!.eventEnd!)}"),
            ],
          ), flex: 1,)
        ],
      ),
    );
  }

  viewCardInfo(){
    return Container(
      padding: EdgeInsets.all(wValue(15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: green50,
      ),
      child: Row(
        children: [
          SvgPicture.asset(Assets.icons.icInfo),
          wSpace(10),
          Expanded(child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  text: '${Translator.editBoundary.tr} ',
                  style: regularTextFont.copyWith(color: colorPrimary, fontSize: fontSize(12)),
                  children: <TextSpan>[
                    TextSpan(text: '${Translator.listParticipant.tr} ', style: boldTextFont.copyWith(color: colorPrimary, fontSize: fontSize(12))),
                    TextSpan(text: '${Translator.maxHmin1Event.tr}', style: regularTextFont.copyWith(color: colorAccent, fontSize: fontSize(12))),
                  ]
              ),), flex: 1,)
        ],
      ),
    );
  }

  viewParticipant(){
    return Expanded(child: Stack(
      children: [
        Container(
          width: Get.width,
          color: Colors.white,
          padding: EdgeInsets.all(wValue(15)),
          child: controller.isLoading.value ? showShimmerList() : SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Translator.dataRegistrant.tr, style: boldTextFont.copyWith(fontSize: fontSize(18)),),
                hSpace(25),
                Text(Translator.nameRegistrant.tr, style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                Text(controller.membersResp.value.data!.participant!.name ?? "-", style: boldTextFont.copyWith(fontSize: fontSize(12)),),

                hSpace(15),
                Text(Translator.email.tr, style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                Text(controller.membersResp.value.data!.participant!.email ?? "-", style: boldTextFont.copyWith(fontSize: fontSize(12)),),
                hSpace(15),
                Text(Translator.phoneNumber.tr, style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                Text(controller.membersResp.value.data!.participant!.phoneNumber ?? "-", style: boldTextFont.copyWith(fontSize: fontSize(12)),),

                hSpace(15),
                Divider(),
                hSpace(15),

                viewCardInfo(),

                hSpace(25),
                Text(Translator.dataRegistrant.tr, style: boldTextFont.copyWith(fontSize: fontSize(18)),),
                hSpace(25),
                Row(
                  children: [
                    Expanded(child: itemInfoPeserta(Translator.teamName.tr, controller.membersResp.value.data!.participant!.teamName ??  "-"), flex: 1,),
                    Expanded(child: itemInfoPeserta(Translator.clubName.tr, controller.membersResp.value.data!.club!.isNotEmpty ? "${controller.membersResp.value.data!.club!.first.name}" : ""), flex: 1,),
                  ],
                ),
                hSpace(25),

                (controller.isEditMode.value) ? viewFormPeserta() : viewListPeserta(),

                hSpace(55),
              ],
            ),
          ),
        ),
        if(!widget.category.teamCategoryDetail!.label!.toString().toLowerCase().contains("individual")) Positioned(child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.5),
                blurRadius: 10.0, // soften the shadow
                spreadRadius: 0.0, //extend the shadow
                offset: Offset(
                  2.0, // Move to right 10  horizontally
                  1.0, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          padding: EdgeInsets.all(wValue(15)),
          child: controller.isEditMode.value ? Row(
            children: [
              Expanded(child: Button(Translator.cancel.tr, Colors.grey, true, (){
              controller.isEditMode.value = false;
              }, fontColor: Colors.white, height: hValue(36), textSize: fontSize(12)), flex: 1,),
              wSpace(5),
              Expanded(child: Button(Translator.changeParticipant.tr, colorPrimary, true, (){
                controller.apiEditMember(onFinish: (){
                  controller.isEditMode.value = false;
                });
              }, fontColor: Colors.white, height: hValue(36), textSize: fontSize(12)), flex: 1,),
            ],
          )  : Button(Translator.changeParticipant.tr, colorPrimary, true, (){
            controller.isEditMode.value = true;
          }, fontColor: Colors.white, height: hValue(36), textSize: fontSize(12)),
        ), bottom: 0,)
      ],
    ), flex: 1,);
  }

  viewListPeserta(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        itemPesertaOrderEvent(controller.membersResp.value.data!.member!, 1)
      ],
    );
  }

  viewFormPeserta(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hSpace(15),
        labelText("${Translator.participant.tr} 1", required: true),
        hSpace(5),
        InkWell(
          child: EditText(hintText: Translator.chooseParticipant.tr, enable: false,
            rightIcon: Assets.icons.icArrowDown, controller: controller.participant1TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
          onTap: (){
            modalBottomSearchMemberRegisterEvent(teamName : controller.membersResp.value.data!.participant!.teamName, categoryId: controller.membersResp.value.data!.eventCategoryDetail!.id!.toString(),
                clubId: controller.membersResp.value.data!.club!.first.id!,
                onClickItem: (itm){
                  if(controller.participants.any((p0) => p0.id == itm.id)){
                    errorToast(msg: "${Translator.participant.tr} ${itm.name} ${Translator.alreadyAdded.tr}");
                    return;
                  }

                  controller.participants[0] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                  controller.participant1TxtCtrl.value.text = itm.name!;
                });
          },
        ),

        hSpace(15),
        labelText("${Translator.participant.tr} 2", required: true),
        hSpace(5),
        InkWell(
          child: EditText(hintText: Translator.chooseParticipant.tr, enable: false,
            rightIcon: Assets.icons.icArrowDown, controller: controller.participant2TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
          onTap: (){
            if(controller.participants[0].name == null){
              errorToast(msg: Translator.pleaseChooseParticipant1First.tr);
              return;
            }

            modalBottomSearchMemberRegisterEvent(teamName : controller.membersResp.value.data!.participant!.teamName, categoryId: controller.membersResp.value.data!.eventCategoryDetail!.id!.toString(),
                clubId: controller.membersResp.value.data!.club!.first.id!,
                onClickItem: (itm){
                  if(controller.participants.any((p0) => p0.id == itm.id)){
                    errorToast(msg: "${Translator.participant.tr} ${itm.name} ${Translator.alreadyAdded.tr}");
                    return;
                  }

                  controller.participants[1] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                  controller.participant2TxtCtrl.value.text = itm.name!;
                });
          },
        ),

        hSpace(15),
        labelText("${Translator.participant.tr} 3", required: true),
        hSpace(5),
        InkWell(
          child: EditText(hintText: Translator.chooseParticipant.tr, enable: false,
            rightIcon: Assets.icons.icArrowDown, controller: controller.participant3TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
          onTap: (){
            if(controller.participants[1].name == null){
              errorToast(msg: Translator.pleaseChooseParticipant2First.tr);
              return;
            }
            modalBottomSearchMemberRegisterEvent(teamName : controller.membersResp.value.data!.participant!.teamName, categoryId: controller.membersResp.value.data!.eventCategoryDetail!.id!.toString(),
                clubId: controller.membersResp.value.data!.club!.first.id!,
                onClickItem: (itm){
                  if(controller.participants.any((p0) => p0.id == itm.id)){
                    errorToast(msg: "${Translator.participant.tr} ${itm.name} ${Translator.alreadyAdded.tr}");
                    return;
                  }

                  controller.participants[2] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                  controller.participant3TxtCtrl.value.text = itm.name!;
                });
          },
        ),

        hSpace(15),
        labelText("${Translator.participant.tr} 4", required: false),
        hSpace(5),
        InkWell(
          child: EditText(hintText: Translator.chooseParticipant.tr, enable: false,
            rightIcon: Assets.icons.icArrowDown, controller: controller.participant4TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
          onTap: (){
            if(controller.participants[2].name == null){
              errorToast(msg: Translator.pleaseChooseParticipant3First.tr);
              return;
            }
            modalBottomSearchMemberRegisterEvent(teamName : controller.membersResp.value.data!.participant!.teamName, categoryId: controller.membersResp.value.data!.eventCategoryDetail!.id!.toString(),
                clubId: controller.membersResp.value.data!.club!.first.id!,
                onClickItem: (itm){
                  if(controller.participants.any((p0) => p0.id == itm.id)){
                    errorToast(msg: "${Translator.participant.tr} ${itm.name} ${Translator.alreadyAdded.tr}");
                    return;
                  }

                  controller.participants[3] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                  controller.participant2TxtCtrl.value.text = itm.name!;
                });
          },
        ),

        hSpace(15),
        labelText("${Translator.participant.tr} 5", required: false),
        hSpace(5),
        InkWell(
          child: EditText(hintText: Translator.chooseParticipant.tr, enable: false,
            rightIcon: Assets.icons.icArrowDown, controller: controller.participant5TxtCtrl.value, bgColor: Colors.white, borderColor: Colors.black,),
          onTap: (){
            if(controller.participants[3].name == null){
              errorToast(msg: Translator.pleaseChooseParticipant4First.tr);
              return;
            }
            modalBottomSearchMemberRegisterEvent(teamName : controller.membersResp.value.data!.participant!.teamName, categoryId: controller.membersResp.value.data!.eventCategoryDetail!.id!.toString(),
                clubId: controller.membersResp.value.data!.club!.first.id!,
                onClickItem: (itm){
                  if(controller.participants.any((p0) => p0.id == itm.id)){
                    errorToast(msg: "${Translator.participant.tr} ${itm.name} ${Translator.alreadyAdded.tr}");
                    return;
                  }

                  controller.participants[4] = ProfileModel(id: itm.id, name: itm.name, avatar: itm.avatar, age: itm.age, email: itm.email, gender: itm.gender);
                  controller.participant2TxtCtrl.value.text = itm.name!;
                });
          },
        ),
      ],
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

  setPage(){
    if(controller.selectedMenu.value == 0){
      return viewEvent();
    }else if(controller.selectedMenu.value == 1){
      return viewParticipant();
    }
  }

}
