import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/category_register_event_model.dart';
import '../../../../core/models/objects/club_model.dart';
import '../../../../core/models/objects/event_model.dart';
import '../../../../core/models/objects/profile_model.dart';
import '../review_register_event/review_participant_controller.dart';
import '../review_register_event/review_participant_screen.dart';

class ReviewDetailPaymentScreen extends StatefulWidget {
  final List<ProfileModel> participants;
  final EventModel event;
  final ClubModel selectedClub;
  final CategoryRegisterEventModel selectedCategory;
  final String type;
  final String teamName;
  const ReviewDetailPaymentScreen({Key? key, required this.participants, required this.event, required this.selectedClub, required this.selectedCategory,
    required this.type, required this.teamName}) : super(key: key);

  @override
  _ReviewDetailPaymentScreenState createState() => _ReviewDetailPaymentScreenState();
}

class _ReviewDetailPaymentScreenState extends State<ReviewDetailPaymentScreen> {

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
    return BaseContainer(
      child: Container(
        width: Get.width,
        color: colorPrimary,
        child: SafeArea(
          child: WillPopScope(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: appBar("Detail Pembayaran", (){
                onWillPop();
              }),
              body: Stack(
                children: [
                  Container(
                    width: Get.width,
                    height: Get.height,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row(
                            //   children: [
                            //     Expanded(child: Row(children: [
                            //       SvgPicture.asset("assets/icons/ic_date.svg"),
                            //       Text("02/02/2022")
                            //     ],), flex: 1,),
                            //     Text("${widget.selectedCategory.eventId}"),
                            //   ],
                            // ),
                            Row(
                              children: [
                                imageRadius("${widget.event.poster}", wValue(56), hValue(50), wValue(4)),
                                wSpace(10),
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${widget.event.eventName}", style: boldTextFont.copyWith(fontSize: fontSize(16)),),
                                    hSpace(3),
                                    Text("${widget.event.location} - ${widget.event.locationType}", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                                  ],
                                ), flex: 1,),
                              ],
                            ),
                            hSpace(10),
                            Divider(
                              color: Color(0xFFC4C4C4),
                            ),
                            hSpace(10),
                            Text("Jenis Regu", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                            hSpace(3),
                            Text("${widget.selectedCategory.teamCategoryDetail!.label}", style: boldTextFont.copyWith(fontSize: fontSize(12)),),

                            hSpace(15),
                            Text("Kategori", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                            hSpace(3),
                            Text("${widget.selectedCategory.categoryLabel}", style: boldTextFont.copyWith(fontSize: fontSize(12)),),

                            hSpace(15),
                            Text("Nama Klub", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                            hSpace(3),
                            Text("${widget.selectedClub.detail!.name}", style: boldTextFont.copyWith(fontSize: fontSize(12)),),

                            hSpace(25),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Color(0xFFE0E0E0)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(wValue(15)),
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/icons/ic_address_book.svg"),
                                    wSpace(10),
                                    Expanded(child: Text("Detail Peserta", style: boldTextFont.copyWith(fontSize: fontSize(12)),), flex: 1,),
                                    SvgPicture.asset("assets/icons/ic_circle_arrow_nomargin.svg"),
                                  ],
                                ),
                              ),
                              onTap: (){
                                goToPage(ReviewParticipantScreen(
                                    participants: widget.participants,
                                    selectedClub: widget.selectedClub,
                                    selectedCategory: widget.selectedCategory,
                                    type: widget.type,
                                    teamName: widget.teamName));
                              },
                            )

                          ],
                        ),
                        margin: EdgeInsets.all(wValue(25)),
                      ),
                    ),
                  ),
                  viewButton(),
                ],
              ),
            ),
            onWillPop: onWillPop,
          ),
        ),
      ),
    );
  }

  viewButton(){
    return Positioned(child: Container(
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
              Text("Total Pembayaran", style: boldTextFont.copyWith(fontSize: fontSize(12)),),
              Text("${formattingNumber(int.parse((widget.selectedCategory.fee!.contains(".") ? widget.selectedCategory.fee!.split(".").first : widget.selectedCategory.fee! )))}", style: boldTextFont.copyWith(fontSize: fontSize(18), color: colorPrimary),),
            ],
          ),
          hSpace(10),
          Button(Translator.payNow.tr, colorPrimary, true, (){
            controller.apiOrderEvent();
          }, textSize: fontSize(14))
        ],
      ),
    ), bottom: 0,);
  }

  Future<bool> onWillPop() async {
    modalBottomPaymentNotComplete(onPaymentCLicked:(){
      controller.apiOrderEvent();
    },onCloseClicked: () {
      Get.back();
    });
    return true;
  }
}
