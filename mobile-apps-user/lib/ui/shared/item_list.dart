import 'dart:ui';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/core/models/response/v2/order_all_response.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../core/models/objects/category_detail_model.dart';
import '../../core/models/objects/category_model.dart';
import '../../core/models/objects/category_register_event_model.dart';
import '../../core/models/objects/club_model.dart';
import '../../core/models/objects/event_model.dart';
import '../../core/models/objects/master_category_register_event_model.dart';
import '../../core/models/objects/member_club_model.dart';
import '../../core/models/objects/profile_model.dart';
import '../../core/models/objects/region_model.dart';
import '../../core/models/objects/team_category_detail.dart';
import '../../core/models/objects/transaction_info_model.dart';
import '../../core/models/objects/v2/event_price_model.dart';
import '../../core/models/response/detail_event_response.dart';
import '../../core/models/response/event_order_response.dart';
import '../pages/detail_event/detail_event_screen.dart';
import '../pages/feature_club/detail_club/detail_club_screen.dart';
import '../pages/transcation/detail_event_order/detail_event_order_screen.dart';

itemLomba() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID ORDER : OE-MA75",
              style: regularTextFont.copyWith(
                  fontSize: fontSize(12), color: gray600),
            ),
            hSpace(8),
            Text(
              "Jakarta Archery 2021",
              style: boldTextFont.copyWith(fontSize: fontSize(14)),
            ),
            hSpace(8),
            Card(
              color: Color(0xFFBCD3F6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(wValue(7))),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.only(
                    left: wValue(15),
                    right: wValue(15),
                    top: wValue(5),
                    bottom: wValue(5)),
                child: Text(
                  "Pilih Metode Pembayaran 00:51:13",
                  style: regularTextFont.copyWith(
                      fontSize: fontSize(10), color: colorAccentDark),
                ),
              ),
            )
          ],
        ),
        flex: 1,
      ),
      Icon(
        Icons.arrow_forward_ios_outlined,
        color: gray600,
      )
    ],
  );
}

itemEvent(EventModel data) {
  return Container(
    width: wValue(230),
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
              Hero(
                child: imageRadius(
                    "${data.poster}", Get.width, hValue(110), wValue(8),
                    boxFit: BoxFit.fitWidth),
                tag: data.id!,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hSpace(6),
                  Card(
                    color: Color(0xFFFFCF70),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(wValue(10))),
                    child: Container(
                      padding: EdgeInsets.all(wValue(5)),
                      child: Text(
                        "${data.eventCompetition}",
                        style: regularTextFont.copyWith(fontSize: fontSize(10)),
                        maxLines: 2,
                      ),
                    ),
                  ),
                  hSpace(8),
                  Text(
                    "${data.eventName}",
                    style: boldTextFont.copyWith(
                        fontSize: fontSize(14), color: Colors.black),
                    maxLines: 2,
                  ),
                  hSpace(8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/ic_location.svg",
                        color: colorAccent,
                      ),
                      wSpace(5),
                      Expanded(
                          child: Text(
                        "${data.location}",
                        style: regularTextFont.copyWith(fontSize: fontSize(12)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                  hSpace(8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/ic_date.svg",
                        color: colorAccent,
                      ),
                      wSpace(5),
                      Text(
                        "${convertDateFormat("yyyy-MM-dd HH:mm:ss", "dd MMMM yyyy", data.eventStartDatetime!)}",
                        style: regularTextFont.copyWith(fontSize: fontSize(12)),
                      ),
                    ],
                  ),
                  hSpace(10),
                ],
              )
            ],
          ),
          margin: EdgeInsets.all(wValue(8)),
        ),
      ),
      onTap: () {
        Get.to(DetailEventScreen(
          event: data,
        ));
      },
    ),
    margin:
        EdgeInsets.only(left: hValue(10), bottom: hValue(10), top: hValue(5)),
  );
}

itemKategori(CategoryModel data) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data.competitionCategoryLabel}",
                  style: boldTextFont.copyWith(fontSize: fontSize(14)),
                ),
                Text(
                  "${formattingNumber(0)}",
                  style: regularTextFont.copyWith(fontSize: fontSize(14)),
                ),
                Text(
                  "100 / 200 Slot",
                  style: regularTextFont.copyWith(fontSize: fontSize(12)),
                ),
              ],
            ),
            flex: 1,
          ),
          Button("Daftar", colorAccentDark, true, () {},
              textSize: fontSize(10), height: hValue(30))
        ],
      ),
      hSpace(15),
      Divider(),
      hSpace(24)
    ],
  );
}

itemClub(
    {required ClubModel data,
    required Function onClick,
    required Function onJoinClick}) {
  return InkWell(
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imageRadius(
                  "${data.detail!.logo}", wValue(54), hValue(50), wValue(12)),
              wSpace(10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.detail!.name}",
                      style: boldTextFont.copyWith(
                          fontSize: fontSize(14), color: colorAccent),
                    ),
                    hSpace(4),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/ic_users.svg"),
                        wSpace(5),
                        Text(
                          "${data.totalMember} Anggota",
                          style:
                              regularTextFont.copyWith(fontSize: fontSize(10)),
                        ),
                      ],
                    ),
                    hSpace(4),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_location_black.svg",
                          color: Color(0xFF1C1C1C),
                        ),
                        wSpace(5),
                        Expanded(
                          child: Text(
                            "${data.detail!.placeName}",
                            style: regularTextFont.copyWith(
                                fontSize: fontSize(10)),
                          ),
                          flex: 1,
                        )
                      ],
                    )
                  ],
                ),
                flex: 1,
              ),
              wSpace(10),
              if (data.isJoin == 0)
                Button("Gabung", gray100, true, () {
                  onJoinClick();
                },
                    textSize: fontSize(14),
                    height: hValue(26),
                    fontColor: colorAccent)
            ],
          ),
          hSpace(10),
          Divider(
            color: gray200,
            thickness: hValue(1),
          ),
          hSpace(16),
        ],
      ),
    ),
    onTap: () {
      onClick(data);
    },
  );
}

itemMyClub(DetailClubModel data, {required Function onConfigClick}) {
  return InkWell(
    child: Container(
      margin: EdgeInsets.only(bottom: hValue(15)),
      padding: EdgeInsets.all(wValue(15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imageRadius("${data.logo}", wValue(74), hValue(70), wValue(12)),
              wSpace(10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.name}",
                      style: boldTextFont.copyWith(
                          fontSize: fontSize(14), color: colorAccent),
                    ),
                    hSpace(4),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(wValue(20))),
                      color: data.isAdmin == 1
                          ? Color(0xFF90AAD4)
                          : Color(0xFFFFCD6A),
                      child: Container(
                        child: Text(
                          data.isAdmin == 1 ? "Super Admin" : "Anggota",
                          style: regularTextFont.copyWith(
                              fontSize: fontSize(10), color: Colors.white),
                        ),
                        padding: EdgeInsets.only(
                            left: wValue(10),
                            right: wValue(10),
                            top: wValue(6),
                            bottom: wValue(6)),
                      ),
                    ),
                    hSpace(4),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/ic_users.svg"),
                        wSpace(5),
                        Text(
                          "${data.totalMember} Anggota",
                          style:
                              regularTextFont.copyWith(fontSize: fontSize(10)),
                        ),
                      ],
                    ),
                    hSpace(4),
                    Text(
                      "${data.address}",
                      style: regularTextFont.copyWith(fontSize: fontSize(10)),
                    ),
                  ],
                ),
                flex: 1,
              ),
              wSpace(10),
              if (data.isAdmin == 1)
                Button("Kelola Klub", colorPrimary, true, () {
                  onConfigClick();
                },
                    textSize: fontSize(14),
                    height: hValue(26),
                    fontColor: Colors.white)
            ],
          ),
        ],
      ),
    ),
    onTap: () {
      goToPage(DetailClubScreen(idClub: data.id!));
    },
  );
}

itemMemberClub(MemberClubModel data, {Function? onClick}) {
  return Container(
    child: InkWell(
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(wValue(8))),
        child: Container(
          child: Row(
            children: [
              Stack(
                children: [
                  Diagonal(
                    clipHeight: 20.0,
                    axis: Axis.vertical,
                    position: DiagonalPosition.TOP_RIGHT,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                        color: colorPrimary,
                      ),
                      width: wValue(155),
                      height: hValue(100),
                    ),
                  ),
                  Diagonal(
                    clipHeight: 20.0,
                    axis: Axis.vertical,
                    position: DiagonalPosition.TOP_RIGHT,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                      ),
                      width: wValue(150),
                      height: hValue(100),
                      child: data.avatar == null || data.avatar == ""
                          ? Image.asset(
                              "assets/img/img_placeholder.png",
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              "${data.avatar}",
                              fit: BoxFit.cover,
                            ),
                    ),
                  )
                ],
              ),
              wSpace(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.name}",
                    style: boldTextFont.copyWith(fontSize: fontSize(14)),
                  ),
                  hSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/ic_gender.svg",
                        width: wValue(15),
                      ),
                      wSpace(10),
                      Text(
                        "${data.gender == "female" ? "Perempuan" : "Laki-laki"}",
                        style: regularTextFont.copyWith(fontSize: fontSize(12)),
                      ),
                    ],
                  ),
                  hSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/ic_age.svg",
                        width: wValue(15),
                      ),
                      wSpace(10),
                      Text(
                        "${data.age}",
                        style: regularTextFont.copyWith(fontSize: fontSize(12)),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {
        if (onClick != null) onClick(data);
      },
    ),
    margin: EdgeInsets.only(bottom: hValue(10)),
  );
}

itemRegion(RegionModel data, Function onClick) {
  return InkWell(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${data.name}",
          style: regularTextFont.copyWith(fontSize: fontSize(12)),
        ),
        hSpace(5),
        Divider(),
      ],
    ),
    onTap: () {
      onClick(data);
    },
  );
}

itemEventTab(EventModel data, Function onClick) {
  return Container(
    width: Get.width,
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
      child: Container(
        child: Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(wValue(8))),
          child: Container(
            child: Stack(
              children: [
                Stack(
                  children: [
                    Hero(
                        tag: data.id!,
                        child: Container(
                          width: Get.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                            child: Image.network(
                              data.poster!,
                              width: Get.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: hValue(157),
                        )),
                    Stack(
                      children: [
                        Container(
                          width: Get.width,
                          child: Align(
                            child: SimpleShadow(
                              child: SvgPicture.asset(
                                "assets/icons/ic_circle_arrow.svg",
                                width: wValue(36),
                              ),
                              opacity: 0.6,
                              color: Colors.black.withAlpha(60),
                              offset: Offset(5, 5),
                              sigma: 7,
                            ),
                            alignment: Alignment.centerRight,
                          ),
                          margin: EdgeInsets.only(
                              top: hValue(140), right: wValue(15)),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(wValue(15)),
                  margin: EdgeInsets.only(top: hValue(142)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      hSpace(6),
                      Card(
                        color: Color(0xFFFFF2D9),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(wValue(10))),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: wValue(10),
                              right: wValue(10),
                              top: wValue(5),
                              bottom: wValue(5)),
                          child: Text(
                            "${data.eventCompetition}",
                            style: boldTextFont.copyWith(
                                fontSize: fontSize(10),
                                color: Color(0xFFE86F00)),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      hSpace(8),
                      Text(
                        "${data.eventName}",
                        style: boldTextFont.copyWith(
                            fontSize: fontSize(14), color: colorPrimary),
                        maxLines: 2,
                      ),
                      hSpace(8),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/ic_date.svg",
                            color: colorAccent,
                          ),
                          wSpace(5),
                          Text(
                            "${convertDateFormat("yyyy-MM-dd HH:mm:ss", "dd MMMM yyyy", data.eventStartDatetime!)}",
                            style: regularTextFont.copyWith(
                                fontSize: fontSize(12)),
                          ),
                        ],
                      ),
                      hSpace(8),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/ic_location.svg",
                            color: colorAccent,
                          ),
                          wSpace(5),
                          Expanded(
                              child: Text(
                            "${data.location}",
                            style: regularTextFont.copyWith(
                                fontSize: fontSize(12)),
                            maxLines: 2,
                          )),
                        ],
                      ),
                      hSpace(10),
                    ],
                  ),
                )
              ],
            ),
            // margin: EdgeInsets.all(wValue(8)),
          ),
        ),
        width: Get.width,
      ),
      onTap: () {
        onClick();
      },
    ),
    margin: EdgeInsets.only(
        left: wValue(15),
        bottom: hValue(10),
        top: hValue(5),
        right: wValue(15)),
  );
}

itemCategoryRegisterEvent(
    CategoryRegisterEventModel data, bool isSelected, Function onClick) {
  return InkWell(
    child: Container(
      margin: EdgeInsets.only(bottom: hValue(10)),
      padding: EdgeInsets.only(
          left: wValue(15),
          right: wValue(15),
          top: hValue(5),
          bottom: hValue(5)),
      decoration: BoxDecoration(
        border: Border.all(
            width: 1, color: isSelected ? colorPrimary : Color(0xFFE2E2E2)),
        color: !data.isOpen!
            ? gray50
            : isSelected
                ? Color(0xFFE7EDF6)
                : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${data.teamCategoryDetail!.label}-${data.categoryLabel}",
              style: boldTextFont.copyWith(fontSize: fontSize(12)),
            ),
            flex: 1,
          ),
          labelView(
              data.isOpen!
                  ? "${data.totalParticipant}/${data.quota}"
                  : "Ditutup",
              colorPrimary,
              Color(0xFFE7EDF6))
        ],
      ),
    ),
    onTap: () {
      onClick();
    },
  );
}

itemPesertaOrderEvent(ProfileModel data, int number) {
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
          child: Text(
            "Peserta $number",
            style: boldTextFont.copyWith(fontSize: fontSize(12)),
          ),
        ),
        hSpace(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            circleAvatar("${data.avatar}", wValue(72), hValue(70)),
            wSpace(15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${data.name}",
                      style: boldTextFont.copyWith(fontSize: fontSize(12))),
                  hSpace(5),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/ic_email.svg",
                        width: wValue(16),
                        color: gray400,
                      ),
                      wSpace(5),
                      Text(data.email ?? "-",
                          style:
                              regularTextFont.copyWith(fontSize: fontSize(12)))
                    ],
                  ),
                  hSpace(5),
                  Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/ic_gender.svg",
                            width: wValue(16),
                            color: gray400,
                          ),
                          wSpace(5),
                          Text(data.gender ?? "-",
                              style: regularTextFont.copyWith(
                                  fontSize: fontSize(12))),
                        ],
                      ),
                      wSpace(10),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/ic_user.svg",
                            width: wValue(16),
                            color: gray400,
                          ),
                          wSpace(5),
                          Text(data.age.toString(),
                              style: regularTextFont.copyWith(
                                  fontSize: fontSize(12))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              flex: 1,
            )
          ],
        )
      ],
    ),
    margin: EdgeInsets.only(bottom: hValue(15)),
  );
}

itemCategoryDetail(MasterCategoryRegisterEventModel data, bool? isSelected,
    Function? onClick) {
  return InkWell(
    child: Container(
      margin: EdgeInsets.only(right: wValue(10)),
      padding: EdgeInsets.all(wValue(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: isSelected! ? colorPrimary : Colors.white,
        border: Border.all(width: 1, color: colorPrimary),
      ),
      child: Text(
        "${data.datas!.first.teamCategoryDetail!.label}",
        style: regularTextFont.copyWith(
            fontSize: fontSize(12),
            color: isSelected ? Colors.white : colorPrimary),
      ),
    ),
    onTap: () {
      onClick!();
    },
  );
}

itemChildCategoryDetail(CategoryRegisterEventModel data, Function onClick) {
  return Container(
    padding: EdgeInsets.all(wValue(15)),
    margin: EdgeInsets.only(
        left: wValue(15),
        right: wValue(15),
        top: hValue(5),
        bottom: hValue(10)),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/ic_archer.svg",
                    color: grey3,
                    width: wValue(17),
                  ),
                  wSpace(5),
                  Text(
                    "${data.teamCategoryDetail!.label}",
                    style: boldTextFont.copyWith(fontSize: fontSize(12)),
                  )
                ],
              ),
              flex: 1,
            ),
            labelView(
                "Tersedia : ${data.quota! - data.totalParticipant!}/${data.quota}",
                Colors.black,
                green200)
          ],
        ),
        Divider(),
        Row(
          children: [
            Expanded(
              child: Text(
                "${data.categoryLabel}",
                style: boldTextFont.copyWith(fontSize: fontSize(14)),
              ),
              flex: 1,
            ),
            Button("Daftar", Colors.white, true, () {
              if (data.totalParticipant! >= data.quota!) {
                printLog(msg: "Oops penuh");
                return;
              }
              onClick();
            },
                height: hValue(30),
                borderColor: colorPrimary,
                textSize: fontSize(12),
                fontColor: colorPrimary)
          ],
        ),
      ],
    ),
  );
}

// itemOrderEvent(DataOrderAllModel item, Function onClick) {
//   DataOrderAllModel data = DataOrderAllModel();
//   TransactionInfoModel transactionInfoModel = TransactionInfoModel();
//   if(item.transactionLogInfo is List){
//     return Container();
//   }else{
//     data = DataOrderAllModel(
//       participant: item.participant,
//       detailOrder: item.detailOrder,
//       detailEvent: item.detailEvent,
//       category: item.category
//     );
//
//     transactionInfoModel = TransactionInfoModel(
//       orderId: item.transactionLogInfo['orderId'],
//       statusId: item.transactionLogInfo['statusId'],
//       status: item.transactionLogInfo['status'],
//       total: item.transactionLogInfo['total'],
//       transactionLogId: item.transactionLogInfo['transactionLogId'],
//       snapToken: item.transactionLogInfo['snapToken'],
//       clientKey: item.transactionLogInfo['clientKey'],
//       clientLibLink: item.transactionLogInfo['clientLibLink'],
//       orderDate: OrderDateModel(date: item.transactionLogInfo['orderDate']['date'])
//     );
//
//   }
//
//
//   Color textColor = gray400;
//   Color bgColor = gray80;
//   if (transactionInfoModel.statusId == KEY_PAYMENT_PENDING) {
//     textColor = colorSecondary;
//     bgColor = colorSecondary50;
//   } else if (transactionInfoModel.statusId == KEY_PAYMENT_EXPIRED ||
//       transactionInfoModel.statusId == KEY_PAYMENT_FAILED) {
//     textColor = gray400;
//     bgColor = gray80;
//   } else if (transactionInfoModel.statusId == KEY_PAYMENT_SETTLEMENT) {
//     textColor = green400;
//     bgColor = green100;
//   }
//   return Container(
//     decoration: new BoxDecoration(
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(.5),
//           blurRadius: 10.0, // soften the shadow
//           spreadRadius: 0.0, //extend the shadow
//           offset: Offset(
//             2.0, // Move to right 10  horizontally
//             1.0, // Move to bottom 10 Vertically
//           ),
//         )
//       ],
//     ),
//     child: InkWell(
//       child: Card(
//         elevation: 0,
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(wValue(8))),
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${data.detailEvent!.first.eventName}",
//                           style: boldTextFont.copyWith(fontSize: fontSize(12)),
//                         ),
//                         Text(
//                           "${data.detailEvent!.first.eventCompetition}",
//                           style:
//                               regularTextFont.copyWith(fontSize: fontSize(12)),
//                         ),
//                       ],
//                     ),
//                     flex: 1,
//                   ),
//                   wSpace(10),
//                   labelView(
//                     "${transactionInfoModel.status}", textColor, bgColor)
//                 ],
//               ),
//               Divider(),
//               Row(
//                 children: [
//                   imageRadius("${data.detailEvent!.first.poster}", wValue(74),
//                       hValue(74), wValue(12)),
//                   wSpace(10),
//                   Expanded(
//                       child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Row(
//                             children: [
//                               SvgPicture.asset(
//                                 "assets/icons/ic_users.svg",
//                                 color: gray400,
//                                 width: wValue(15),
//                               ),
//                               wSpace(5),
//                               Text(
//                                 (data.detailOrder!.type == "official")
//                                     ? "Official"
//                                     : "${convertTeamCategory(data.category!.teamCategoryId!)}",
//                                 style: regularTextFont.copyWith(
//                                     fontSize: fontSize(12)),
//                               ),
//                             ],
//                           ),
//                           wSpace(10),
//                           Row(
//                             children: [
//                               SvgPicture.asset(
//                                 "assets/icons/ic_archer.svg",
//                                 color: gray400,
//                                 width: wValue(15),
//                               ),
//                               wSpace(5),
//                               Text(
//                                 "${data.category!.competitionCategoryId!}",
//                                 style: regularTextFont.copyWith(
//                                     fontSize: fontSize(12)),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                       hSpace(5),
//                       Text(
//                         "${data.category!.label}",
//                         style: boldTextFont.copyWith(fontSize: fontSize(14)),
//                       ),
//                       hSpace(5),
//                       Row(
//                         children: [
//                           SvgPicture.asset(
//                               "assets/icons/ic_location_black.svg"),
//                           wSpace(5),
//                           Text(
//                             data.detailEvent!.first.detailCity != null
//                                 ? "${data.detailEvent!.first.detailCity!.name}"
//                                 : "-",
//                             style: regularTextFont.copyWith(
//                                 fontSize: fontSize(12)),
//                           ),
//                         ],
//                       )
//                     ],
//                   ))
//                 ],
//               ),
//               Divider(),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       transactionInfoModel.total == null ? formattingNumber(0) : "${formattingNumber(transactionInfoModel.total)}",
//                       style: boldTextFont.copyWith(
//                           fontSize: fontSize(14), color: colorPrimary),
//                     ),
//                     flex: 1,
//                   ),
//                   Button(
//                       transactionInfoModel.statusId == 1
//                           ? "Lihat Detail"
//                           : transactionInfoModel.statusId == 2
//                               ? "Daftar Ulang"
//                               : transactionInfoModel.statusId == 4
//                                   ? "Bayar"
//                                   : "Lihat Detail",
//                       colorPrimary,
//                       true, () {
//                     onClick();
//                   },
//                       height: hValue(36),
//                       fontSize: fontSize(14),
//                       fontColor: Colors.white)
//                 ],
//               )
//             ],
//           ),
//           margin: EdgeInsets.all(wValue(8)),
//           padding: EdgeInsets.all(wValue(10)),
//         ),
//       ),
//       onTap: () {
//         Get.to(DetailEventOrderScreen(
//           paramData: data.detailOrder!,
//         ));
//       },
//     ),
//     margin:
//         EdgeInsets.only(left: hValue(10), bottom: hValue(10), top: hValue(5)),
//   );
// }

itemStatusPayment(TeamCategoryDetail data, bool isSelected, Function onClick) {
  return InkWell(
    child: Container(
      margin: EdgeInsets.only(right: hValue(5)),
      padding: EdgeInsets.only(
          left: wValue(15),
          right: wValue(15),
          top: hValue(5),
          bottom: hValue(5)),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: colorPrimary),
        color: isSelected ? blue50 : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "${data.label}",
        style:
            boldTextFont.copyWith(fontSize: fontSize(12), color: colorPrimary),
      ),
    ),
    onTap: () {
      onClick();
    },
  );
}

itemMyEvent(DataDetailEventModel data, Function onClick) {
  Color textColor = colorSecondary;
  Color bgColor = colorSecondary50;

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
                    child: Text(
                      "${data.publicInformation!.eventName!}",
                      style: boldTextFont.copyWith(
                          fontSize: fontSize(12), color: colorPrimary),
                    ),
                    flex: 1,
                  ),
                  wSpace(10),
                  labelView("${data.eventCompetition}", textColor, bgColor)
                ],
              ),
              Divider(),
              Row(
                children: [
                  imageRadius("${data.publicInformation!.eventBanner}",
                      wValue(60), hValue(55), wValue(12)),
                  wSpace(10),
                  Expanded(
                      child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/ic_location.svg",
                            color: Colors.black,
                            width: wValue(15),
                          ),
                          wSpace(5),
                          Text(
                            "${data.publicInformation!.eventCity!.nameCity}",
                            style: regularTextFont.copyWith(
                                fontSize: fontSize(12)),
                          ),
                        ],
                      ),
                      hSpace(10),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/ic_date.svg",
                            color: Colors.black,
                            width: wValue(15),
                          ),
                          wSpace(5),
                          Text(
                            "${convertDateFormat("yyyy-MM-dd HH:mm:ss", "yyyy/MM/dd", data.publicInformation!.eventStart!)}-${convertDateFormat("yyyy-MM-dd HH:mm:ss", "yyyy/MM/dd", data.publicInformation!.eventEnd!)}",
                            style: regularTextFont.copyWith(
                                fontSize: fontSize(12)),
                          ),
                        ],
                      )
                    ],
                  ))
                ],
              ),
              hSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //TODO when api ready uncomment this
                  //  Button("Leader Board",
                  //     Colors.white, true, (){
                  //       onClick();
                  //     }, borderColor: colorPrimary, height: hValue(25), fontSize: fontSize(12), fontColor: colorPrimary),
                  // wSpace(10),
                  Button("Lihat Detail", colorPrimary, true, () {
                    onClick();
                  },
                      height: hValue(25),
                      textSize: fontSize(12),
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
        onClick();
      },
    ),
  );
}

itemRegistrationFeeNew(EventPriceModel item) {
  var _titleType = "";
  if (item.titleEventPrice?.toLowerCase() == "team") {
    _titleType = "Beregu";
  } else if (item.titleEventPrice?.toLowerCase() == "mix") {
    _titleType = "Campuran";
  } else {
    _titleType = "Individu";
  }

  return Expanded(
    child: Container(
      padding: EdgeInsets.all(wValue(10)),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: colorSecondary),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Get.width,
            margin: EdgeInsets.only(bottom: hValue(10)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: colorSecondary,
            ),
            padding: EdgeInsets.only(
                left: wValue(10),
                bottom: hValue(5),
                top: hValue(5),
                right: wValue(10)),
            child: Text(
              "$_titleType",
              style:
                  boldTextFont.copyWith(fontSize: fontSize(10), color: gray600),
              textAlign: TextAlign.center,
            ),
          ),
          if (item.isEarlyBird == 1)
            Container(
              child: Text(
                  formattingNumber(double.parse(getPrice(item.price ?? "0.0"))),
                  style: boldTextFont.copyWith(
                      fontSize: fontSize(10),
                      color: gray600,
                      decoration: TextDecoration.lineThrough)),
              margin: EdgeInsets.only(bottom: hValue(10)),
            ),
          Text(
            formattingNumber(item.isEarlyBird == 1
                ? double.parse(getPrice(item.earlyBird ?? "0.0"))
                : double.parse(getPrice(item.price ?? "0.0"))),
            style: boldTextFont.copyWith(
                fontSize: fontSize(12), color: colorPrimary),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: hValue(10), right: wValue(10)),
    ),
    flex: 1,
  );
}

itemDetailMyEvent(
    DataDetailEventModel event, CategoryDetailModel data, Function onClick) {
  Color textColor = purple600;
  Color bgColor = purple100;
  int fee = 0;
  if (data.fee!.contains(".")) {
    var feeSplit = data.fee!.split(".");
    fee = int.parse(feeSplit[0]);
  }

  return Container(
    decoration: new BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.15),
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(wValue(8)),
              topRight: Radius.circular(wValue(8)),
              bottomLeft: Radius.circular(wValue(8))),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: wValue(15),
                      right: wValue(25),
                      bottom: wValue(10),
                      top: wValue(10)),
                  decoration: BoxDecoration(
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
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(wValue(55))),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        data.categoryType!.toLowerCase() == "individual"
                            ? "assets/icons/ic_user.svg"
                            : "assets/icons/ic_users.svg",
                        width: wValue(16),
                        color: data.categoryType!.toLowerCase() == "individual"
                            ? Color(0xFF0D47A1)
                            : Color(0xFFFF7A00),
                      ),
                      wSpace(10),
                      Text(
                        "${data.categoryType!}",
                        style: regularTextFont.copyWith(
                          fontSize: fontSize(12),
                          color:
                              data.categoryType!.toLowerCase() == "individual"
                                  ? Color(0xFF0D47A1)
                                  : Color(0xFFFF7A00),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    "${data.detailParticipant!.orderId!}",
                    style: boldTextFont.copyWith(
                        fontSize: fontSize(12), color: gray400),
                  ),
                  margin: EdgeInsets.only(right: wValue(15)),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(wValue(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      imageRadius("${event.publicInformation!.eventBanner}",
                          wValue(56), hValue(50), wValue(12)),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (data.detailParticipant!.historyQualification !=
                                null)
                              labelView(
                                  data.detailParticipant!
                                          .historyQualification ??
                                      "-",
                                  textColor,
                                  bgColor,
                                  isBold: true),
                            hSpace(5),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'Biaya Pendaftaran    ',
                                  style: regularTextFont.copyWith(
                                      color: Colors.black,
                                      fontSize: fontSize(10)),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: formattingNumber(fee),
                                        style: boldTextFont.copyWith(
                                            color: colorAccent,
                                            fontSize: fontSize(10))),
                                  ]),
                            ),
                          ],
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                  hSpace(5),
                  Divider(),
                  hSpace(5),
                  Container(
                    color: gray50,
                    padding: EdgeInsets.all(wValue(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Jenis Event",
                                    style: regularTextFont.copyWith(
                                        fontSize: fontSize(12)),
                                  ),
                                  hSpace(5),
                                  Text(
                                    "${event.eventCompetition}",
                                    style: boldTextFont.copyWith(
                                        fontSize: fontSize(12)),
                                  ),
                                ],
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kategori",
                                    style: regularTextFont.copyWith(
                                        fontSize: fontSize(12)),
                                  ),
                                  hSpace(5),
                                  Text(
                                    "${data.competitionCategoryDetail!.label}",
                                    style: boldTextFont.copyWith(
                                        fontSize: fontSize(12)),
                                  ),
                                ],
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                        hSpace(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Detail Kategori",
                                    style: regularTextFont.copyWith(
                                        fontSize: fontSize(12)),
                                  ),
                                  hSpace(5),
                                  Text(
                                    "${data.categoryLabel}",
                                    style: boldTextFont.copyWith(
                                        fontSize: fontSize(12)),
                                  ),
                                ],
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Nama Tim",
                                    style: regularTextFont.copyWith(
                                        fontSize: fontSize(12)),
                                  ),
                                  hSpace(5),
                                  Text(
                                    data.detailParticipant!.teamName ?? "-",
                                    style: boldTextFont.copyWith(
                                        fontSize: fontSize(12)),
                                  ),
                                ],
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  hSpace(5),
                  Divider(),
                  hSpace(5),
                  Align(
                    child: Container(
                      child: Button("Lihat Detail", colorPrimary, true, () {
                        onClick();
                      },
                          height: hValue(25),
                          textSize: fontSize(12),
                          fontColor: Colors.white),
                      width: wValue(100),
                    ),
                    alignment: Alignment.centerRight,
                  )
                ],
              ),
            )
          ],
        ),
        margin: EdgeInsets.all(wValue(8)),
      ),
      onTap: () {
        onClick();
      },
    ),
  );
}
