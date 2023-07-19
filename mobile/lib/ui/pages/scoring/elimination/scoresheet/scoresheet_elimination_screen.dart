import 'package:clippy_flutter/paralellogram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_archery/core/models/saved_elimination_model.dart';
import 'package:my_archery/core/services/local/score_db.dart';
import 'package:my_archery/ui/pages/scan_qr/scoring/scan_qr_screen.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/global_helper.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';
import 'package:my_archery/utils/translator.dart';

import '../../../main/main_screen.dart';
import '../record/score_record_elimination_screen.dart';
import '../record/shoot_off/shoot_off_screen.dart';
import 'scoresheet_elimination_controller.dart';

class ScoresheetEliminationScreen extends StatefulWidget {
  final String? code;
  const ScoresheetEliminationScreen({Key? key, this.code}) : super(key: key);

  @override
  _ScoresheetEliminationScreenState createState() => _ScoresheetEliminationScreenState();
}

class _ScoresheetEliminationScreenState extends State<ScoresheetEliminationScreen> {

  var controller = ScoresheetEliminationController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterInit());
    super.initState();
  }

  afterInit(){
    controller.savedArcherData.addAll(ScoreDb().readLocalEliminationScores());
    if(widget.code != null){
      controller.code.value = widget.code!;
    }else{
      controller.code.value = controller.savedArcherData.first.code!;
    }
    controller.initController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: BaseContainer(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: bgPage,
            appBar: appBar(Translator.scoreSheet.tr, (){
              closeAlert();
            }),
            body: Obx(()=> WillPopScope(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(wValue(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        viewHeader(),
                        hSpace(10),
                        viewSessionInfo(),
                        hSpace(12),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              side: BorderSide(
                                color: Color(0xFFCED4DA),
                                width: 1.0,
                              )),
                          elevation: 0,
                          color: Colors.white,
                          child: Container(
                            padding: EdgeInsets.all(hValue(7)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text("End", style: regularTextFont.copyWith(fontSize: fontSize(12)),), flex: 1,),
                                Expanded(child: Text("Nama", style: regularTextFont.copyWith(fontSize: fontSize(12)),), flex: 2,),
                                Expanded(child: Text("Shoot", style: regularTextFont.copyWith(fontSize: fontSize(12)),), flex: 2,),
                                Expanded(child: Text("Sum", style: regularTextFont.copyWith(fontSize: fontSize(12)), textAlign: TextAlign.center,), flex: 1,),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: RefreshIndicator(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      scrollDirection: Axis.vertical,
                      child: Container(
                        margin: EdgeInsets.only(left: wValue(15), right: wValue(15), bottom: hValue(15)),
                        child: controller.isLoading.value ? loading() : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(int i =0; i < controller.data.value.data!.first.scores!.shot!.length; i++) itemShootElimination(member1 : controller.data.value.data!.first,
                                member2: controller.data.value.data![1], number: i,
                                isActive: (i == 0) ? true : i > 0 ? controller.data.value.data!.first.scores!.shot![i-1].total != 0 && controller.data.value.data![1].scores!.shot![i-1].total != 0 : controller.data.value.data!.first.scores!.shot![i].total != 0 && controller.data.value.data![1].scores!.shot![i].total != 0,
                                onClick: () async {
                                  if(controller.data.value.data!.first.scores!.win == 0 && controller.data.value.data![1].scores!.win == 0) {
                                    if ((i == 0) ? true
                                        : controller.data.value.data!.first.scores!.shot![i-1].total != 0 && controller.data.value.data![1].scores!.shot![i-1].total != 0) {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScoreRecordEliminationScreen(
                                                  data: controller.data.value,
                                                  index: i,
                                                  code:controller.code.value,)),
                                      );
                                      if (result != null) controller
                                          .refreshData();
                                    }
                                  }
                                }),
                            if(controller.isShootOff.value) viewShootOff(),
                            hSpace(25)
                          ],
                        ),
                      ),
                    ),
                    onRefresh: refreshData,
                  ), flex: 1,),
                  bottomNavigationCode()
                  //TODO uncomment this later
                  // viewButtonSubmit()
                ],
              ),
              onWillPop: _onWillPop,
            )),
          ),
        ),
      ),
    );
  }

  viewButtonSubmit(){
    return controller.isLoading.value ? Container() : controller.showButtonSubmit.value ? Container(
      margin: EdgeInsets.all(wValue(15)),
      child: Column(children: [
        Button(title : "Ajukan Scoring Sesi", color : colorAccent, enable : true, onClick: (){
          showConfirmDialog(context,
            content: "Apakah anda sudah yakin ingin mengajukan Skor. karena data sudah tidak dapat di ubah lagi",
            assets: "assets/icons/ic_alert.svg",
            btn2: "Batal",
            onClickBtn2: () {},
            btn3: "Yakin",
            onClickBtn3: () {
              controller.apiSaveScore(1, false);
            },);
        }, fontSize: fontSize(12), fontColor: Colors.white),
      ],),
    ) : Container();
  }

  viewShootOff(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        itemShootOffElimination(index : 0,
            member1 : controller.data.value.data!.first,
            member2: controller.data.value.data![1],
            isActive: true,
            // isActive: (i == 0) ? true : (controller.data.value.data!.first.scores!.extraShot![i-1].status == null) ? false : controller.data.value.data!.first.scores!.extraShot![i-1].status!.toLowerCase() == "draw",
            onClick: () async {
              if(controller.data.value.data!.first.scores!.win == 0 && controller.data.value.data![1].scores!.win == 0) {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShootOffScreen(data: controller.data.value, index: 0, code: controller.code.value)),
                );
                if (result != null) controller.refreshData();
              }
            })
      ],
    );
  }

  Future refreshData() async {
    controller.refreshData();
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
                    isActive: ("${controller.savedArcherData[0].code}" == "${controller.code.value}"),
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
                    isActive: ("${controller.savedArcherData[1].code}" == "${controller.code.value}"),
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
                    isActive: ("${controller.savedArcherData[2].code}" == "${controller.code.value}"),
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
                    isActive: ("${controller.savedArcherData[3].code}" == "${controller.code.value}"),
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
                    isActive: ("${controller.savedArcherData[4].code}" == "${controller.code.value}"),
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
                    isActive: ("${controller.savedArcherData[5].code}" == "${controller.code.value}"),
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
                    ("${controller.savedArcherData[6].code}" ==
                        "${controller.code.value}"),
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
                    isActive: ("${controller.savedArcherData[7].code}" == "${controller.code.value}"),
                    onClick: () {
                      // controller.onClickSavedArcher(index: 7);
                    },
                    onDelete: () {
                      // controller.onDeleteSavedArcher(index : 7);
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
        // controller.setValueKeyParticipant(true);
        goToPage(ScanQrScreen());
      },
    );
  }

  Future<bool> _onWillPop() async {
    closeAlert();
    return true;
  }

  viewHeader(){
    return Card(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
      child: Container(
        height: hValue(50),
        child: Stack(
          children: [
            Row(
              children: [
                wSpace(5),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(controller.isLoading.value ? "-" :
                    controller.data.value.data?.first.participant != null ?
                    "${controller.data.value.data?.first.participant?.member?.name}" :
                    "${controller.data.value.data?.first.teamDetail?.teamName}", style: regularTextFont.copyWith(fontSize: fontSize(12)), textAlign: TextAlign.center,maxLines: 2, overflow: TextOverflow.ellipsis)
                  ],
                ), flex: 1,),
                wSpace(5),
                Parallelogram(
                  cutLength: 10.0,
                  edge: Edge.RIGHT,
                  child: Container(
                    color: card,
                    width: wValue(120),
                    height: hValue(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${controller.isLoading.value ? "0" : controller.finalScore1.value}-${controller.isLoading.value ? "0" :  controller.finalScore2.value}", style: boldTextFont.copyWith(fontSize: fontSize(16), color: Colors.white),),
                        // hSpace(4),
                        // Text("Set ${controller.isLoading.value ? "-" : controller.data.value.data?.first.session}", style: regularTextFont.copyWith(fontSize: fontSize(10), color: Colors.white),),
                      ],
                    ),
                  ),
                ),
                wSpace(5),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(controller.isLoading.value ? "-" :
                    controller.data.value.data![1].participant != null ?
                    "${controller.data.value.data![1].participant?.member?.name}" :
                    "${controller.data.value.data![1].teamDetail?.teamName}", style: regularTextFont.copyWith(fontSize: fontSize(12)), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,)
                  ],
                ), flex: 1,),
                wSpace(5),
              ],
            ),
            controller.isLoading.value ? Container() : (controller.data.value.data!.first.scores!.win == 1) ? Container(
              margin: EdgeInsets.only(left: wValue(95)),
              child: Align(
                child: SvgPicture.asset("assets/icons/ic_trophy_active.svg"),
                alignment: Alignment.centerLeft,
              ),
            ) : Container(),
            controller.isLoading.value ? Container() : (controller.data.value.data![1].scores!.win == 1) ? Container(
              margin: EdgeInsets.only(left: wValue(205)),
              child: Align(
                child: SvgPicture.asset("assets/icons/ic_trophy_active.svg"),
                alignment: Alignment.centerLeft,
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }

  viewSessionInfo(){
    return Card(
      color: card,
      child:
      Container(
        width: Get.width,
        child: Wrap(
          children: [
            Center(
              child: Text(controller.isLoading.value ? "-" :
              controller.data.value.data?.first.participant != null ?
              "${controller.data.value.data?.first.participant?.categoryLabel}\n${controller.typeScoring.value}" :
              "${controller.data.value.data?.first.category!.ageCategoryId}-${controller.data.value.data?.first.category!.teamCategoryId}-${controller.data.value.data?.first.category!.competitionCategoryId}\n${controller.typeScoring.value}", style: boldTextFont.copyWith(fontSize: fontSize(10), color: Colors.white), textAlign: TextAlign.center,),
            )
          ],
        ),
        padding: EdgeInsets.all(wValue(8)),
      ),
    );
  }

  closeAlert(){
    if(controller.data.value.data!.first.scores!.result == null && controller.data.value.data![1].scores!.result == null) {
      showConfirmDialog(context, content: "Are you sure want to exit this page?", btn1: "Cancel", btn3: "Yes", onClickBtn1: (){

      }, onClickBtn3: (){
        goToPage(MainScreen(), dismissAllPage: true);
      });
    }else{
      Get.off(MainScreen());
    }
  }
}

class ItemSesi extends StatelessWidget {
  final SavedEliminationModel item;
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
