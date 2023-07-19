import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/models/objects/transaction_info_model.dart';
import '../../../core/models/response/v2/order_all_response.dart';
import '../../../utils/utils.dart';
import '../../pages/transcation/detail_event_order/detail_event_order_screen.dart';
import '../button.dart';

class ItemOrderEvent extends StatelessWidget {
  final DataOrderAllModel item;
  final Function onClick;
  const ItemOrderEvent({Key? key, required this.item, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataOrderAllModel data = DataOrderAllModel();
    TransactionInfoModel transactionInfoModel = TransactionInfoModel();
    if(item.transactionLogInfo is List){
      return Container();
    }else{
      data = DataOrderAllModel(
          detailOrder: item.detailOrder,
          detailEvent: item.detailEvent,
        category: item.category
      );

      transactionInfoModel = TransactionInfoModel(
          orderId: item.transactionLogInfo['orderId'],
          statusId: item.transactionLogInfo['statusId'],
          status: item.transactionLogInfo['status'],
          total: item.transactionLogInfo['total'],
          transactionLogId: item.transactionLogInfo['transactionLogId'],
          snapToken: item.transactionLogInfo['snapToken'],
          clientKey: item.transactionLogInfo['clientKey'],
          clientLibLink: item.transactionLogInfo['clientLibLink'],
          orderDate: OrderDateModel(date: item.transactionLogInfo['orderDate']['date'])
      );

    }


    Color textColor = gray400;
    Color bgColor = gray80;
    if (transactionInfoModel.statusId == KEY_PAYMENT_PENDING) {
      textColor = colorSecondary;
      bgColor = colorSecondary50;
    } else if (transactionInfoModel.statusId == KEY_PAYMENT_EXPIRED ||
        transactionInfoModel.statusId == KEY_PAYMENT_FAILED) {
      textColor = gray400;
      bgColor = gray80;
    } else if (transactionInfoModel.statusId == KEY_PAYMENT_SETTLEMENT) {
      textColor = green400;
      bgColor = green100;
    }
    return Container(
      decoration: new BoxDecoration(
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
      child: InkWell(
        child: Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(wValue(8))),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.detailEvent == null ? "-" : "${data.detailEvent!.eventName}",
                            style: boldTextFont.copyWith(fontSize: fontSize(12)),
                          ),
                          Text(
                            data.detailEvent == null ? "-" : "${data.detailEvent!.eventCompetition}",
                            style: regularTextFont.copyWith(fontSize: fontSize(12)),
                          ),
                        ],
                      ),
                      flex: 1,
                    ),
                    wSpace(10),
                    labelView(
                        "${transactionInfoModel.status}", textColor, bgColor)
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    imageRadius(data.detailEvent == null ? "-" : "${data.detailEvent!.poster}", wValue(74),
                        hValue(74), wValue(12)),
                    wSpace(10),
                    Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/ic_users.svg",
                                      color: gray400,
                                      width: wValue(15),
                                    ),
                                    wSpace(5),
                                    Text(
                                      (data.detailOrder!.type == "official")
                                          ? "Official"
                                          : "${convertTeamCategory(data.category!.teamCategoryId!)}",
                                      style: regularTextFont.copyWith(
                                          fontSize: fontSize(12)),
                                    ),
                                  ],
                                ),
                                wSpace(10),
                                if(data.detailOrder!.type == "event") Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/ic_archer.svg",
                                      color: gray400,
                                      width: wValue(15),
                                    ),
                                    wSpace(5),
                                    Text(
                                       "${data.category!.competitionCategoryId!}",
                                      style: regularTextFont.copyWith(
                                          fontSize: fontSize(12)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            hSpace(5),
                            if(data.detailOrder!.type == "event") Text(
                              "${data.category!.label}",
                              style: boldTextFont.copyWith(fontSize: fontSize(14)),
                            ),
                            hSpace(5),
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/ic_location_black.svg"),
                                wSpace(5),
                                Text(
                                  data.detailEvent == null ? "-" : data.detailEvent!.detailCity != null
                                      ? "${data.detailEvent!.detailCity!.name}"
                                      : "-",
                                  style: regularTextFont.copyWith(
                                      fontSize: fontSize(12)),
                                ),
                              ],
                            )
                          ],
                        ))
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        transactionInfoModel.total == null ? formattingNumber(0) : "${formattingNumber(transactionInfoModel.total)}",
                        style: boldTextFont.copyWith(
                            fontSize: fontSize(14), color: colorPrimary),
                      ),
                      flex: 1,
                    ),
                    Button(
                        transactionInfoModel.statusId == 1
                            ? "Lihat Detail"
                            : transactionInfoModel.statusId == 2
                            ? "Daftar Ulang"
                            : transactionInfoModel.statusId == 4
                            ? "Bayar"
                            : "Lihat Detail",
                        colorPrimary,
                        true, () {
                      onClick();
                    },
                        height: hValue(36),
                        textSize: fontSize(14),
                        fontColor: Colors.white)
                  ],
                )
              ],
            ),
            margin: EdgeInsets.all(wValue(8)),
            padding: EdgeInsets.all(wValue(10)),
          ),
        ),
        onTap: () {
          Get.to(DetailEventOrderScreen(
            paramData: data.detailOrder!,
          ));
        },
      ),
      margin:
      EdgeInsets.only(left: hValue(10), bottom: hValue(10), top: hValue(5)),
    );
  }
}
