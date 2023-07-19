import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_archery/core/models/response/response.dart';
import 'package:my_archery/ui/pages/scoring/qualification/record/score_record_qualification_controller.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';
import 'package:my_archery/utils/translator.dart';

import '../../../../../core/models/saved_scoresheet_model.dart';

class ScoreRecordQualificationScreen extends StatefulWidget {

  final SavedScoresheetModel? selectedSavedArcher;
  final DataFindParticipantScoreDetailModel? data;
  final String? scheduleId;
  final int? index;

  const ScoreRecordQualificationScreen({Key? key, this.selectedSavedArcher, this.data, this.scheduleId, this.index}) : super(key: key);

  @override
  _ScoreRecordQualificationScreenState createState() => _ScoreRecordQualificationScreenState();
}

class _ScoreRecordQualificationScreenState extends State<ScoreRecordQualificationScreen> {
  
  var controller = ScoreRecordQualificationController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterInit());
    super.initState();
  }

  afterInit(){
    controller.tempData.value = widget.data!;
    controller.scheduleId.value = widget.scheduleId!;
    controller.selectedSavedArcher.value = widget.selectedSavedArcher!;
    controller.currentIndex.value = widget.index!;
    controller.setSelectedScore(controller.currentIndex.value);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorAccentDark,
      child: BaseContainer(
        child: SafeArea(
          child: Scaffold(
            appBar: appBar(Translator.scoreRecord.tr, (){
              controller.backProcess(context);
            }, bgColor: colorAccent, textColor: Colors.white, iconColor: Colors.white),
            body: Obx(()=> WillPopScope(
              child: GestureDetector(
                child: Container(
                  child: Stack(
                    children: [
                      Container(
                        height: Get.height,
                        margin: EdgeInsets.all(wValue(15)),
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width,
                                    child: Text("${controller.tempData.value.budrestNumber!} - ${controller.tempData.value.participant!.member!.name}", style: boldTextFont.copyWith(fontSize: fontSize(11), color: colorAccent), textAlign: TextAlign.center,),
                                    padding: EdgeInsets.only(left: wValue(15), right: wValue(15), top: hValue(10), bottom: hValue(10)),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE7EDF6),
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: colorAccent),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: hValue(15)),
                                    child: Row(
                                      children: [
                                        Container(
                                          width : wValue(70),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                                            color  : Color(0xFFFFCD6A),
                                          ),
                                          padding: EdgeInsets.only(left : wValue(10), right: wValue(10), top: hValue(7), bottom: hValue(7)),
                                          child: Text("Sesi ${controller.tempData.value.session}",style: regularTextFont.copyWith(fontSize: fontSize(10), color: colorAccent),),
                                        ),
                                        wSpace(3),
                                        Expanded(child: Container(
                                          decoration: BoxDecoration(
                                            color  : Color(0xFFE7EDF6),
                                          ),
                                          padding: EdgeInsets.only(left: wValue(25), right: wValue(25), top: hValue(7), bottom: hValue(7)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset("assets/icons/ic_arrow.svg"),
                                              wSpace(10),
                                              Expanded(
                                                child: Text("${controller.tempData.value.participant!.competitionCategoryId}",style: regularTextFont.copyWith(fontSize: fontSize(10), color: colorAccent),),
                                                flex: 1,
                                              )
                                            ],
                                          ),
                                        ), flex: 1,),
                                        wSpace(3),
                                        Container(
                                          width : wValue(100),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
                                            color  : Color(0xFFE7EDF6),
                                          ),
                                          padding: EdgeInsets.only(left : wValue(10), right: wValue(10), top: hValue(7), bottom: hValue(7)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset("assets/icons/ic_distance.svg", color: colorAccent,),
                                              wSpace(10),
                                              Expanded(child: Text("${controller.tempData.value.participant!.distanceId}m",style: regularTextFont.copyWith(fontSize: fontSize(10), color: colorAccent),), flex: 1,)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hSpace(15),
                            Row(
                              children: [
                                Expanded(child: Text("Rambahan ${controller.currentIndex.value+1}/6", style: boldTextFont.copyWith(fontSize: fontSize(12)),), flex: 1,),
                                Row(
                                  children: [
                                    Text("Sum", style: boldTextFont.copyWith(fontSize: fontSize(12)),),
                                    wSpace(5),
                                    Container(
                                      width: wValue(60),
                                      height: hValue(30),
                                      child: EditText(controller: controller.sumTextController.value, enable: false, textAlign: TextAlign.center, contentPadding: EdgeInsets.all(0)),
                                    )
                                  ],
                                )
                              ],
                            ),
                            hSpace(25),
                            Expanded(child: GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              childAspectRatio: 1.5,
                              mainAxisSpacing: 15,
                              children: <Widget>[
                                for(int i = 0; i < 6; i++) itemShootRecordRow(i: i, selectedScore: controller.selectedScore, selectedRow: controller.selectedRow.value, onTap: (){
                                  controller.selectedRow.value = i;
                                  controller.showKeyboard.value = true;
                                })
                              ],
                            )),
                          ],
                        ),
                      ),
                      Positioned(child: controller.selectedScore.where((i) => i == "").length > 0 ? Container() : Column(children: [
                        ButtonBorder(title : Translator.save.tr, color : colorAccent, enable : true, onClick: (){
                          controller.apiSaveScore(false);
                        }, fontSize: fontSize(12), fontColor: Colors.black),
                        hSpace(10),
                        controller.currentIndex.value+1 == 6 ? Container() : Button(title : "next".tr, color : colorAccentDark, enable : true, onClick: (){
                          controller.apiSaveScore(true);
                        }, fontSize: fontSize(12))
                      ],), bottom: hValue(15), left: wValue(15), right: wValue(15),),
                      Positioned(child: controller.showKeyboard.value ? keyboardShoot(
                        onXTap: (){
                          controller.selectedScore[controller.selectedRow.value] = "X";
                          controller.assignNewValue(controller.currentIndex.value, "x");
                          controller.moveToNext();
                          controller.countSum();
                        },
                        on10Tap: (){
                          controller.selectedScore[controller.selectedRow.value] = "10";
                          controller.assignNewValue(controller.currentIndex.value, "10");
                          controller.moveToNext();
                          controller.countSum();
                        },
                        on9Tap: (){
                          controller.selectedScore[controller.selectedRow.value] = "9";
                          controller.assignNewValue(controller.currentIndex.value, "9");
                          controller.moveToNext();
                          controller.countSum();
                        },
                        on8Tap: (){
                          controller.selectedScore[controller.selectedRow.value] = "8";
                          controller.assignNewValue(controller.currentIndex.value, "8");
                          controller.moveToNext();
                          controller.countSum();
                        },
                        on7Tap: (){
                          controller.selectedScore[controller.selectedRow.value] = "7";
                          controller.assignNewValue(controller.currentIndex.value, "7");
                          controller.moveToNext();
                          controller.countSum();
                        },
                        on6Tap: (){
                          controller.selectedScore[controller.selectedRow.value] = "6";
                          controller.assignNewValue(controller.currentIndex.value, "6");
                          controller.moveToNext();
                          controller.countSum();
                        },
                        on5Tap: (){
                          controller.selectedScore[controller.selectedRow.value] = "5";
                          controller.assignNewValue(controller.currentIndex.value, "5");
                          controller.moveToNext();
                          controller.countSum();
                        },
                        on4Tap: (){
                          controller.selectedScore[controller.selectedRow.value] = "4";
                          controller.assignNewValue(controller.currentIndex.value, "4");
                          controller.moveToNext();
                          controller.countSum();
                        },
                        on3Tap: (){
                          controller.selectedScore[controller.selectedRow.value] = "3";
                          controller.assignNewValue(controller.currentIndex.value, "3");
                          controller.moveToNext();
                          controller.countSum();
                        },
                        on2Tap: (){
                          controller.selectedScore[controller.selectedRow.value] = "2";
                          controller.assignNewValue(controller.currentIndex.value, "2");
                          controller.moveToNext();
                          controller.countSum();
                        },
                        on1Tap: (){
                          controller.selectedScore[controller.selectedRow.value] = "1";
                          controller.assignNewValue(controller.currentIndex.value, "1");
                          controller.moveToNext();
                          controller.countSum();
                        },
                        onMTap: (){
                          controller.selectedScore[controller.selectedRow.value] = "M";
                          controller.assignNewValue(controller.currentIndex.value, "m");
                          controller.moveToNext();
                          controller.countSum();
                        },
                        onDeleteTap: (){
                          controller.selectedScore[controller.selectedRow.value] = "";
                          controller.assignNewValue(controller.currentIndex.value, "");
                          controller.moveToPrev();
                          controller.countSum();
                        },
                        onLongDeleteTap: (){
                          controller.clearAllValue(controller.currentIndex.value);
                          controller.countSum();
                        },
                        onEnter: (){controller.showKeyboard.value = false;},
                      ) : Container(), bottom: 0,),
                    ],
                  ),
                  width: Get.width,
                  height: Get.height,
                ),
                onTap: (){
                  if(controller.showKeyboard.value){
                    controller.showKeyboard.value = false;
                  }
                },
              ),
              onWillPop: _onWillPop,
            )),
          ),
        ),
      )
    );
  }

  Future<bool> _onWillPop() async {
    controller.backProcess(context);
    return false;
  }
}
