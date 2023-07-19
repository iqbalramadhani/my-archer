import 'dart:async';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';

import '../../../../../../../core/models/response/response.dart';
import 'shoot_off_controller.dart';

class ShootOffScreen extends StatefulWidget {
  final FindParticipantScoreEliminationDetailResponse data;
  final int index;
  final String code;
  const ShootOffScreen({Key? key, required this.data, required this.index, required this.code}) : super(key: key);

  @override
  _ShootOffScreenState createState() => _ShootOffScreenState();
}

class _ShootOffScreenState extends State<ShootOffScreen> {

  var controller = ShootOffController();
  var scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterInit());
    super.initState();
  }

  afterInit(){
    controller.code.value = widget.code;
    controller.currentIndex.value = widget.index;
    controller.initController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: BaseContainer(
        child: Obx(()=> WillPopScope(
          onWillPop: _onWillPop,
          child: SafeArea(
            child: Stack(
              children: [
                GestureDetector(
                  child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    backgroundColor: bgPage,
                    appBar: appBar("Shoot Off - ${controller.typeScoring.value}", (){
                      controller.backProcess(context);
                    }),
                    body: controller.isLoading.value ? loading() : Column(
                      children: [
                        Expanded(child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          controller: scrollController,
                          child: Column(
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    viewHeader(),
                                    viewSessionInfo(),
                                    hSpace(14),
                                    viewScoringMember1(),
                                    hSpace(14),
                                    viewScoringMember2(),
                                    hSpace(controller.showKeyboard.value ? 200 : 14),
                                  ],
                                ),
                                padding: EdgeInsets.all(wValue(15)),
                              ),
                              // showKeyboard()
                            ],
                          ),
                        ), flex: 1,),
                        viewButton()
                      ],
                    ),
                  ),
                  onTap: (){
                    controller.showKeyboard.value = false;
                  },
                ),
                Positioned(child: showKeyboard(), bottom: 0,),
              ],
            ),
          ),
        )),
      ),
    );
  }

  viewHeader(){
    return Card(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
      child: Container(
        child: Row(
          children: [
            Expanded(child: Column(
              children: [
                Text(widget.data.data!.first.participant != null ?
                "${widget.data.data!.first.participant!.member!.name}" :
                "${widget.data.data!.first.teamDetail!.teamName}", style: boldTextFont.copyWith(fontSize: fontSize(12)), textAlign: TextAlign.center,),
              ],
            ), flex: 1,),
            Container(
              child: Stack(
                children: [
                  Center(
                    child: Parallelogram(
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(child: Positioned(child: SvgPicture.asset("assets/icons/ic_trophy.svg"), left:0, top: 0, bottom: 0,), visible: false,),
                  Visibility(child: Positioned(child: SvgPicture.asset("assets/icons/ic_trophy.svg"), right:0, top: 0, bottom: 0,), visible: false,),
                ],
              ),
              width: wValue(130),
            ),
            Expanded(child: Column(
              children: [
                Text(widget.data.data![1].participant != null ?
                "${widget.data.data![1].participant!.member!.name!}" :
                "${widget.data.data![1].teamDetail!.teamName}", style: boldTextFont.copyWith(fontSize: fontSize(12)), textAlign: TextAlign.center,)
              ],
            ), flex: 1,)
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
              child: Text("Session : ${controller.data.value.data!.first.session}\n"
                  "${controller.data.value.data!.first.participant != null ?
              controller.data.value.data!.first.participant!.categoryLabel :
              "${controller.data.value.data!.first.category!.ageCategoryId}-${controller.data.value.data!.first.category!.teamCategoryId}-${controller.data.value.data!.first.category!.competitionCategoryId}"}\n(Rambahan ${controller.currentIndex.value +1})",
                style: boldTextFont.copyWith(fontSize: fontSize(10), color: Colors.white), textAlign: TextAlign.center,),
            )
          ],
        ),
        padding: EdgeInsets.all(wValue(8)),
      ),
    );
  }

  viewScoringMember1(){
    return Card(
      elevation: 0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(wValue(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(controller.data.value.data!.first.participant != null ?
                "${controller.data.value.data!.first.participant!.member!.name}"
                    : "${controller.data.value.data!.first.teamDetail!.teamName}",
                    style: boldTextFont.copyWith(fontSize: fontSize(14))),
                SvgPicture.asset(controller.winner.value == 1 ? "assets/icons/ic_trophy_active.svg" : "assets/icons/ic_trophy.svg")
              ],
            ),
            hSpace(15),
            Container(
              child: Row(
                children: [
                  for(int i =0; i<3; i++) Expanded(child: itemShootOffRecordRow(i: i, distance: controller.scoreDistanceArcher1[i],
                      isActive: (i == 0) ? true : (controller.currentExtraShotScoreShotMember1[i-1].score != "" && controller.currentExtraShotScoreShotMember2[i-1].score != "" && controller.currentExtraShotScoreShotMember1[i-1].score == controller.currentExtraShotScoreShotMember2[i-1].score &&
                          controller.scoreDistanceArcher1[i-1].isNotEmpty && controller.scoreDistanceArcher2[i-1].isNotEmpty && controller.scoreDistanceArcher1[i-1] == controller.scoreDistanceArcher2[i-1]),
                      selectedScore: controller.currentExtraShotScoreShotMember1,
                      selectedRow: controller.selectedRow1.value, onTap: (){
                        controller.selectedRow1.value = i;
                        controller.selectedRow2.value = i;
                        controller.showKeyboard.value = true;
                        controller.selectedArcher.value = 1;
                  },
                  onEdit: (){
                    controller.showKeyboard.value = false;
                    showShootOffDistanceDialog(Get.context!,
                        distance1: controller.scoreDistanceArcher1[controller.selectedRow1.value],
                        distance2: controller.scoreDistanceArcher2[controller.selectedRow2.value],
                        firstMemberName: controller.data.value.data!.first.participant != null ? controller.data.value.data!.first.participant!.member!.name :
                        controller.data.value.data!.first.teamDetail!.teamName,
                        secondMemberName: controller.data.value.data![1].participant != null ?
                        controller.data.value.data![1].participant!.member!.name :
                        controller.data.value.data![1].teamDetail!.teamName,
                        onClick: (distances){
                      controller.scoreDistanceArcher1[controller.selectedRow1.value] = distances[0];
                      controller.scoreDistanceArcher2[controller.selectedRow2.value] = distances[1];
                    });
                  }), flex: 1,)
                ],
              ),
              height: hValue(75),
            ),
            hSpace(15),
            Row(
              children: [
                Expanded(child: Container(), flex: 1,),
                Row(
                  children: [
                    Text("Sum", style: boldTextFont.copyWith(fontSize: fontSize(12)),),
                    wSpace(5),
                    Container(
                      width: wValue(60),
                      height: hValue(30),
                      child: EditText(controller: controller.sumTextController1.value, enable: false, textAlign: TextAlign.center, contentPadding: EdgeInsets.all(0)),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  viewScoringMember2(){
    return Card(
      elevation: 0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(wValue(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(controller.data.value.data![1].participant != null ? "${controller.data.value.data![1].participant!.member!.name}" :
                    "${controller.data.value.data![1].teamDetail!.teamName}",
                    style: boldTextFont.copyWith(fontSize: fontSize(14))),
                SvgPicture.asset(controller.winner.value == 2 ? "assets/icons/ic_trophy_active.svg" : "assets/icons/ic_trophy.svg")
              ],
            ),
            hSpace(15),
            Container(
              child: Row(
                children: [
                  for(int i = 0; i < 3; i++) Expanded(child: itemShootOffRecordRow(i: i, distance: controller.scoreDistanceArcher2[i],
                      isActive: (i == 0) ? true : (controller.currentExtraShotScoreShotMember1[i-1].score != "" && controller.currentExtraShotScoreShotMember2[i-1].score != "" && controller.currentExtraShotScoreShotMember1[i-1].score == controller.currentExtraShotScoreShotMember2[i-1].score &&
                          controller.scoreDistanceArcher1[i-1].isNotEmpty && controller.scoreDistanceArcher2[i-1].isNotEmpty && controller.scoreDistanceArcher1[i-1] == controller.scoreDistanceArcher2[i-1]),
                      selectedScore: controller.currentExtraShotScoreShotMember2, selectedRow: controller.selectedRow2.value, onTap: (){
                    controller.selectedRow2.value = i;
                    controller.selectedRow1.value = i;
                    controller.showKeyboard.value = true;
                    controller.selectedArcher.value = 2;

                    //to up the view
                    Timer(Duration(milliseconds: 200), () {
                      scrollController.jumpTo(scrollController.position.maxScrollExtent);
                    });

                  },
                  onEdit: (){
                    controller.showKeyboard.value = false;
                    showShootOffDistanceDialog(Get.context!,
                        distance1: controller.scoreDistanceArcher1[controller.selectedRow1.value],
                        distance2: controller.scoreDistanceArcher2[controller.selectedRow2.value],
                        firstMemberName: controller.data.value.data!.first.participant != null ?
                        controller.data.value.data!.first.participant!.member!.name :
                        controller.data.value.data!.first.teamDetail!.teamName,
                        secondMemberName: controller.data.value.data![1].participant != null ?
                        controller.data.value.data![1].participant!.member!.name :
                        controller.data.value.data![1].teamDetail!.teamName,
                        onClick: (distances){
                          controller.scoreDistanceArcher1[controller.selectedRow1.value] = distances[0];
                          controller.scoreDistanceArcher2[controller.selectedRow2.value] = distances[1];
                        });
                  }), flex: 1,)
                ],
              ),
              height: hValue(75),
            ),
            hSpace(15),
            Row(
              children: [
                Expanded(child: Container(), flex: 1,),
                Row(
                  children: [
                    Text("Sum", style: boldTextFont.copyWith(fontSize: fontSize(12)),),
                    wSpace(5),
                    Container(
                      width: wValue(60),
                      height: hValue(30),
                      child: EditText(controller: controller.sumTextController2.value, enable: false, textAlign: TextAlign.center, contentPadding: EdgeInsets.all(0)),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  viewButton(){
    return Container(
      child: Column(
        children: [
          ButtonBorder(title : "Simpan", color : colorAccent, enable : controller.isSaveValid.value, onClick: (){
            controller.apiSaveScore(0, true);
          }),
          hSpace(5),
          //TODO uncomment this later
          // Button("Submit", colorAccent, controller.isNextValid.value, (){
          //   controller.apiSaveScore(1, true);
          // }),
        ],
      ),
      margin: EdgeInsets.all(wValue(15)),
    );
  }

  showKeyboard(){
    return controller.showKeyboard.value ? keyboardShoot(
      onXTap: (){
        if(controller.selectedArcher.value == 1){
          controller.currentExtraShotScoreShotMember1[controller.selectedRow1.value].score = "X";
        }else controller.currentExtraShotScoreShotMember2[controller.selectedRow2.value].score = "X";

        controller.assignNewValue("x");
        controller.countSum();
        controller.moveToNext();

        //to up the view
        Timer(Duration(milliseconds: 200), () {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      },
      on10Tap: (){
        if(controller.selectedArcher.value == 1){
          controller.currentExtraShotScoreShotMember1[controller.selectedRow1.value].score = "10";
        }else controller.currentExtraShotScoreShotMember2[controller.selectedRow2.value].score = "10";

        controller.assignNewValue("10");
        controller.countSum();
        controller.moveToNext();
      },
      on9Tap: (){
        if(controller.selectedArcher.value == 1){
          controller.currentExtraShotScoreShotMember1[controller.selectedRow1.value].score = "9";
        }else controller.currentExtraShotScoreShotMember2[controller.selectedRow2.value].score = "9";

        controller.assignNewValue("9");
        controller.countSum();
        controller.moveToNext();
      },
      on8Tap: (){
        if(controller.selectedArcher.value == 1){
          controller.currentExtraShotScoreShotMember1[controller.selectedRow1.value].score = "8";
        }else controller.currentExtraShotScoreShotMember2[controller.selectedRow2.value].score = "8";

        controller.assignNewValue("8");
        controller.countSum();
        controller.moveToNext();
      },
      on7Tap: (){
        if(controller.selectedArcher.value == 1){
          controller.currentExtraShotScoreShotMember1[controller.selectedRow1.value].score = "7";
        }else controller.currentExtraShotScoreShotMember2[controller.selectedRow2.value].score = "7";

        controller.assignNewValue("7");
        controller.countSum();
        controller.moveToNext();
      },
      on6Tap: (){
        if(controller.selectedArcher.value == 1){
          controller.currentExtraShotScoreShotMember1[controller.selectedRow1.value].score = "6";
        }else controller.currentExtraShotScoreShotMember2[controller.selectedRow2.value].score = "6";

        controller.assignNewValue("6");
        controller.countSum();
        controller.moveToNext();
      },
      on5Tap: (){
        if(controller.selectedArcher.value == 1){
          controller.currentExtraShotScoreShotMember1[controller.selectedRow1.value].score = "5";
        }else controller.currentExtraShotScoreShotMember2[controller.selectedRow2.value].score = "5";

        controller.assignNewValue("5");
        controller.countSum();
        controller.moveToNext();
      },
      on4Tap: (){
        if(controller.selectedArcher.value == 1){
          controller.currentExtraShotScoreShotMember1[controller.selectedRow1.value].score = "4";
        }else controller.currentExtraShotScoreShotMember2[controller.selectedRow2.value].score = "4";

        controller.assignNewValue("4");
        controller.countSum();
        controller.moveToNext();
      },
      on3Tap: (){
        if(controller.selectedArcher.value == 1){
          controller.currentExtraShotScoreShotMember1[controller.selectedRow1.value].score = "3";
        }else controller.currentExtraShotScoreShotMember2[controller.selectedRow2.value].score = "3";

        controller.assignNewValue("3");
        controller.countSum();
        controller.moveToNext();
      },
      on2Tap: (){
        if(controller.selectedArcher.value == 1){
          controller.currentExtraShotScoreShotMember1[controller.selectedRow1.value].score = "2";
        }else controller.currentExtraShotScoreShotMember2[controller.selectedRow2.value].score = "2";

        controller.assignNewValue("2");
        controller.countSum();
        controller.moveToNext();
      },
      on1Tap: (){
        if(controller.selectedArcher.value == 1){
          controller.currentExtraShotScoreShotMember1[controller.selectedRow1.value].score = "1";
        }else controller.currentExtraShotScoreShotMember2[controller.selectedRow2.value].score = "1";

        controller.assignNewValue("1");
        controller.countSum();
        controller.moveToNext();
      },
      onMTap: (){
        if(controller.selectedArcher.value == 1){
          controller.currentExtraShotScoreShotMember1[controller.selectedRow1.value].score = "M";
        }else controller.currentExtraShotScoreShotMember2[controller.selectedRow2.value].score = "M";

        controller.assignNewValue("m");
        controller.countSum();
        controller.moveToNext();
      },
      onDeleteTap: (){
        if(controller.selectedArcher.value == 1){
          controller.currentExtraShotScoreShotMember1[controller.selectedRow1.value].score = "";
        }else controller.currentExtraShotScoreShotMember2[controller.selectedRow2.value].score = "";

        controller.assignNewValue("");
        controller.countSum();
        controller.moveToPrev();
      },
      onLongDeleteTap: (){
        controller.clearAllValue();
        controller.countSum();
      },
      onEnter: (){controller.showKeyboard.value = false;},
    ) : Container();
  }

  Future<bool> _onWillPop() async {
    controller.backProcess(context);
    return false;
  }
}
