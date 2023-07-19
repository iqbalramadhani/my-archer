import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_archery/ui/pages/result_scan/qualification/result_scan_qualification_controller.dart';
import 'package:my_archery/utils/screen_util.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';
import 'package:my_archery/utils/translator.dart';

import '../../../../core/models/response/response.dart';
import '../../../shared/widget.dart';

class ResultScanQualificationScreen extends StatefulWidget {

  final String code;
  final List<DataFindParticipantScoreDetailModel>? data;

  const ResultScanQualificationScreen({Key? key, required this.code, this.data}) : super(key: key);

  @override
  _ResultScanQualificationScreenState createState() => _ResultScanQualificationScreenState();
}

class _ResultScanQualificationScreenState extends State<ResultScanQualificationScreen> {
  var controller = ResultScanQualificationController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterInit());
    super.initState();
  }

  afterInit(){
    controller.code.value = widget.code;
    // List<DataFindParticipantScoreDetailModel> revParticipants = <DataFindParticipantScoreDetailModel>[];
    // revParticipants.addAll(widget.data!);
    widget.data!.sort((a, b) {
      return a.budrestNumber!.toLowerCase().compareTo(b.budrestNumber!.toLowerCase());
    });
    controller.currentData.addAll(widget.data!);
    controller.initController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: BaseContainer(
        child: SafeArea(
          child: Obx(()=> Scaffold(
            appBar: appBar(Translator.archerId.tr, (){
              Get.back();
            }),
            backgroundColor: bgPage,
            body: Column(
              children: [
                Expanded(child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for(var item in controller.currentData) ItemParticipant(data:item, onChange: (v){
                        controller.currentData[controller.currentData.indexWhere((p0) => p0.participant!.id == item.participant!.id)].budrestNumber = v;
                      },)
                    ],
                  ),
                ), flex: 1,),
                Container(
                  child: Button(title: Translator.confirm.tr, color : colorAccent, enable : true, onClick: (){
                    if(controller.isAnyEmptyBudrest.value){
                      // if(controller.currentData.any((element) => element.budrestNumber!.isEmpty)){
                      //   errorToast(msg: "Harap lengkapi Bantalan terlebih dahulu");
                      //   return;
                      // }

                      controller.setBudrestNumber();
                    }else{
                      controller.moveToNext();
                    }
                  }),
                  margin: EdgeInsets.all(wValue(15)),
                )
              ],
            ),
          )),
        ),
      )
    );
  }
}

class ItemParticipant extends StatelessWidget {
  final DataFindParticipantScoreDetailModel data;
  final Function onChange;
  const ItemParticipant({Key? key, required this.data, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var bantalanController = TextEditingController();
    if(data.budrestNumber != ""){
      bantalanController.text = data.budrestNumber!;
    }

    return Container(
      margin: EdgeInsets.all(ScreenUtil().setWidth(15)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translator.archerName.tr, style: regularTextFont.copyWith(fontSize: fontSize(12))),
          SizedBox(height: ScreenUtil().setHeight(5),),
          Text("${data.participant!.member!.name}", style: boldTextFont.copyWith(fontSize: fontSize(14))),

          hSpace(15),
          Text(Translator.club.tr, style: regularTextFont.copyWith(fontSize: fontSize(12))),
          SizedBox(height: ScreenUtil().setHeight(5),),
          Text("${data.participant!.club}", style: boldTextFont.copyWith(fontSize: fontSize(14))),

          hSpace(15),
          Text(Translator.category.tr, style: regularTextFont.copyWith(fontSize: fontSize(12))),
          SizedBox(height: ScreenUtil().setHeight(5),),
          Text("${data.participant!.categoryLabel}", style: boldTextFont.copyWith(fontSize: fontSize(14))),

          hSpace(15),
          Row(
            children: [
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Translator.session.tr, style: regularTextFont.copyWith(fontSize: fontSize(12))),
                  SizedBox(height: ScreenUtil().setHeight(5),),
                  Text("${data.session!}", style: boldTextFont.copyWith(fontSize: fontSize(14))),
                ],
              ), flex: 1,),
              wSpace(15),
            ],
          ),

          hSpace(15),
          Text(Translator.bantalan.tr, style: boldTextFont.copyWith(fontSize: ScreenUtil().setSp(14))),
          SizedBox(height: ScreenUtil().setHeight(5),),
          EditText(textInputType: TextInputType.text, textInputAction: TextInputAction.done,
              enable: data.budrestNumber?.isEmpty,
              contentPadding: EdgeInsets.only(left: wValue(15), right: wValue(15)),  controller: bantalanController, hintText: "input_bantalan".tr,
              onChange: (v){
                onChange(v);
              }),
        ],
      ),
      padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
    );
  }
}

