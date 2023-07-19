import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/item_list.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/objects/profile_model.dart';
import '../../../../core/models/response/detail_event_order_response.dart';
import '../../main/main_screen.dart';
import '../../main/profile/profile_controller.dart';
import '../../profile/verify/verify_screen.dart';
import '../../webview/webview_screen.dart';

class ListParticipantEventOrderScreen extends StatefulWidget {
  final DetailEventOrderResponse data;

  const ListParticipantEventOrderScreen({Key? key, required this.data})
      : super(key: key);

  @override
  _ListParticipantEventOrderScreenState createState() =>
      _ListParticipantEventOrderScreenState();
}

class _ListParticipantEventOrderScreenState
    extends State<ListParticipantEventOrderScreen> {

  var controller = ProfileController();

  @override
  void initState() {
    controller.initController();
    super.initState();
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
            appBar: appBar("Detail Peserta", () {
              onWillPop();
            }),
            body: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: wValue(15),
                      right: wValue(15),
                      bottom: hValue(100)),
                  width: Get.width,
                  height: Get.height,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        hSpace(25),
                        Text(
                          "Data Pendaftar",
                          style:
                          boldTextFont.copyWith(fontSize: fontSize(18)),
                        ),
                        hSpace(25),
                        Text(
                          "Nama Pendaftar",
                          style: regularTextFont.copyWith(
                              fontSize: fontSize(12)),
                        ),
                        Text(
                          widget.data.data!.participant!.name ?? "",
                          style:
                          boldTextFont.copyWith(fontSize: fontSize(12)),
                        ),
                        hSpace(15),
                        Text(
                          "Email",
                          style: regularTextFont.copyWith(
                              fontSize: fontSize(12)),
                        ),
                        Text(
                          widget.data.data!.participant!.email ?? "-",
                          style:
                          boldTextFont.copyWith(fontSize: fontSize(12)),
                        ),
                        hSpace(15),
                        Text(
                          "Nomor Telepon",
                          style: regularTextFont.copyWith(
                              fontSize: fontSize(12)),
                        ),
                        Text(
                          widget.data.data!.participant!.phoneNumber ?? "-",
                          style:
                          boldTextFont.copyWith(fontSize: fontSize(12)),
                        ),
                        hSpace(25),
                        Text(
                          "Data Peserta",
                          style:
                          boldTextFont.copyWith(fontSize: fontSize(18)),
                        ),
                        hSpace(25),
                        Text(
                          "Nama Klub",
                          style: regularTextFont.copyWith(
                              fontSize: fontSize(12)),
                        ),
                        Text((widget.data.data!.participant!.clubDetail == null) ? "-" :
                          "${widget.data.data!.participant!.clubDetail!.name}",
                          style:
                          boldTextFont.copyWith(fontSize: fontSize(12)),
                        ),
                        hSpace(25),
                        for (int i = 0; i < widget.data.data!.participant!.members!.length; i++)
                          Container(
                            child: itemPesertaOrderEvent(
                                ProfileModel(
                                    id: widget.data.data!.participant!.members![i].id,
                                    avatar: null,
                                    name: widget.data.data!.participant!.members![i].name,
                                    gender: widget.data.data!.participant!.members![i].gender,
                                    email: widget.data.data!.participant!.members![i].email,
                                    age: widget.data.data!.participant!.members![i].age,
                                    dateOfBirth: widget.data.data!.participant!.members![i].birthdate,
                                    createdAt: widget.data.data!.participant!.members![i].createdAt,
                                    eoId: 0,
                                    phoneNumber: widget.data.data!.participant!.members![i].phoneNumber,
                                    placeOfBirth: null,
                                    updatedAt: widget.data.data!.participant!.members![i].updatedAt
                                ), i + 1),
                          )
                      ],
                    ),
                  ),
                ),
                if(widget.data.data!.transactionInfo!.statusId == KEY_PAYMENT_PENDING) Positioned(
                  child: Container(
                    padding: EdgeInsets.all(wValue(15)),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
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
                            Text(
                              "Total Pembayaran",
                              style: boldTextFont.copyWith(
                                  fontSize: fontSize(12)),
                            ),
                            Text(
                              "${formattingNumber(widget.data.data!.transactionInfo!.total)}",
                              style: boldTextFont.copyWith(
                                  fontSize: fontSize(18),
                                  color: colorPrimary),
                            ),
                          ],
                        ),
                        hSpace(10),
                        Button(Translator.payNow.tr, colorPrimary, true, () {
                          if(controller.user.value.verifyStatus == KEY_VERIFY_ACC_REJECTED || controller.user.value.verifyStatus == KEY_VERIFY_ACC_UNVERIFIED || controller.user.value.verifyStatus == KEY_VERIFY_ACC_SENT){
                            modalBottomVerifyAccountHaveTransaction(onVerifyClicked: () async {
                              final result = await goToPageWithResult(VerifyScreen());
                              if(result != null) controller.apiProfile();
                            }, onLater: (){
                              goToPage(MainScreen(), dismissAllPage: true);
                            });
                          }else{
                            goToPage(WebviewScreen(title: "Pembayaran Event", url: "$urlMidtransSnap${widget.data.data!.transactionInfo!.snapToken}", from: "order_event",));
                          }
                        }, textSize: fontSize(14))
                      ],
                    ),
                  ),
                  bottom: 0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    if(widget.data.data!.transactionInfo!.statusId == KEY_PAYMENT_PENDING){
      modalBottomPaymentNotComplete(onPaymentCLicked: () {
        goToPage(WebviewScreen(title: "Pembayaran Event", url: "$urlMidtransSnap${widget.data.data!.transactionInfo!.snapToken}", from: "list_participant_order_event",));
      }, btnNo: "Lihat Daftar Transaksi", onCloseClicked: () {
        Get.back();
      });
    }else{
      Get.back();
    }
    return true;
  }
}
