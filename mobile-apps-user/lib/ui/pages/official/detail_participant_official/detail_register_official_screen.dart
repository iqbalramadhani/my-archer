import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/core/models/objects/event_model.dart';
import 'package:myarchery_archer/core/models/response/detail_official_response.dart';
import 'package:myarchery_archer/ui/pages/official/detail_participant_official/detail_register_official_controller.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/dialog.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/category_register_event_model.dart';
import '../../../../core/models/objects/club_model.dart';
import '../../../shared/appbar.dart';

class DetailRegisterOfficialScreen extends StatefulWidget {
  final CategoryRegisterEventModel selectedCategory;
  final ClubModel selectedClub;
  final EventModel event;
  final DataDetailOfficialModel official;

  const DetailRegisterOfficialScreen({Key? key, required this.event, required this.selectedClub, required this.selectedCategory, required this.official}) : super(key: key);

  @override
  _DetailRegisterOfficialScreenState createState() => _DetailRegisterOfficialScreenState();
}

class _DetailRegisterOfficialScreenState extends State<DetailRegisterOfficialScreen> {

  var controller = DetailRegisterOfficialController();
  @override
  void initState() {
    controller.selectedClub.value = widget.selectedClub;
    controller.official.value = widget.official;
    controller.selectedCategory.value = widget.selectedCategory;
    controller.currentData.value = widget.event;

    controller.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Container(
        color: colorPrimary,
        width: Get.width,
        height: Get.height,
        child: SafeArea(
          child: Obx(()=> Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar("Detail Pembayaran", (){
              Get.back();
            }, bgColor: colorPrimary, textColor: Colors.white, iconColor: Colors.white),
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            imageRadius("${widget.event.poster}", wValue(50), hValue(50), wValue(5)),
                            wSpace(10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${widget.event.eventName}", style: boldTextFont.copyWith(fontSize: fontSize(14)),),
                                Text("${widget.event.location}", style: regularTextFont.copyWith(fontSize: fontSize(14)),),
                              ],
                            )
                          ],
                        ),
                        hSpace(5),
                        Divider(
                          thickness: wValue(1),
                        ),
                        hSpace(5),

                        itemValue(title: "Kategori", value: "Official"),
                        hSpace(15),
                        itemValue(title: "Kategori Pertandingan", value: "${widget.selectedCategory.categoryLabel}"),
                        hSpace(15),
                        Divider(
                          thickness: wValue(1),
                        ),
                        hSpace(5),

                        Text("Data Pendaftar", style: boldTextFont.copyWith(fontSize: fontSize(18)),),
                        hSpace(15),
                        itemValue(title: "Nama Pendaftar", value: "${controller.user.value.name}"),
                        hSpace(15),
                        itemValue(title: "Email", value: "${controller.user.value.email}"),
                        hSpace(15),
                        itemValue(title: "No. Telepon", value: "${controller.user.value.phoneNumber ?? "-"}"),
                        hSpace(15),


                        Text("Data Official", style: boldTextFont.copyWith(fontSize: fontSize(18)),),
                        hSpace(15),
                        itemValue(title: "Nama Klub", value: "${controller.selectedClub.value.detail!.name}"),
                        hSpace(15),

                        viewPesertaOfficial(),

                        hSpace(100)

                      ],
                    ),
                    padding: EdgeInsets.all(wValue(25)),
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
                          Text("${formattingNumber(int.parse(getPrice(widget.official.eventOfficialDetail!.fee ?? "0")))}", style: boldTextFont.copyWith(fontSize: fontSize(18), color: colorPrimary),),
                        ],
                      ),
                      hSpace(5),
                      if(widget.selectedCategory.isEarlyBird == 1) Container(
                        width: Get.width,
                        child: Text("${formattingNumber(int.parse((widget.selectedCategory.fee!.contains(".") ? widget.selectedCategory.fee!.split(".").first : widget.selectedCategory.fee! )))}", style: regularTextFont.copyWith(fontSize: fontSize(12), decoration: TextDecoration.lineThrough, color: gray400), textAlign: TextAlign.end,),
                      ),
                      hSpace(10),
                      Button(Translator.payNow.tr, colorPrimary, true, (){
                        showConfirmDialog(Get.context!, assets: "assets/icons/ic_alert.svg", typeAsset: "svg", showIcon: true, content: "Apakah data pemesanan Anda sudah benar?", btn1: "Cek Lagi", btn3: "Sudah Benar",
                            onClickBtn1: (){}, onClickBtn3: (){
                              controller.apiOrderOfficial();
                            });
                      }, textSize: fontSize(14))
                    ],
                  ),
                ), bottom: 0,)
              ],
            ),
          )),
        ),
      ),
    );
  }

  viewPesertaOfficial(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: blue50,
            ),
            padding: EdgeInsets.all(wValue(10)),
            child: Text("Official 1", style: boldTextFont.copyWith(fontSize: fontSize(12)),),
          ),
          hSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              circleAvatar("${controller.user.value.avatar}", wValue(72), hValue(70)),
              wSpace(15),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${controller.user.value.name}", style: boldTextFont.copyWith(fontSize: fontSize(12))),
                  hSpace(5),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/ic_email.svg", width: wValue(16), color: gray400,),
                      wSpace(5),
                      Text(controller.user.value.email ?? "-", style: regularTextFont.copyWith(fontSize: fontSize(12)))
                    ],
                  ),
                  hSpace(5),
                  Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/ic_gender.svg", width: wValue(16), color: gray400,),
                          wSpace(5),
                          Text(controller.user.value.gender ?? "-", style: regularTextFont.copyWith(fontSize: fontSize(12))),
                        ],
                      ),
                      wSpace(10),
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/ic_user.svg", width: wValue(16), color: gray400,),
                          wSpace(5),
                          Text(controller.user.value.age.toString(), style: regularTextFont.copyWith(fontSize: fontSize(12))),
                        ],
                      ),
                    ],
                  ),
                ],
              ), flex: 1,)
            ],
          )
        ],
      ),
      margin: EdgeInsets.only(bottom: hValue(15)),
    );
  }

  itemValue({required String title, required String value}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
        hSpace(5),
        Text("$value", style: boldTextFont.copyWith(fontSize: fontSize(14)),),
      ],
    );
  }
}
