import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/item/item_order_event.dart';
import 'package:myarchery_archer/ui/shared/item_list.dart';
import 'package:myarchery_archer/ui/shared/shimmer_loading.dart';

import '../../../../utils/utils.dart';
import '../../../shared/modal_bottom.dart';
import '../../detail_event/detail_event_screen.dart';
import '../../main/main_screen.dart';
import '../../main/profile/profile_controller.dart';
import '../../profile/verify/verify_screen.dart';
import '../../webview/webview_screen.dart';
import '../detail_event_order/detail_event_order_screen.dart';
import 'list_transaction_controller.dart';

class ListTransactionScreen extends StatefulWidget {
  final String? from;

  const ListTransactionScreen({Key? key, this.from}) : super(key: key);

  @override
  _ListTransactionScreenState createState() => _ListTransactionScreenState();
}

class _ListTransactionScreenState extends State<ListTransactionScreen> {
  var controller = ListTransactionController();
  var profileController = ProfileController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterInit());
    super.initState();
  }

  afterInit() {
    controller.initController();
    controller.apiGetListOrderV2();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Container(
        color: colorPrimary,
        child: SafeArea(
          child: Obx(() => WillPopScope(
              child: Scaffold(
                appBar: appBar("Riwayat Transaksi", () {
                  onWillPop();
                }),
                body: Column(
                  children: [
                    hSpace(15),
                    Container(
                      width: Get.width,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            wSpace(15),
                            for (var item in controller.statusPayments)
                              itemStatusPayment(item,
                                  controller.selectedStatus.value.id == item.id,
                                      () {
                                    controller.selectedStatus.value = item;
                                    controller.orders.clear();
                                    controller.apiGetListOrderV2();
                                  }),
                            wSpace(15),
                          ],
                        ),
                      ),
                    ),
                    hSpace(15),
                    controller.isLoading.value
                        ? showShimmerList()
                        : Expanded(
                      child: controller.orders.isEmpty
                          ? viewEmpty()
                          : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        child: Column(
                          children: [
                            for (var item in controller.orders)
                              ItemOrderEvent(
                                onClick: () {
                                  if (!item.transactionLogInfo
                                  is List) {
                                    if (item.transactionLogInfo!
                                        .statusId ==
                                        2) {
                                      //DAFTAR ULANG
                                      goToPage(DetailEventScreen(
                                          event: item.detailEvent!));
                                    } else if (item
                                        .transactionLogInfo!
                                        .statusId ==
                                        4) {
                                      if (controller.user.value
                                          .verifyStatus ==
                                          KEY_VERIFY_ACC_UNVERIFIED ||
                                          controller.user.value
                                              .verifyStatus ==
                                              KEY_VERIFY_ACC_REJECTED) {
                                        modalBottomVerifyAccountHaveTransaction(
                                            content: controller
                                                .user
                                                .value
                                                .verifyStatus ==
                                                KEY_VERIFY_ACC_UNVERIFIED
                                                ? str_unverified_acc_payment
                                                : str_rejected_acc,
                                            onVerifyClicked:
                                                () async {
                                              final result =
                                              await goToPageWithResult(
                                                  VerifyScreen());
                                              if (result != null)
                                                profileController
                                                    .apiProfile(
                                                    onFinish: () {
                                                      controller
                                                          .getCurrentUser();
                                                    });
                                            },
                                            onLater: () {});
                                      } else if (controller.user.value
                                          .verifyStatus ==
                                          KEY_VERIFY_ACC_SENT) {
                                        modalBottomVerifySent(
                                            content:
                                            "Terima kasih telah melengkapi data. Data Anda akan diverifikasi dalam 1x24 jam. Proses pembayaran dapat dilakukan setelah akun terverifikasi");
                                      } else {
                                        //BAYAR
                                        goToPage(WebviewScreen(
                                          title: "Pembayaran Event",
                                          url:
                                          "$urlMidtransSnap${item.transactionLogInfo!.snapToken}",
                                          from: "list_order_event",
                                        ));
                                      }
                                    } else {
                                      goToPage(DetailEventOrderScreen(
                                        paramData: item.detailOrder!,
                                      ));
                                    }
                                  }
                                },
                                item: item,
                              )
                          ],
                        ),
                      ),
                      flex: 1,
                    )
                  ],
                ),
              ),
              onWillPop: onWillPop)),
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    if (widget.from != null) {
      if (widget.from == key_order_event_page) {
        goToPage(MainScreen(), dismissAllPage: true);
      }
    } else {
      Navigator.pop(context, true);
    }
    return true;
  }
}
