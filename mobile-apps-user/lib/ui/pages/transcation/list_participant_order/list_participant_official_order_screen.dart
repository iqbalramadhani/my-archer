import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/core/models/objects/member_club_model.dart';
import 'package:myarchery_archer/core/models/objects/transaction_info_model.dart';
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
import '../../main/main_screen.dart';
import '../../main/profile/profile_controller.dart';
import '../../profile/verify/verify_screen.dart';
import '../../webview/webview_screen.dart';

class ListParticipantOfficialOrderScreen extends StatefulWidget {
  final TransactionInfoModel? transactionInfo;
  final MemberClubModel? user;
  final String? club;

  const ListParticipantOfficialOrderScreen({Key? key, required this.transactionInfo, required this.user, required this.club,
  })
      : super(key: key);

  @override
  _ListParticipantOfficialOrderScreenState createState() =>
      _ListParticipantOfficialOrderScreenState();
}

class _ListParticipantOfficialOrderScreenState
    extends State<ListParticipantOfficialOrderScreen> {

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
                          widget.user!.name ?? "",
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
                          widget.user!.email ?? "-",
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
                          widget.user!.phoneNumber ?? "-",
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
                        Text("${widget.club}",
                          style:
                          boldTextFont.copyWith(fontSize: fontSize(12)),
                        ),
                        hSpace(25),
                        Container(
                          child: itemPesertaOrderEvent(
                              ProfileModel(
                                  id: 0,
                                  avatar: null,
                                  name: widget.user!.name,
                                  gender: widget.user!.gender,
                                  email: widget.user!.email,
                                  age: widget.user!.age,
                                  dateOfBirth: widget.user!.dateOfBirth,
                                  createdAt: widget.user!.createdAt,
                                  eoId: 0,
                                  phoneNumber: widget.user!.phoneNumber,
                                  placeOfBirth: null,
                                  updatedAt: ""
                              ), 1),
                        )

                      ],
                    ),
                  ),
                ),
                if(widget.transactionInfo!.statusId == KEY_PAYMENT_PENDING) Positioned(
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
                              "${formattingNumber(widget.transactionInfo!.total)}",
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
                            goToPage(WebviewScreen(title: "Pembayaran Event", url: "$urlMidtransSnap${widget.transactionInfo!.snapToken}", from: "order_event",));
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
    if(widget.transactionInfo!.statusId == KEY_PAYMENT_PENDING){
      modalBottomPaymentNotComplete(onPaymentCLicked: () {
        goToPage(WebviewScreen(title: "Pembayaran Event", url: "$urlMidtransSnap${widget.transactionInfo!.snapToken}", from: "list_participant_order_event",));
      }, btnNo: "Lihat Daftar Transaksi", onCloseClicked: () {
        Get.back();
      });
    }else{
      Get.back();
    }
    return true;
  }
}
