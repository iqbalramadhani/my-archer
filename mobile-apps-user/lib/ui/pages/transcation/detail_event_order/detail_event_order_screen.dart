import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';
import 'package:myarchery_archer/ui/shared/shimmer_loading.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../../../../core/models/response/v2/order_all_response.dart';
import '../../../../utils/strings.dart';
import '../../main/profile/profile_controller.dart';
import '../../profile/verify/verify_screen.dart';
import '../../webview/webview_screen.dart';
import '../list_participant_order/list_participant_event_order_screen.dart';
import '../list_participant_order/list_participant_official_order_screen.dart';
import 'detail_event_order_controller.dart';

class DetailEventOrderScreen extends StatefulWidget {
  final DetailOrderModel paramData;

  const DetailEventOrderScreen({Key? key, required this.paramData})
      : super(key: key);

  @override
  _DetailEventOrderScreenState createState() => _DetailEventOrderScreenState();
}

class _DetailEventOrderScreenState extends State<DetailEventOrderScreen> {
  var controller = DetailEventOrderController();
  var profileController = ProfileController();

  @override
  void initState() {
    controller.paramOrder.value = widget.paramData;
    controller.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Container(
        width: Get.width,
        color: colorPrimary,
        child: SafeArea(
          child: Obx(() => WillPopScope(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: appBar("Detail Pembayaran", () {
                onWillPop();
              }),
              body: controller.isLoading.value
                  ? showShimmerList()
                  : controller.dataNotFound.value
                  ? Center(
                child: Text(
                  "Data tidak ditemukan",
                  style:
                  boldTextFont.copyWith(fontSize: fontSize(13)),
                ),
              )
                  : Stack(
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
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/icons/ic_date.svg"),
                                      wSpace(5),
                                      Text((controller.dateOrder.value.isNotEmpty) ? "${convertDateFormat("yyyy-MM-dd HH:mm:ss", "dd MMM yyyy", controller.dateOrder.value)}" : "")
                                    ],
                                  ),
                                  flex: 1,
                                ),
                                Text(
                                  "${controller.orderId.value}",
                                ),
                              ],
                            ),
                            hSpace(20),
                            Row(
                              children: [
                                imageRadius(
                                    "${controller.eventPoster.value}", wValue(56), hValue(50), wValue(4)),
                                wSpace(10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${controller.eventName.value}",
                                        style: boldTextFont.copyWith(fontSize: fontSize(16)),
                                      ),
                                      hSpace(3),
                                      Text(
                                        "${controller.location.value}",
                                        style: regularTextFont.copyWith(fontSize: fontSize(12)),
                                      ),
                                    ],
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                            hSpace(10),
                            Divider(
                              color: Color(0xFFC4C4C4),
                            ),
                            hSpace(10),
                            Text("Jenis Regu", style: regularTextFont.copyWith(fontSize: fontSize(12)),
                            ),
                            hSpace(3),
                            Text("${controller.jenisRegu.value}", style: boldTextFont.copyWith(fontSize: fontSize(12)),
                            ),
                            hSpace(15),
                            Text("Kategori", style: regularTextFont.copyWith(fontSize: fontSize(12)),
                            ),
                            hSpace(3),
                            Text("${controller.category.value}", style: boldTextFont.copyWith(fontSize: fontSize(12)),
                            ),
                            hSpace(15),
                            Text("Nama Klub", style: regularTextFont.copyWith(fontSize: fontSize(12)),
                            ),
                            hSpace(3),
                            Text("${controller.clubName.value}", style: boldTextFont.copyWith(fontSize: fontSize(12)),
                            ),
                            hSpace(25),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Color(0xFFE0E0E0)),
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(wValue(15)),
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/icons/ic_address_book.svg"),
                                    wSpace(10),
                                    Expanded(
                                      child: Text("Detail Peserta", style: boldTextFont.copyWith(fontSize: fontSize(12)),
                                      ),
                                      flex: 1,
                                    ),
                                    SvgPicture.asset("assets/icons/ic_circle_arrow_nomargin.svg"),
                                  ],
                                ),
                              ),
                              onTap: () {
                                if(widget.paramData.type == "official"){
                                  goToPage(ListParticipantOfficialOrderScreen(
                                    club: controller.clubName.value,
                                    transactionInfo: controller.transactionLog.value,
                                    user: controller.currentRespOfficial.value.data!.detailUser,
                                  ));
                                }else{
                                  goToPage(ListParticipantEventOrderScreen(data: controller.currentResp.value));
                                }

                              },
                            )
                          ],
                        ),
                        margin: EdgeInsets.all(wValue(25)),
                      ),
                    ),
                  ),
                  if (controller.transactionLog.value.statusId == KEY_PAYMENT_PENDING)
                    viewButton(),
                ],
              ),
            ),
            onWillPop: onWillPop,
          )),
        ),
      ),
    );
  }

  viewButton() {
    return Positioned(
      child: Container(
        padding: EdgeInsets.all(wValue(15)),
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
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
                  style: boldTextFont.copyWith(fontSize: fontSize(12)),
                ),
                // Text("${formattingNumber(int.parse((widget.selectedCategory.fee!.contains(".") ? widget.selectedCategory.fee!.split(".").first : widget.selectedCategory.fee! )))}", style: boldTextFont.copyWith(fontSize: fontSize(18), color: colorPrimary),),
              ],
            ),
            hSpace(10),
            Button(Translator.payNow.tr, colorPrimary, true, () {
              if (controller.user.value.verifyStatus ==
                      KEY_VERIFY_ACC_REJECTED ||
                  controller.user.value.verifyStatus ==
                      KEY_VERIFY_ACC_UNVERIFIED) {
                modalBottomVerifyAccountHaveTransaction(
                    content: controller.user.value.verifyStatus ==
                            KEY_VERIFY_ACC_UNVERIFIED
                        ? str_unverified_acc_w_transaction
                        : str_rejected_acc,
                    onVerifyClicked: () async {
                      final result = await goToPageWithResult(VerifyScreen());
                      if (result != null)
                        profileController.apiProfile(onFinish: () {
                          controller.getCurrentUser();
                        });
                    },
                    onLater: () {});
              } else if (controller.user.value.verifyStatus ==
                  KEY_VERIFY_ACC_SENT) {
                modalBottomVerifySent(
                    content:
                        "Terima kasih telah melengkapi data. Data Anda akan diverifikasi dalam 1x24 jam. Proses pembayaran dapat dilakukan setelah akun terverifikasi");
              } else {
                goToPage(WebviewScreen(
                  title: "Pembayaran Event",
                  url:
                      "$urlMidtransSnap${controller.transactionLog.value.snapToken}",
                  from: "detail_order_event",
                ));
              }
            }, textSize: fontSize(14))
          ],
        ),
      ),
      bottom: 0,
    );
  }

  Future<bool> onWillPop() async {
    if (controller.dataNotFound.value) {
      Get.back();
    } else {
      if (controller.transactionLog.value.statusId ==
          KEY_PAYMENT_PENDING) {
        modalBottomPaymentNotComplete(
            onPaymentCLicked: () {
              goToPage(WebviewScreen(
                title: "Pembayaran Event",
                url:
                    "$urlMidtransSnap${controller.transactionLog.value.snapToken}",
                from: "detail_order_event",
              ));
            },
            btnNo: "Lihat Daftar Transaksi",
            onCloseClicked: () {
              Get.back();
            });
      } else {
        Get.back();
      }
    }
    return true;
  }
}
