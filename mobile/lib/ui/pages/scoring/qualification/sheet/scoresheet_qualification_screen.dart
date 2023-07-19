import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_archery/ui/pages/scoring/qualification/record/score_record_qualification_screen.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/global_helper.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';
import 'package:my_archery/utils/translator.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../../core/models/saved_scoresheet_model.dart';
import '../../../main/main_screen.dart';
import '../../../scan_qr/scoring/scan_qr_screen.dart';
import 'scoresheet_qualification_controller.dart';

class ScoresheetQualificationScreen extends StatefulWidget {
  final String? code;
  const ScoresheetQualificationScreen({Key? key, this.code}) : super(key: key);

  @override
  _ScoresheetQualificationScreenState createState() =>
      _ScoresheetQualificationScreenState();
}

class _ScoresheetQualificationScreenState
    extends State<ScoresheetQualificationScreen> {
  var controller = ScoresheetQualificationController();
  final scrollDirection = Axis.horizontal;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterInit());
    controller.participantScrollCtrl.value = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
    super.initState();
  }

  afterInit() {
    if(widget.code != null){
      controller.selectedCode.value = widget.code!;
    }
    controller.initController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorAccentDark,
        child: BaseContainer(
          child: SafeArea(
            child: Scaffold(
              appBar: appBar(Translator.scoreSheet.tr, () {
                closeAlert();
              },
                  bgColor: colorAccent,
                  textColor: Colors.white,
                  iconColor: Colors.white),
              backgroundColor: bgPage,
              body: WillPopScope(
                onWillPop: _onWillPop,
                child: Container(
                  child: Stack(
                    children: [
                      Obx(() => Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: wValue(5),
                                right: wValue(5),
                                top: wValue(15),
                                bottom: wValue(5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                viewSliderParticipant(),
                                hSpace(15),
                                viewInfoParticipant(),
                                hSpace(5),
                                Container(
                                  padding: EdgeInsets.all(hValue(7)),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: wValue(35),
                                        padding: EdgeInsets.only(
                                            bottom: hValue(10),
                                            top: hValue(10)),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(5.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "End",
                                            textAlign: TextAlign.center,
                                            style: boldTextFont.copyWith(
                                                fontSize: fontSize(12)),
                                          ),
                                        ),
                                      ),
                                      wSpace(5),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: hValue(10),
                                              top: hValue(10),
                                              left: wValue(10),
                                              right: wValue(10)),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(
                                                5.0),
                                            // border: Border.all(color: Colors.grey),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                "Shoot",
                                                textAlign:
                                                TextAlign.center,
                                                style:
                                                boldTextFont.copyWith(
                                                    fontSize:
                                                    fontSize(12)),
                                              ),
                                              Text(
                                                "Sum",
                                                textAlign:
                                                TextAlign.center,
                                                style:
                                                boldTextFont.copyWith(
                                                    fontSize:
                                                    fontSize(12)),
                                              )
                                            ],
                                          ),
                                        ),
                                        flex: 1,
                                      ),
                                      wSpace(5),
                                      Container(
                                        padding: EdgeInsets.only(
                                            bottom: hValue(10),
                                            top: hValue(10)),
                                        width: wValue(45),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(5.0),
                                          // border: Border.all(color: Colors.grey),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Total",
                                            textAlign: TextAlign.center,
                                            style: boldTextFont.copyWith(
                                                fontSize: fontSize(12)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: controller.isLoading.value
                                ? loading()
                                : SingleChildScrollView(
                              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                              scrollDirection: Axis.vertical,
                              child: Container(
                                margin: EdgeInsets.only(left: wValue(5), right: wValue(5), bottom: hValue(15)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (int i = 0; i < 6; i++)
                                      itemShootRow(i, controller.selectedArcher.value.isUpdated == 0, controller.selectedArcher.value, () async {
                                        if (controller.selectedArcher.value.isUpdated != 0) {
                                          var result = await Get.to(ScoreRecordQualificationScreen(data: controller.selectedArcher.value, scheduleId: controller.selectedCode.value, selectedSavedArcher: controller.selectedBudrestNumber.value, index: i,));
                                          if (result) {
                                            controller.apiScanQr(controller.selectedCode.value);
                                          }
                                        }
                                      }),
                                    hSpace(15),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: wValue(15),
                                          right: wValue(15)),
                                      width: Get.width,
                                      height: hValue(25),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "X",
                                                  style: regularTextFont
                                                      .copyWith(
                                                      fontSize:
                                                      fontSize(
                                                          12)),
                                                ),
                                                wSpace(5),
                                                Container(
                                                  width: wValue(60),
                                                  color:
                                                  Colors.white,
                                                  child: EditTextWoIcon(
                                                      enable: false,
                                                      controller:
                                                      controller
                                                          .xTextController
                                                          .value),
                                                ),
                                                wSpace(20),
                                                Text(
                                                  "X+10",
                                                  style: regularTextFont
                                                      .copyWith(
                                                      fontSize:
                                                      fontSize(
                                                          12)),
                                                ),
                                                wSpace(5),
                                                Container(
                                                  width: wValue(60),
                                                  color:
                                                  Colors.white,
                                                  child: EditTextWoIcon(
                                                      enable: false,
                                                      controller:
                                                      controller
                                                          .tenTextController
                                                          .value),
                                                ),
                                              ],
                                            ),
                                            flex: 1,
                                          ),
                                          Text(
                                            "Total",
                                            style: regularTextFont
                                                .copyWith(
                                                fontSize:
                                                fontSize(
                                                    12)),
                                          ),
                                          wSpace(10),
                                          Container(
                                            width: wValue(60),
                                            color: Colors.white,
                                            child: EditTextWoIcon(
                                                enable: false,
                                                controller: controller
                                                    .totalTextController
                                                    .value,
                                                hintText: "131"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    hSpace(25)
                                  ],
                                ),
                              ),
                            ),
                            flex: 1,
                          ),
                          bottomNavigationCode(),
                          // TODO uncomment this later
                          // viewButtonSubmit(),
                        ],
                      )),
                    ],
                  ),
                  height: Get.height,
                ),
              ),
            ),
          ),
        ));
  }

  viewInfoParticipant() {
    return Container(
      margin: EdgeInsets.only(left: wValue(7), right: wValue(7)),
      child: Row(
        children: [
          Container(
            width: wValue(70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5)),
              color: Color(0xFFFFCD6A),
            ),
            padding: EdgeInsets.only(
                left: wValue(10),
                right: wValue(10),
                top: hValue(7),
                bottom: hValue(7)),
            child: Text(
              "Sesi ${controller.selectedArcher.value.session}",
              style: regularTextFont.copyWith(
                  fontSize: fontSize(10), color: colorAccent),
            ),
          ),
          wSpace(3),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFE7EDF6),
              ),
              padding: EdgeInsets.only(
                  left: wValue(25),
                  right: wValue(25),
                  top: hValue(7),
                  bottom: hValue(7)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/ic_arrow.svg"),
                  wSpace(10),
                  Expanded(
                    child: Text(
                      "${controller.selectedArcher.value.participant!.competitionCategoryId}",
                      style: regularTextFont.copyWith(
                          fontSize: fontSize(10), color: colorAccent),
                    ),
                    flex: 1,
                  )
                ],
              ),
            ),
            flex: 1,
          ),
          wSpace(3),
          Container(
            width: wValue(130),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5)),
              color: Color(0xFFE7EDF6),
            ),
            padding: EdgeInsets.only(
                left: wValue(10),
                right: wValue(10),
                top: hValue(7),
                bottom: hValue(7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/ic_distance.svg",
                  color: colorAccent,
                ),
                wSpace(10),
                Expanded(child: Text(
                  "${controller.selectedArcher.value.participant!.distanceId}m",
                  style: regularTextFont.copyWith(
                      fontSize: fontSize(10), color: colorAccent),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  viewSliderParticipant() {
    return Container(
      child: ListView.builder(
        itemCount: controller.selectedParticipants.length,
        scrollDirection: scrollDirection,
        controller: controller.participantScrollCtrl.value,
        itemBuilder: (context, position) {
          var item = controller.selectedParticipants[position];
          return AutoScrollTag(
              key: ValueKey(item),
              controller: controller.participantScrollCtrl.value,
              index: position,
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.only(left: hValue(10)),
                  padding: EdgeInsets.only(
                      left: wValue(10),
                      right: wValue(10),
                      bottom: hValue(5),
                      top: hValue(5)),
                  child: Row(
                    children: [
                      Text(
                        '${item.budrestNumber} - ${item.participant!.name}',
                        style: boldTextFont.copyWith(
                            fontSize: fontSize(12), color: colorAccent),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: controller.selectedArcher.value.participant!.id.toString() == item.participant!.id.toString()
                        ? Color(0xFFE7EDF6)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: colorAccent),
                  ),
                ),
                onTap: () {
                  controller.selectedArcher.value = item;
                  controller.apiScanQr(controller.selectedCode.value);
                },
              ));
        },
      ),
      height: hValue(30),
    );
  }

  viewButtonSubmit() {
    if (controller.selectedArcher.value.isUpdated == 1 &&
        !controller.selectedArcher.value.score!.six!.contains(""))
      Container(
        margin: EdgeInsets.only(
            left: wValue(15), right: wValue(15), bottom: hValue(15)),
        child: Column(
          children: [
            Button(
                title: "Ajukan Scoring Sesi",
                color: colorAccentDark,
                enable: true,
                onClick: () {
                  if (controller.validToSubmit.value) {
                    showConfirmDialog(
                      context,
                      content:
                          "Apakah anda sudah yakin ingin mengajukan Skor. karena data sudah tidak dapat di ubah lagi",
                      assets: "assets/icons/ic_alert.svg",
                      btn2: "Batal",
                      onClickBtn2: () {},
                      btn3: "Yakin",
                      onClickBtn3: () {
                        controller.apiSaveScore();
                      },
                    );
                  } else {
                    errorToast(
                        msg:
                            "Selesaikan semua Scoring Semua Rambahan Terlebih dahulu");
                  }
                },
                radius: wValue(10),
                fontSize: fontSize(12))
          ],
        ),
      );
  }

  bottomNavigationCode() {
    return Container(
      margin: EdgeInsets.all(wValue(15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(70),
            offset: Offset(0.0, 0.2), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      padding: EdgeInsets.all(wValue(10)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: controller.savedArcherData.length > 0
                      ? ItemSesi(
                          item: controller.savedArcherData.first,
                          index: 0,
                          title: "${controller.savedArcherData.first.bantalan!}",
                          isActive: ("${controller.savedArcherData[0].schedulId}" == "${controller.selectedCode.value}"),
                          onClick: () {
                            controller.onClickSavedArcher(index: 0);
                          },
                          onDelete: () {
                            controller.onDeleteSavedArcher(index : 0);
                          },
                        )
                      : addParticipantView()),
              wSpace(15),
              Expanded(
                  child: controller.savedArcherData.length > 1
                      ? ItemSesi(
                          item: controller.savedArcherData[1],
                          index: 1,
                          title: "${controller.savedArcherData[1].bantalan!}",
                          isActive: ("${controller.savedArcherData[1].schedulId}" == "${controller.selectedCode.value}"),
                          onClick: () {
                            controller.onClickSavedArcher(index: 1);
                          },
                          onDelete: () {
                            controller.onDeleteSavedArcher(index : 1);
                          },
                        )
                      : addParticipantView()),
              wSpace(15),
              Expanded(
                  child: controller.savedArcherData.length > 2
                      ? ItemSesi(
                          item: controller.savedArcherData[2],
                          index: 2,
                          title: "${controller.savedArcherData[2].bantalan!}",
                          isActive: ("${controller.savedArcherData[2].schedulId}" == "${controller.selectedCode.value}"),
                          onClick: () {
                            controller.onClickSavedArcher(index: 2);
                          },
                          onDelete: () {
                            controller.onDeleteSavedArcher(index : 2);
                          },
                  )
                      : addParticipantView()),
              wSpace(15),
              Expanded(
                  child: controller.savedArcherData.length > 3
                      ? ItemSesi(
                          item: controller.savedArcherData[3],
                          index: 3,
                          title: "${controller.savedArcherData[3].bantalan!}",
                          isActive: ("${controller.savedArcherData[3].schedulId}" == "${controller.selectedCode.value}"),
                          onClick: () {
                            controller.onClickSavedArcher(index: 3);
                          },
                          onDelete: () {
                            controller.onDeleteSavedArcher(index : 3);
                          },
                  )
                      : addParticipantView()),
            ],
          ),
          hSpace(10),
          Row(
            children: [
              Expanded(
                  child: controller.savedArcherData.length > 4
                      ? ItemSesi(
                          item: controller.savedArcherData[4],
                          index: 4,
                          title: "${controller.savedArcherData[4].bantalan!}",
                          isActive: ("${controller.savedArcherData[4].schedulId}" == "${controller.selectedCode.value}"),
                          onClick: () {
                            controller.onClickSavedArcher(index: 4);
                          },
                          onDelete: () {
                            controller.onDeleteSavedArcher(index : 4);
                          },
                  )
                      : addParticipantView()),
              wSpace(15),
              Expanded(
                  child: controller.savedArcherData.length > 5
                      ? ItemSesi(
                          item: controller.savedArcherData[5],
                          index: 5,
                          title: "${controller.savedArcherData[5].bantalan!}",
                          isActive: ("${controller.savedArcherData[5].schedulId}" == "${controller.selectedCode.value}"),
                          onClick: () {
                            controller.onClickSavedArcher(index: 5);
                          },
                          onDelete: () {
                            controller.onDeleteSavedArcher(index : 5);
                          },
                        )
                      : addParticipantView()),
              wSpace(15),
              Expanded(
                  child: controller.savedArcherData.length > 6
                      ? ItemSesi(
                          item: controller.savedArcherData[6],
                          index: 6,
                          title: "${controller.savedArcherData[6].bantalan!}",
                          isActive:
                              ("${controller.savedArcherData[6].schedulId}" ==
                                  "${controller.selectedCode.value}"),
                          onClick: () {
                            controller.onClickSavedArcher(index: 6);
                          },
                          onDelete: () {
                            controller.onDeleteSavedArcher(index : 6);
                          },
                  )
                      : addParticipantView()),
              wSpace(15),
              Expanded(
                  child: controller.savedArcherData.length > 7
                      ? ItemSesi(
                          item: controller.savedArcherData[7],
                          index: 7,
                          title: "${controller.savedArcherData[7].bantalan!}",
                          isActive: ("${controller.savedArcherData[7].schedulId}" == "${controller.selectedCode.value}"),
                          onClick: () {
                            controller.onClickSavedArcher(index: 7);
                          },
                          onDelete: () {
                            controller.onDeleteSavedArcher(index : 7);
                          },
                  ) : addParticipantView()),
            ],
          )
        ],
      ),
    );
  }

  addParticipantView() {
    return InkWell(
      child: SvgPicture.asset("assets/icons/ic_add_circle.svg"),
      onTap: () {
        controller.setValueKeyParticipant(true);
        goToPage(ScanQrScreen());
      },
    );
  }

  Future<bool> _onWillPop() async {
    closeAlert();
    return false;
  }

  closeAlert() {
    showConfirmDialog(context,
        content: "Are you sure want to exit this page?",
        btn1: "Cancel",
        btn3: "Yes",
        onClickBtn1: () {}, onClickBtn3: () {
      goToPage(MainScreen(), dismissAllPage: true);
    });
  }
}

class ItemSesi extends StatelessWidget {
  final SavedScoresheetModel item;
  final int index;
  final String title;
  final bool isActive;
  final Function onClick;
  final Function onDelete;

  const ItemSesi(
      {Key? key,
      required this.item,
      required this.index,
      required this.title,
      required this.isActive,
      required this.onClick,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: isActive ? Color(0xFFE7EDF6) : bgPage,
                ),
                padding: EdgeInsets.all(wValue(10)),
                child: Text(
                  "${item.bantalan}",
                  style: boldTextFont.copyWith(
                      fontSize: fontSize(9), color: colorAccent),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                onClick();
              },
            ),
            flex: 1,
          ),
          InkWell(
            child: Container(
              height: hValue(27),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: bgPage,
              ),
              padding: EdgeInsets.all(wValue(5)),
              child: Icon(
                Icons.close,
                color: Colors.red,
                size: wValue(15),
              ),
            ),
            onTap: () {
              onDelete();
            },
          )
        ],
      ),
    );
  }
}
