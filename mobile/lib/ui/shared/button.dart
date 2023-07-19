
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:my_archery/utils/screen_util.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';

class ButtonBorder extends StatelessWidget {
  final String title;
  final Color color;
  final bool enable;
  final Function onClick;
  final double? fontSize;
  final Color? fontColor;
  final double? height;

  const ButtonBorder({Key? key, required this.title, required this.color, required this.enable, required this.onClick, this.fontSize, this.fontColor, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: height != null ? height : hValue(40),
      child: OutlinedButton(
        onPressed: (){
          onClick();
        },
        style: ButtonStyle(
            side: MaterialStateProperty.all(
                BorderSide(
                    color: enable ? color : Color(0xFFAFAFAF),
                    width: 1.0,
                    style: BorderStyle.solid))),

        child: Text("$title", style: boldTextFont.copyWith(fontSize: fontSize != null ? fontSize : wValue(16), color: enable ? color != null ? color : colorAccent : Color(0xFFAFAFAF))),
      ),
    );
  }
}


class Button extends StatelessWidget {

  final String title;
  final Color color;
  final bool enable;
  final Function onClick;
  final double? fontSize;
  final double? radius;
  final Color? fontColor;
  final bool? isLoading;
  final Widget? leftView;
  final Widget? rightView;
  final double? height;

  const Button({Key? key, required this.title, required this.color, required this.enable, required this.onClick,
  this.fontSize, this.radius, this.fontColor, this.isLoading, this.leftView, this.rightView, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: enable ? color : Color(0xFFEFEFEF),
        elevation: 0,
        splashColor: enable ? Colors.white : color,
        height: (height != null) ? height : ScreenUtil().setHeight(40),
        minWidth: Get.width,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 4),
        ),
        child: isLoading != null ? Container(child: LoadingIndicator(indicatorType: Indicator.ballPulse, backgroundColor : Colors.white), width: ScreenUtil().setWidth(40),) : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (leftView != null) ? Container(child: leftView, margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),) : Container(),
            Text(
              title,
              style: boldTextFont.copyWith(fontSize: (fontSize != null) ? fontSize : ScreenUtil().setSp(15), color: enable ? fontColor != null ? fontColor : Colors.white : Color(0xFFAFAFAF)),
            ),
            (rightView != null) ? Container(child: rightView, margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),) : Container(),
          ],
        ),
        onPressed: () {
          if(enable){
            onClick();
          }
        });
  }
}
