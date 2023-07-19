import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/ui/pages/register_event/review_register_event/review_participant_controller.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/item_list.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/category_register_event_model.dart';
import '../../../../core/models/objects/club_model.dart';
import '../../../../core/models/objects/profile_model.dart';

class ReviewParticipantScreen extends StatefulWidget {
  final List<ProfileModel> participants;
  final ClubModel selectedClub;
  final CategoryRegisterEventModel selectedCategory;
  final String type;
  final String teamName;
  const ReviewParticipantScreen({Key? key, required this.participants, required this.selectedClub, required this.selectedCategory,
    required this.type, required this.teamName}) : super(key: key);

  @override
  _ReviewParticipantScreenState createState() => _ReviewParticipantScreenState();
}

class _ReviewParticipantScreenState extends State<ReviewParticipantScreen> {

  var controller = ReviewParticipantController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterInit());
    super.initState();
  }

  afterInit(){
    controller.selectedClub.value = widget.selectedClub;
    controller.selectedCategory.value = widget.selectedCategory;
    controller.participants.addAll(widget.participants);
    controller.teamName.value = widget.teamName;
    controller.type.value = widget.type;
    controller.initController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      width: Get.width,
      child: SafeArea(
        child: WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            appBar: appBar("Detail Peserta", (){
              onWillPop();
            }),
            body: Obx(()=> Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: wValue(15), right: wValue(15), bottom: hValue(100)),
                  width: Get.width,
                  height: Get.height,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        hSpace(25),
                        Text("Data Pendaftar", style: boldTextFont.copyWith(fontSize: fontSize(18)),),
                        hSpace(25),
                        Text("Nama Pendaftar", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                        Text(controller.user.value.name ?? "-", style: boldTextFont.copyWith(fontSize: fontSize(12)),),

                        hSpace(15),
                        Text("Email", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                        Text(controller.user.value.email ?? "-", style: boldTextFont.copyWith(fontSize: fontSize(12)),),
                        hSpace(15),
                        Text("Nomor Telepon", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                        Text(controller.user.value.phoneNumber ?? "-", style: boldTextFont.copyWith(fontSize: fontSize(12)),),

                        hSpace(25),
                        Text("Data Peserta", style: boldTextFont.copyWith(fontSize: fontSize(18)),),
                        hSpace(25),
                        Text("Nama Klub", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                        Text(widget.selectedClub.detail == null ? "-" : "${widget.selectedClub.detail!.name}", style: boldTextFont.copyWith(fontSize: fontSize(12)),),
                        hSpace(25),

                        for(int i = 0; i < widget.participants.length; i++) Container(
                          child: itemPesertaOrderEvent(widget.participants[i], i+1),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(child: Container(
                  padding: EdgeInsets.all(wValue(15)),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Pembayaran ", style: boldTextFont.copyWith(fontSize: fontSize(12)),),
                          Text((widget.selectedCategory.isEarlyBird == 1) ?
                          "${formattingNumber(int.parse((widget.selectedCategory.earlyBird!.contains(".") ? widget.selectedCategory.earlyBird!.split(".").first : widget.selectedCategory.earlyBird! )))}" :
                          "${formattingNumber(int.parse((widget.selectedCategory.fee!.contains(".") ? widget.selectedCategory.fee!.split(".").first : widget.selectedCategory.fee! )))}", style: boldTextFont.copyWith(fontSize: fontSize(18), color: colorPrimary),),
                        ],
                      ),
                      hSpace(5),
                      if(widget.selectedCategory.isEarlyBird == 1) Container(
                        width: Get.width,
                        child: Text("${formattingNumber(int.parse((widget.selectedCategory.fee!.contains(".") ? widget.selectedCategory.fee!.split(".").first : widget.selectedCategory.fee! )))}", style: regularTextFont.copyWith(fontSize: fontSize(12), decoration: TextDecoration.lineThrough, color: gray400), textAlign: TextAlign.end,),
                      ),
                      hSpace(10),
                      Button(Translator.payNow.tr, colorPrimary, true, (){
                        controller.apiOrderEvent();
                      }, textSize: fontSize(14))
                    ],
                  ),
                ), bottom: 0,)
              ],
            )),
          ),

        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    if(widget.type == STR_INDIVIDU) {
      modalBottomPaymentNotComplete(onPaymentCLicked:(){
        controller.apiOrderEvent();
      },onCloseClicked: () {
        Get.back();
      });
    }else{
      Get.back();
    }
    return true;
  }
}

