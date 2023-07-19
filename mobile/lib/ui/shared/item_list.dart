import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_archery/core/models/objects/objects.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';

import '../../core/models/response/response.dart';

itemArcherScore(DataFindParticipantScoreDetailModel data, String? bantalan, bool isSelected, Function onClick, Function onClose) {
  return Card(
    color: isSelected ? card : bgPage,
    elevation: 0,
    child: InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "$bantalan - ${data.participant!.member!.name}",
              style: boldTextFont.copyWith(
                  fontSize: fontSize(10),
                  color: isSelected ? Colors.white : inactive),
            ),
            padding: EdgeInsets.only(
                left: wValue(15),
                right: wValue(5),
                top: hValue(5),
                bottom: hValue(5)),
          ),
          InkWell(
            child: Icon(Icons.cancel, color: Colors.white, size: wValue(15),),
            onTap: (){
              onClose();
            },
          ),
          wSpace(10)
        ],
      ),
      onTap: () {
        onClick();
      },
    ),
  );
}

itemShootRow(int number, bool isLock, DataFindParticipantScoreDetailModel? data, Function onClick) {

  int shoot = 0;
  bool isActive = false;

  //to get selected score
  List<dynamic>? selectedScore;
  if(number == 0){
    selectedScore = data!.score!.one;
  }else if(number == 1){
    selectedScore = data!.score!.two;
  }else if(number == 2){
    selectedScore = data!.score!.three;
  }else if(number == 3){
    selectedScore = data!.score!.four;
  }else if(number == 4){
    selectedScore = data!.score!.five;
  }else if(number == 5){
    selectedScore = data!.score!.six;
  }


  //for count sum nilai
  for(var item in selectedScore!){
    if(item.toString().toLowerCase() == "x"){
      shoot += 10;
    }else if(item.toString().toLowerCase() == "m" || item.toString() == ""){
      shoot += 0;
    }else{
      shoot += int.parse(item);
    }
  }


  //set active row
  if(number == 0){
    isActive = true;
  }else{
    if(number == 1){
      isActive = !data!.score!.one!.any((element) => element.toString() == "");
    }else if(number == 2){
      isActive = !data!.score!.two!.any((element) => element.toString() == "");
    }else if(number == 3){
      isActive = !data!.score!.three!.any((element) => element.toString() == "");
    }else if(number == 4){
      isActive = !data!.score!.four!.any((element) => element.toString() == "");
    }else if(number == 5){
      isActive = !data!.score!.five!.any((element) => element.toString() == "");
    }
  }

  var totalFirstRow = 0;
  var totalSecondRow = 0;

  for(int i = 0; i < 3; i++){
    if(selectedScore[i].toString().toLowerCase() == "x"){
      totalFirstRow += 10;
    }else if(selectedScore[i].toString().toLowerCase() == "m" || selectedScore[i].toString() == ""){
      totalFirstRow += 0;
    }else{
      totalFirstRow += int.parse(selectedScore[i]);
    }
  }

  for(int i = 0; i < 3; i++){
    if(selectedScore[i+3].toString().toLowerCase() == "x"){
      totalSecondRow += 10;
    }else if(selectedScore[i+3].toString().toLowerCase() == "m" || selectedScore[i+3].toString() == ""){
      totalSecondRow += 0;
    }else{
      totalSecondRow += int.parse(selectedScore[i+3]);
    }
  }

  return InkWell(
    child: Container(
      padding: EdgeInsets.only(left: hValue(7), right: hValue(7), bottom: hValue(7)),
      child: Row(
        children: [
          Container(
            height: hValue(68),
            decoration: BoxDecoration(
              color: isLock ? Color(0xFFF6F6F6) : isActive ? Colors.white : Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: grey2),
            ),
            padding: EdgeInsets.only(left: wValue(15), right: wValue(15)),
            child: Center(
              child: Text(
                "${number+1}",
                textAlign: TextAlign.center,
                style: regularTextFont.copyWith(fontSize: fontSize(12)),
              ),
            ),
          ),
          wSpace(2),
          Expanded(child: Column(
            children: [
              Container(
                padding : EdgeInsets.only(top: hValue(3), bottom: hValue(3), left: wValue(5), right: wValue(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          for (int i = 0; i < 3; i++) itemCircleShootRow(selectedScore[i], isActive)
                        ],
                      ),
                      flex: 1,
                    ),
                    wSpace(15),
                    Text(
                      "$totalFirstRow",
                      style: regularTextFont.copyWith(fontSize: fontSize(12)),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: isLock ? Color(0xFFF6F6F6) : isActive ? Colors.white : Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: grey2),
                ),
              ),
              hSpace(3),
              Container(
                padding : EdgeInsets.only(top: hValue(3), bottom: hValue(3), left: wValue(5), right: wValue(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          for (int i = 0; i < 3; i++) itemCircleShootRow(selectedScore[i+3], isActive)
                        ],
                      ),
                      flex: 1,
                    ),
                    wSpace(15),
                    Text(
                      "$totalSecondRow",
                      style: regularTextFont.copyWith(fontSize: fontSize(12)),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: isLock ? Color(0xFFF6F6F6) : isActive ? Colors.white : Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: grey2),
                ),
              ),
            ],
          ), flex: 1,),
          wSpace(2),
          Container(
            width: wValue(55),
            height: hValue(68),
            decoration: BoxDecoration(
              color: isLock ? Color(0xFFF6F6F6) : isActive ? Colors.white : Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: grey2),
            ),
            padding: EdgeInsets.only(left: wValue(15), right: wValue(15)),
            child: Center(
              child: Text(
                "$shoot",
                textAlign: TextAlign.center,
                style: regularTextFont.copyWith(fontSize: fontSize(12)),
              ),
            ),
          ),
        ],
      ),
    ),
    onTap: () {
      if(isActive) onClick();
    },
  );
}

itemCircleShootRow(String value, bool isActive){

  Color? bgColor;
  Color? borderColor;
  Color? textColor;

  if((value.toString().toUpperCase() == "X" || value.toString() == "10" || value.toString() == "9")){
    bgColor = yellow;
    borderColor = yellow;
    textColor = Colors.black;
  }else if(value.toString() == "8" || value.toString() == "7"){
    bgColor = red;
    borderColor = red;
    textColor = Colors.white;
  }else if(value.toString() == "6" || value.toString() == "5"){
    bgColor = card;
    borderColor = card;
    textColor = Colors.white;
  }else if(value.toString() == "4" || value.toString() == "3"){
    bgColor = Colors.black;
    borderColor = Colors.black;
    textColor = Colors.white;
  }else if(value.toString() == "2" || value.toString() == "1"){
    bgColor = Colors.white;
    borderColor = inactive;
    textColor = Colors.black;
  }else if(value.toString().toUpperCase() == "M"){
    bgColor = inactive;
    borderColor = inactive;
    textColor = Colors.black;
  }else{
    bgColor = Colors.white;
    borderColor = colorAccent;
    textColor = Colors.black;
  }

  if(!isActive){
    bgColor = Color(0xFFEEEEEE);
    borderColor = inactive;
    textColor = Colors.white;
  }
  
  return Container(
    margin: EdgeInsets.only(right: wValue(10)),
    width: wValue(25),
    height: hValue(25),
    child: Center(
      child: Text("${value.toString().toUpperCase()}", style: boldTextFont.copyWith(fontSize: fontSize(10), color: textColor),),
    ),
    decoration: new BoxDecoration(
      color: bgColor,
      border: Border.all(color: borderColor),
      shape: BoxShape.circle,
    ),
  );
}

itemKeyboard({String? text, Color? bgColor, Color? textColor, Function? onClick, Function? onLongTap}) {
  return Expanded(
    child: Container(
      child: MaterialButton(
          color: bgColor,
          elevation: 2,
          splashColor: Colors.white,
          minWidth: Get.width,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            child: Text("$text",
                style: boldTextFont.copyWith(
                    fontSize: fontSize(15),
                    color: textColor != null ? textColor : Colors.black),
                textAlign: TextAlign.center),
            padding: EdgeInsets.all(wValue(15)),
          ),
          onPressed: () {
            onClick!();
          },
      onLongPress: (){
            if(onLongTap != null){
              onLongTap();
            }
      },),
      margin: EdgeInsets.all(wValue(3)),
    ),
    flex: 1,
  );
}

itemShootRecordRow({int i = 0, required List<dynamic> selectedScore, int? selectedRow, Function? onTap}){
  Color? bgColor;
  Color? borderColor;
  Color? textColor;

    if((selectedScore[i].toString().toUpperCase() == "X" || selectedScore[i].toString() == "10" || selectedScore[i].toString() == "9")){
      bgColor = yellow;
      borderColor = yellow;
      textColor = Colors.black;
    }else if(selectedScore[i].toString() == "8" || selectedScore[i].toString() == "7"){
      bgColor = red;
      borderColor = red;
      textColor = Colors.white;
    }else if(selectedScore[i].toString() == "6" || selectedScore[i].toString() == "5"){
      bgColor = card;
      borderColor = card;
      textColor = Colors.white;
    }else if(selectedScore[i].toString() == "4" || selectedScore[i].toString() == "3"){
      bgColor = Colors.black;
      borderColor = Colors.black;
      textColor = Colors.white;
    }else if(selectedScore[i].toString() == "2" || selectedScore[i].toString() == "1"){
      bgColor = Colors.white;
      borderColor = inactive;
      textColor = Colors.black;
    }else if(selectedScore[i].toString().toUpperCase() == "M"){
      bgColor = inactive;
      borderColor = inactive;
      textColor = Colors.black;
    }else{
      bgColor = Colors.white;
      borderColor = colorAccent;
      textColor = Colors.black;
    }

  return InkWell(
    child: Container(
      margin: EdgeInsets.only(top: hValue(2), bottom: hValue(2)),
      width: wValue(55),
      height: hValue(55),
      child: Center(
        child: Text("${selectedScore[i]}", style: boldTextFont.copyWith(fontSize: fontSize(14), color: textColor),),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: i == selectedRow! ? Colors.black : Colors.white,
            offset: Offset(0.0, 0.5),
            blurRadius: 3.0,
          ),
        ],
      ),
    ),
    onTap: (){
      onTap!();
    },
  );
}

itemShootOffRecordRow({int i = 0, bool? isActive, String? distance, required List<ExtraShotModel> selectedScore, int? selectedRow, Function? onTap, Function? onEdit}){
  Color? bgColor;
  Color? borderColor;
  Color? textColor;

  if((selectedScore[i].score.toString().toUpperCase() == "X" || selectedScore[i].score.toString() == "10" || selectedScore[i].score.toString() == "9")){
    bgColor = yellow;
    borderColor = yellow;
    textColor = Colors.black;
  }else if(selectedScore[i].score.toString() == "8" || selectedScore[i].score.toString() == "7"){
    bgColor = red;
    borderColor = red;
    textColor = Colors.white;
  }else if(selectedScore[i].score.toString() == "6" || selectedScore[i].score.toString() == "5"){
    bgColor = card;
    borderColor = card;
    textColor = Colors.white;
  }else if(selectedScore[i].score.toString() == "4" || selectedScore[i].score.toString() == "3"){
    bgColor = Colors.black;
    borderColor = Colors.black;
    textColor = Colors.white;
  }else if(selectedScore[i].score.toString() == "2" || selectedScore[i].score.toString() == "1"){
    bgColor = Colors.white;
    borderColor = inactive;
    textColor = Colors.black;
  }else if(selectedScore[i].score.toString().toUpperCase() == "M"){
    bgColor = inactive;
    borderColor = inactive;
    textColor = Colors.black;
  }else{
    bgColor = Colors.white;
    borderColor = colorAccent;
    textColor = Colors.black;
  }

  if(isActive == null || !isActive){
    bgColor = Color(0xFFEFEFEF);
    borderColor = Color(0xFFAFAFAF);
    textColor = Colors.black;
  }

  return Column(
    children: [
      InkWell(
        child: Container(
          width: wValue(55),
          height: hValue(55),
          child: Center(
            child: Text(isActive! ? "${selectedScore[i].score}" : "", style: boldTextFont.copyWith(fontSize: fontSize(14), color: textColor),),
          ),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: i == selectedRow! ? Colors.grey : Colors.white,
                offset: Offset(0.0, 0.5),
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
        onTap: (){
          onTap!();
        },
      ),
      hSpace(5),
      InkWell(
        child: Text((isActive) ? distance != null && distance != "" ? "$distance mm" : "-" : "-", style: regularTextFont.copyWith(fontSize: fontSize(10)), textAlign: TextAlign.center,),
        onTap: (){
          if(isActive && (distance != null && distance != "")){
            onEdit!();
          }
        },
      )
    ],
  );
}

itemShootElimination({DataEliminationParticipantModel? member1, DataEliminationParticipantModel? member2, int? number, bool? isActive, Function? onClick}){
  var iter = number! + 1;
  var winner = 0;
  if(member1!.scores!.eliminationtScoreType == 1){
    if(member1.scores!.shot![number].status == "win"){
      winner = 1;
    }else if(member2!.scores!.shot![number].status == "win"){
      winner = 2;
    }
  }else{
    if(member1.scores!.shot![number].total! > member2!.scores!.shot![number].total!){
      winner = 1;
    }else if(member1.scores!.shot![number].total! < member2.scores!.shot![number].total!){
      winner = 2;
    }
  }
  return InkWell(
    child: Container(
      margin: EdgeInsets.only(bottom: hValue(10)),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isActive! ? Colors.white : Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: grey2),
            ),
            padding: EdgeInsets.symmetric(horizontal: wValue(15)),
            height: hValue(125),
            child: Center(
              child: Text("$iter", style: boldTextFont.copyWith(fontSize: fontSize(14)),),
            ),
          ),
          wSpace(2),
          Expanded(child: Container(
            padding: EdgeInsets.symmetric(horizontal: wValue(15)),
            height: hValue(125),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex : 1, child: Center(
                  child: Text(member1.participant != null ? "${member1.participant!.member!.name}" : "${member1.teamDetail!.teamName}",
                    style: regularTextFont.copyWith(fontSize: fontSize(14), color: isActive ? Colors.black : Color(0xFFAFAFAF)), maxLines: 2, overflow: TextOverflow.ellipsis,),
                )),
                hSpace(7),
                Expanded(child: Center(
                  child: Text(member2!.participant != null ? "${member2.participant!.member!.name}" : "${member2.teamDetail!.teamName}",
                    style: regularTextFont.copyWith(fontSize: fontSize(14), color: isActive ? Colors.black : Color(0xFFAFAFAF)), maxLines: 2,overflow: TextOverflow.ellipsis,),
                ), flex: 1,),
              ],
            ),
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: grey2),
            ),
          ), flex: 2,),
          wSpace(2),
          Expanded(child: Container(
            child: Column(
              children: [
                Expanded(child: Container(
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: grey2),
                  ),
                  padding: EdgeInsets.only(left: wValue(10), right: wValue(5), top: hValue(5), bottom: hValue(5)),
                  child: Center(
                    child: GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      childAspectRatio: 1.5,
                      mainAxisSpacing: 15,
                      children: <Widget>[
                        for (var item in member1.scores!.shot![number].score!) itemCircleShootRow("$item", isActive)
                      ],
                    ),
                  ),
                ), flex: 1,),
                hSpace(2),
                Expanded(child: Container(
                    decoration: BoxDecoration(
                      color: isActive ? Colors.white : Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: grey2),
                    ),
                    padding: EdgeInsets.only(left: wValue(10), right: wValue(5), top: hValue(5), bottom: hValue(5)),
                    child: Center(
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 15,
                        children: <Widget>[
                          for (var item in member2.scores!.shot![number].score!) itemCircleShootRow("$item", isActive)
                        ],
                      ),
                    )),
                  flex: 1,
                ),
              ],
            ),
            height: hValue(125),
          ), flex: 2,),
          // Expanded(child: , flex: 1,),
          Flexible(child: Container(
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(5.0),
            ),
            height: hValue(125),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: Row(
                  children: [
                    Expanded(child: Text("${member1.scores!.shot![number].total}", textAlign: TextAlign.center, style: boldTextFont.copyWith(fontSize: fontSize(14), color: isActive ? Colors.black : Color(0xFFAFAFAF)),), flex: 1,),
                    if(winner == 1) Container(
                      width: wValue(4),
                      height: hValue(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                        color: Color(0xFFFFC043),
                      ),
                    )
                  ],
                ), flex: 1,),
                hSpace(7),
                Expanded(child: Row(
                  children: [
                    Expanded(child: Text("${member2.scores!.shot![number].total}", textAlign: TextAlign.center, style: boldTextFont.copyWith(fontSize: fontSize(14),color: isActive ? Colors.black : Color(0xFFAFAFAF)),),
                      flex: 1,),
                    if(winner == 2) Container(
                      width: wValue(4),
                      height: hValue(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                        color: Color(0xFFFFC043),
                      ),
                    )
                  ],
                ), flex: 1,),
              ],
            ),
          )),
        ],
      ),
    ),
    onTap: (){
      onClick!();
    },
  );
}

itemShootOffElimination({int? index, DataEliminationParticipantModel? member1, DataEliminationParticipantModel? member2, bool? isActive, Function? onClick}){
  var iter = index! + 1;
  int totalExtraShotMember1=0;
  int totalExtraShotMember2=0;

  for(var item in member1!.scores!.extraShot!){
    if(item.score != ""){
      try{
        var scoreInt = int.parse(item.score);
        totalExtraShotMember1 += scoreInt;
      }catch(_){

      }
    }
  }

  for(var item in member2!.scores!.extraShot!){
    if(item.score != ""){
      try{
        var scoreInt = int.parse(item.score);
        totalExtraShotMember2 += scoreInt;
      }catch(_){

      }
    }
  }

  if(isActive!) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(bottom: hValue(10)),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: grey2),
              ),
              padding: EdgeInsets.symmetric(horizontal: wValue(15)),
              height: hValue(125),
              child: Center(
                child: Text("SO",
                  style: boldTextFont.copyWith(fontSize: fontSize(14)),),
              ),
            ),
            wSpace(2),
            Expanded(child: Container(
              padding: EdgeInsets.symmetric(horizontal: wValue(15)),
              height: hValue(125),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 1, child: Center(
                    child: Text(member1.participant != null ? "${member1.participant!.member!.name}" : "${member1.teamDetail!.teamName}",
                      style: regularTextFont.copyWith(fontSize: fontSize(14),
                          color: isActive ? Colors.black : Color(0xFFAFAFAF)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,),
                  )),
                  hSpace(7),
                  Expanded(child: Center(
                    child: Text(member2.participant != null ? "${member2.participant!.member!.name}" : "${member2.teamDetail!.teamName}",
                      style: regularTextFont.copyWith(fontSize: fontSize(14),
                          color: isActive ? Colors.black : Color(0xFFAFAFAF)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,),
                  ), flex: 1,),
                ],
              ),
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: grey2),
              ),
            ), flex: 2,),
            wSpace(2),
            Expanded(child: Container(
              child: Column(
                children: [
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                      color: isActive ? Colors.white : Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: grey2),
                    ),
                    padding: EdgeInsets.only(left: wValue(10),
                        right: wValue(5),
                        top: hValue(5),
                        bottom: hValue(5)),
                    child: Center(
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 15,
                        children: <Widget>[
                          for (int i =0; i < 3; i++) itemCircleShootRow("${member1.scores!.extraShot![i].score}", isActive)
                        ],
                      ),
                    ),
                  ), flex: 1,),
                  hSpace(2),
                  Expanded(child: Container(
                      decoration: BoxDecoration(
                        color: isActive ? Colors.white : Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: grey2),
                      ),
                      padding: EdgeInsets.only(left: wValue(10), right: wValue(
                          5), top: hValue(5), bottom: hValue(5)),
                      child: Center(
                        child: GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          childAspectRatio: 1.5,
                          mainAxisSpacing: 15,
                          children: <Widget>[
                            for (int i =0; i < 3; i++) itemCircleShootRow("${member2.scores!.extraShot![i].score}", isActive)
                          ],
                        ),
                      )),
                    flex: 1,
                  ),
                ],
              ),
              height: hValue(125),
            ), flex: 2,),
            // Expanded(child: , flex: 1,),
            Flexible(child: Container(
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(5.0),
              ),
              height: hValue(125),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Row(
                    children: [
                      Expanded(child: Text(
                        "-",
                        textAlign: TextAlign.center,
                        style: boldTextFont.copyWith(fontSize: fontSize(14),
                            color: isActive ? Colors.black : Color(
                                0xFFAFAFAF)),), flex: 1,),
                    ],
                  ), flex: 1,),
                  hSpace(7),
                  Expanded(child: Row(
                    children: [
                      Expanded(child: Text(
                        "-",
                        textAlign: TextAlign.center,
                        style: boldTextFont.copyWith(fontSize: fontSize(14),
                            color: isActive ? Colors.black : Color(
                                0xFFAFAFAF)),),
                        flex: 1,),
                    ],
                  ), flex: 1,),
                ],
              ),
            )),
          ],
        ),
      ),
      onTap: () {
        onClick!();
      },
    );
  }else {
    return SizedBox();
  }
}

//OLD itemShootOffElimination({int? index, DataEliminationParticipantModel? member1, DataEliminationParticipantModel? member2, bool? isActive, Function? onClick}){
//   var iter = index! + 1;
//   if(isActive!) {
//     return InkWell(
//       child: Card(
//         color: isActive ? Colors.white : Color(0xFFEFEFEF),
//         elevation: 0,
//         child: Container(
//           child: Row(
//             children: [
//               Text("S$iter",
//                 style: boldTextFont.copyWith(fontSize: fontSize(14)),),
//               wSpace(20),
//               Expanded(child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text( member1!.participant != null ? "${member1.participant!.member!.name}" : "${member1.teamDetail!.teamName}",
//                     // "${member1!.participant!.member!.name}",
//                     style: regularTextFont.copyWith(fontSize: fontSize(14),
//                         color: isActive ? Colors.black : Color(0xFFAFAFAF)),),
//                   hSpace(7),
//                   Text( member2!.participant != null ? "${member2.participant!.member!.name}" : "${member2.teamDetail!.teamName}",
//                     style: regularTextFont.copyWith(fontSize: fontSize(14),
//                         color: isActive ? Colors.black : Color(0xFFAFAFAF)),),
//                 ],
//               ), flex: 2,),
//               wSpace(10),
//               Expanded(child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       for (int i = 0; i < 3; i++) itemCircleShootRow(i == 0 ? "${member1.scores!.extraShot![index].score!}" : "", isActive)
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       for (int i = 0; i < 3; i++) itemCircleShootRow(i == 0 ? "${member2.scores!.extraShot![index].score!}" : "", isActive)
//                     ],
//                   )
//                 ],
//               ), flex: 2,),
//               Expanded(child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(child: Text("-", textAlign: TextAlign.center,
//                         style: boldTextFont.copyWith(fontSize: fontSize(14),
//                             color: isActive ? Colors.black : Color(
//                                 0xFFAFAFAF)),), flex: 1,),
//                       // if(member1.scores!.extraShot![1].status == "win") Container(
//                       //   width: wValue(4),
//                       //   height: hValue(20),
//                       //   decoration: BoxDecoration(
//                       //     borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
//                       //     color: Color(0xFFFFC043),
//                       //   ),
//                       // )
//                     ],
//                   ),
//                   hSpace(7),
//                   Row(
//                     children: [
//                       Expanded(child: Text("-", textAlign: TextAlign.center,
//                         style: boldTextFont.copyWith(fontSize: fontSize(14),
//                             color: isActive ? Colors.black : Color(
//                                 0xFFAFAFAF)),),
//                         flex: 1,),
//                       // if(member2.scores!.shot![number].status == "win") Container(
//                       //   width: wValue(4),
//                       //   height: hValue(20),
//                       //   decoration: BoxDecoration(
//                       //     borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
//                       //     color: Color(0xFFFFC043),
//                       //   ),
//                       // )
//                     ],
//                   ),
//                 ],
//               ), flex: 1,),
//             ],
//           ),
//           padding: EdgeInsets.only(
//               left: wValue(10), top: wValue(10), bottom: wValue(10)),
//         ),
//       ),
//       onTap: () {
//         onClick!();
//       },
//     );
//   }else{
//     return Container();
//   }
// }