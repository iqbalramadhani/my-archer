import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';

keyboardShoot({Function? onXTap, Function? on10Tap, Function? on9Tap, Function? on8Tap, Function? on7Tap, Function? on6Tap, Function? on5Tap, Function? on4Tap, Function? on3Tap,
  Function? on2Tap, Function? on1Tap, Function? onMTap, Function? onDeleteTap, Function? onLongDeleteTap, Function? onEnter}){
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Container(
          child: Row(
            children: [
              itemKeyboard(text: "X", bgColor: yellow, onClick: (){
                onXTap!();
              }),
              itemKeyboard(text: "10", bgColor: yellow, onClick: (){
                on10Tap!();
              }),
              itemKeyboard(text: "9", bgColor: yellow, onClick: (){
                on9Tap!();
              }),
              itemKeyboard(text: "8", bgColor: red, textColor: Colors.white, onClick: (){
                on8Tap!();
              }),
            ],
          ),
          width: Get.width,
        ),
        Container(
          child: Row(
            children: [
              itemKeyboard(text: "7", bgColor: red, textColor: Colors.white, onClick: (){
                on7Tap!();
              }),
              itemKeyboard(text: "6", bgColor: card, textColor: Colors.white, onClick: (){
                on6Tap!();
              }),
              itemKeyboard(text: "5", bgColor: card, textColor: Colors.white, onClick: (){
                on5Tap!();
              }),
              itemKeyboard(text: "4", bgColor: Colors.black, textColor: Colors.white, onClick: (){
                on4Tap!();
              }),
            ],
          ),
          width: Get.width,
        ),
        Container(
          child: Row(
            children: [
              itemKeyboard(text: "3", bgColor: Colors.black, textColor: Colors.white, onClick: (){
                on3Tap!();
              }),
              itemKeyboard(text: "2", bgColor: Colors.white, textColor: Colors.black, onClick: (){
                on2Tap!();
              }),
              itemKeyboard(text: "1", bgColor: Colors.white, textColor: Colors.black, onClick: (){
                on1Tap!();
              }),
              itemKeyboard(text: "M", bgColor: greyM, textColor: Colors.black, onClick: (){
                onMTap!();
              }),
            ],
          ),
          width: Get.width,
        ),
        Container(
          child: Row(
            children: [
              Expanded(child: Container(
                padding: EdgeInsets.all(wValue(15)),
              ), flex: 1,),
              Expanded(
                child: Container(
                  child: MaterialButton(
                    color: Colors.white,
                    elevation: 2,
                    splashColor: Colors.white,
                    minWidth: Get.width,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Container(
                      child: SvgPicture.asset("assets/icons/ic_delete.svg"),
                      padding: EdgeInsets.all(wValue(15)),
                    ),
                    onPressed: () {
                      onDeleteTap!();
                    }, onLongPress: (){
                    onLongDeleteTap!();
                  },),
                  margin: EdgeInsets.all(wValue(2)),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  child: MaterialButton(
                      color: card,
                      elevation: 2,
                      splashColor: Colors.white,
                      minWidth: Get.width,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Container(
                        child: SvgPicture.asset("assets/icons/ic_enter.svg"),
                        padding: EdgeInsets.all(wValue(15)),
                      ),
                      onPressed: () {
                        onEnter!();
                      }),
                  margin: EdgeInsets.all(wValue(2)),
                ),
                flex: 1,
              ),
              Expanded(child: Container(
                padding: EdgeInsets.all(wValue(15)),
              ), flex: 1,),
            ],
          ),
          width: Get.width,
        ),
      ],
    ),
  );
}