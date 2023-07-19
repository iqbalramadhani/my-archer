import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_archery/ui/pages/result_scan/elimination/result_scan_elimination_controller.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/screen_util.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';
import 'package:my_archery/utils/translator.dart';

import '../../../../../core/models/response/response.dart';

class ResultScanEliminationScreen extends StatefulWidget {
  final String kode;
  final FindParticipantScoreEliminationDetailResponse data;
  const ResultScanEliminationScreen({Key? key, required this.data, required this.kode}) : super(key: key);

  @override
  _ResultScanEliminationScreenState createState() => _ResultScanEliminationScreenState();
}

class _ResultScanEliminationScreenState extends State<ResultScanEliminationScreen> {

  var controller = ResultScanEliminationController();

  @override
  void initState() {
    controller.dataResp.value = widget.data;
    controller.code.value = widget.kode;
    controller.initController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorPrimary,
        child: BaseContainer(
          child: SafeArea(
            child: Scaffold(
              appBar: appBar(Translator.archerId.tr, (){
                Get.back();
              }),
              backgroundColor: bgPage,
              body: Column(
                children: [
                  Expanded(child: SingleChildScrollView(
                    child: Column(
                      children: [
                        viewGeneral(),
                        for(var item in widget.data.data!) (widget.data.data!.first.participant == null) ? itemParticipantTeam(item) : itemParticipant(item)
                      ],
                    ),
                  ), flex: 1,),
                  Container(
                    child: Button(title : Translator.confirm.tr, color : colorAccent, enable: true, onClick: (){
                      controller.processConfirm();
                    }),
                    margin: EdgeInsets.all(wValue(15)),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  viewGeneral(){
    return Container(
      margin: EdgeInsets.all(wValue(15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translator.category.tr, style: regularTextFont.copyWith(fontSize: fontSize(12))),
          SizedBox(height: hValue(5),),
          Text(widget.data.data!.first.participant != null ? "${widget.data.data!.first.participant!.categoryLabel}" : "${widget.data.data!.first.category!.ageCategoryId}-${widget.data.data!.first.category!.teamCategoryId}-${widget.data.data!.first.category!.competitionCategoryId}", style: boldTextFont.copyWith(fontSize: fontSize(14))),

          hSpace(15),
          Row(
            children: [
              if(widget.data.data?.first.session != null) Expanded(child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Translator.session.tr, style: regularTextFont.copyWith(fontSize: fontSize(12))),
                    SizedBox(height: hValue(5),),
                    Text(widget.data.data?.first.session == null ? "-" : "Babak ${widget.data.data?.first.session}", style: boldTextFont.copyWith(fontSize: fontSize(14))),
                  ],
                ),
                margin: EdgeInsets.only(right: wValue(15)),
              ), flex: 1,),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Translator.distance.tr, style: regularTextFont.copyWith(fontSize: fontSize(12))),
                  SizedBox(height: hValue(5),),
                  Text(widget.data.data!.first.participant != null ? "${widget.data.data!.first.participant!.distanceId} M" : "${widget.data.data?.first.category?.distanceId} M", style: boldTextFont.copyWith(fontSize: fontSize(14))),
                ],
              ), flex: 1,),
            ],
          ),

          hSpace(15),
          Text(Translator.bantalan.tr, style: boldTextFont.copyWith(fontSize: ScreenUtil().setSp(14))),
          SizedBox(height: ScreenUtil().setHeight(5),),
          EditText(textInputType: TextInputType.text, textInputAction: TextInputAction.done,
              enable: widget.data.data!.first.budrestNumber!.isEmpty,
              contentPadding: EdgeInsets.only(left: wValue(15), right: wValue(15)),  controller: controller.bantalanController.value, hintText: "input_bantalan".tr),
        ],
      ),
      padding: EdgeInsets.all(wValue(15)),
    );
  }

  itemParticipant(DataEliminationParticipantModel data){
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(left: wValue(15), right: wValue(15), bottom: hValue(15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translator.archerName.tr, style: regularTextFont.copyWith(fontSize: fontSize(12))),
          SizedBox(height: hValue(5),),
          Text("${data.participant?.member?.name}", style: boldTextFont.copyWith(fontSize: fontSize(14))),

          hSpace(15),
          Text(Translator.club.tr, style: regularTextFont.copyWith(fontSize: fontSize(12))),
          SizedBox(height: hValue(5),),
          Text(data.participant?.club == "" || data.participant?.club == null ? "-" : "${data.participant?.club}", style: boldTextFont.copyWith(fontSize: fontSize(14))),
        ],
      ),
      padding: EdgeInsets.all(wValue(15)),
    );
  }

  itemParticipantTeam(DataEliminationParticipantModel data){
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(left: wValue(15), right: wValue(15), bottom: hValue(15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translator.archerName.tr, style: regularTextFont.copyWith(fontSize: fontSize(12))),
          SizedBox(height: hValue(5),),
          for(var item in data.listMember!) Container(
            child: Text("${item.name}", style: boldTextFont.copyWith(fontSize: fontSize(14))),
            margin: EdgeInsets.only(bottom: hValue(5)),
          ),

          hSpace(15),
          Text(Translator.teamName.tr, style: regularTextFont.copyWith(fontSize: fontSize(12))),
          SizedBox(height: hValue(5),),
          Text(data.teamDetail?.teamName == "" || data.teamDetail?.teamName == null ? "-" : "${data.teamDetail?.teamName}", style: boldTextFont.copyWith(fontSize: fontSize(14))),

          hSpace(15),
          Text(Translator.club.tr, style: regularTextFont.copyWith(fontSize: fontSize(12))),
          SizedBox(height: hValue(5),),
          Text(data.teamDetail?.club!.name == "" || data.teamDetail?.club == null ? "-" : "${data.teamDetail?.club!.name}", style: boldTextFont.copyWith(fontSize: fontSize(14))),
        ],
      ),
      padding: EdgeInsets.all(wValue(15)),
    );
  }
}
