import 'package:flutter/cupertino.dart';
import 'package:my_archery/utils/screen_util.dart';

wSpace(value){
  return SizedBox(width: ScreenUtil().setWidth(value),);
}

hSpace(value){
  return SizedBox(height: ScreenUtil().setHeight(value),);
}

double fontSize(value){
  return ScreenUtil().setSp(value);
}

double hValue(value){
  return ScreenUtil().setHeight(value);
}

double wValue(value){
  return ScreenUtil().setWidth(value);
}