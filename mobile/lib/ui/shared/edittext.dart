import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_archery/utils/global_helper.dart';
import 'package:my_archery/utils/screen_util.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';

EditText({TextEditingController? controller, bool? enable, bool? obsecureText, EdgeInsetsGeometry? contentPadding, TextAlign? textAlign, List<TextInputFormatter>? formatters,
  Color? borderColor, Color? bgColor, String? rightIcon,  Function? onRightIconClicked, String? leftIcon,  Function? onLeftIconClicked,
  TextInputType? textInputType, TextInputAction? textInputAction, Function? onSubmit, Function? onChange, String? hintText, bool? needValidation, String? validatorText}){
  if(needValidation == null && needValidation == false){
    return TextFormField(
        controller: controller,
        enabled: (enable != null) ? enable : true,
        keyboardType: textInputType == null ? TextInputType.text : textInputType,
        textInputAction: (textInputAction == null) ? TextInputAction.done : textInputAction,
        obscureText: (obsecureText == null) ? false : obsecureText,
        inputFormatters: formatters != null ? formatters : [],
        onChanged: (value){
          if(onChange != null) onChange(value);
        },
        onFieldSubmitted: (_){
          if(onSubmit != null) onSubmit(_);
        },
        decoration: InputDecoration(
          focusedBorder : border(borderColor != null ? borderColor : Colors.grey),
          border: border(borderColor != null ? borderColor : Colors.grey),
          enabledBorder: border(borderColor != null ? borderColor : Colors.grey),
          fillColor: bgColor != null ? bgColor : Colors.white,
          filled: bgColor != null,
          contentPadding: contentPadding != null ? contentPadding : EdgeInsets.only(left: wValue(15), right: wValue(15)),
          hintText: hintText != null ? hintText : "",
          hintStyle: regularTextFont.copyWith(fontSize: ScreenUtil().setSp(12)),
          prefixIcon: leftIcon != null ? Padding(
            padding: const EdgeInsetsDirectional.only(end: 12.0),
            child: InkWell(
              child: Container(
                child: SvgPicture.asset(leftIcon),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
              ),
              onTap: (){
                if(onLeftIconClicked != null){
                  onLeftIconClicked();
                }
              },
            ), // myIcon is a 48px-wide widget.
          ) : Padding(padding: const EdgeInsets.all(0)),
          prefixIconConstraints: leftIcon == null ? BoxConstraints(
              minHeight: ScreenUtil().setHeight(0),
              minWidth: ScreenUtil().setWidth(0)
          ) : BoxConstraints(
              minHeight: ScreenUtil().setHeight(22),
              minWidth: ScreenUtil().setWidth(22)
          ),
          suffixIcon: rightIcon != null ? Padding(
            padding: const EdgeInsetsDirectional.only(end: 12.0),
            child: InkWell(
              child: Container(
                child: SvgPicture.asset(rightIcon),
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
              ),
              onTap: (){
                if(onRightIconClicked != null){
                  onRightIconClicked();
                }
              },
            ),
          ) : Padding(padding: const EdgeInsets.all(0)),
          suffixIconConstraints: rightIcon == null ? BoxConstraints(
              minHeight: ScreenUtil().setHeight(0),
              minWidth: ScreenUtil().setWidth(0)
          ) : BoxConstraints(
              minHeight: ScreenUtil().setHeight(22),
              minWidth: ScreenUtil().setWidth(22)
          ),
        ),
        // obscureText: controller.obsecurePasswordText.value,
        style: regularTextFont.copyWith(
            fontSize: ScreenUtil().setSp(12),
            color: Colors.black
        ),
      textAlign: textAlign != null ? textAlign : TextAlign.left,
    );
  }
  return TextFormField(
    controller: controller,
    enabled: (enable != null) ? enable : true,
    inputFormatters: formatters != null ? formatters : [],
    keyboardType: textInputType == null ? TextInputType.text : textInputType,
    textInputAction: (textInputAction == null) ? TextInputAction.done : textInputAction,
    obscureText: (obsecureText == null) ? false : obsecureText,
    onChanged: (value){
      if(onChange != null) onChange(value);
    },
    onFieldSubmitted: (_){
      if(onSubmit != null) onSubmit(_);
    },
    decoration: InputDecoration(
      focusedBorder : border(borderColor != null ? borderColor : Colors.grey),
      border: border(borderColor != null ? borderColor : Colors.grey),
      enabledBorder: border(borderColor != null ? borderColor : Colors.grey),
      fillColor: bgColor != null ? bgColor : Colors.white,
      filled: bgColor != null,
      contentPadding: contentPadding != null ? contentPadding : EdgeInsets.only(left: wValue(15), right: wValue(15)),
      hintText: hintText != null ? hintText : "",
      prefixIcon: leftIcon != null ? Padding(
        padding: const EdgeInsets.all(12),
        child: InkWell(
          child: Container(
            child: SvgPicture.asset(leftIcon),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
          ),
          onTap: (){
            if(onLeftIconClicked != null){
              onLeftIconClicked();
            }
          },
        ), // myIcon is a 48px-wide widget.
      ) : Padding(padding: const EdgeInsets.all(0)),
      prefixIconConstraints: BoxConstraints(
          minHeight: ScreenUtil().setHeight(22),
          minWidth: ScreenUtil().setWidth(22)
      ),
      suffixIcon: rightIcon != null ? Padding(
        padding: const EdgeInsets.all(12),
        child: InkWell(
          child: Container(
            child: SvgPicture.asset(rightIcon),
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
          ),
          onTap: (){
            if(onRightIconClicked != null){
              onRightIconClicked();
            }
          },
        ), // myIcon is a 48px-wide widget.
      ) : Padding(padding: const EdgeInsets.all(0)),
      suffixIconConstraints:  BoxConstraints(
          minHeight: ScreenUtil().setHeight(22),
          minWidth: ScreenUtil().setWidth(22)
      ),
    ),
    // obscureText: controller.obsecurePasswordText.value,
    style: regularTextFont.copyWith(
        fontSize: ScreenUtil().setSp(12),
        color: Colors.black
    ),
    textAlign: textAlign != null ? textAlign : TextAlign.left,
    validator: (value) => value.toString().trim().isEmpty ? "$validatorText" : null,
  );
}

EditTextWoIcon({TextEditingController? controller, bool? enable, bool? obsecureText, EdgeInsetsGeometry? contentPadding, TextAlign? textAlign,
  Color? borderColor, Color? bgColor, String? rightIcon,  Function? onRightIconClicked, String? leftIcon,  Function? onLeftIconClicked,
  TextInputType? textInputType, TextInputAction? textInputAction, Function? onSubmit, Function? onChange, String? hintText, bool? needValidation, String? validatorText}){
  if(needValidation == null && needValidation == false){
    return TextFormField(
      controller: controller,
      enabled: (enable != null) ? enable : true,
      keyboardType: textInputType == null ? TextInputType.text : textInputType,
      textInputAction: (textInputAction == null) ? TextInputAction.done : textInputAction,
      obscureText: (obsecureText == null) ? false : obsecureText,
      onChanged: (value){
        if(onChange != null) onChange(value);
      },
      onFieldSubmitted: (_){
        if(onSubmit != null) onSubmit(_);
      },
      decoration: InputDecoration(
        focusedBorder : border(borderColor != null ? borderColor : Colors.grey),
        border: border(borderColor != null ? borderColor : Colors.grey),
        enabledBorder: border(borderColor != null ? borderColor : Colors.grey),
        fillColor: bgColor != null ? bgColor : Colors.white,
        filled: bgColor != null,
        contentPadding: contentPadding != null ? contentPadding : EdgeInsets.only(left: wValue(15), right: wValue(15)),
        hintText: hintText != null ? hintText : "",
        hintStyle: regularTextFont.copyWith(fontSize: ScreenUtil().setSp(12)),
      ),
      // obscureText: controller.obsecurePasswordText.value,
      style: regularTextFont.copyWith(
          fontSize: ScreenUtil().setSp(12),
          color: Colors.black
      ),
      textAlign: textAlign != null ? textAlign : TextAlign.left,
    );
  }
  return TextFormField(
    controller: controller,
    enabled: (enable != null) ? enable : true,
    keyboardType: textInputType == null ? TextInputType.text : textInputType,
    textInputAction: (textInputAction == null) ? TextInputAction.done : textInputAction,
    obscureText: (obsecureText == null) ? false : obsecureText,
    onChanged: (value){
      if(onChange != null) onChange(value);
    },
    onFieldSubmitted: (_){
      if(onSubmit != null) onSubmit(_);
    },
    decoration: InputDecoration(
      focusedBorder : border(borderColor != null ? borderColor : Colors.grey),
      border: border(borderColor != null ? borderColor : Colors.grey),
      enabledBorder: border(borderColor != null ? borderColor : Colors.grey),
      fillColor: bgColor != null ? bgColor : Colors.white,
      filled: bgColor != null,
      contentPadding: contentPadding != null ? contentPadding : EdgeInsets.only(left: wValue(15), right: wValue(15)),
      hintText: hintText != null ? hintText : "",
    ),
    // obscureText: controller.obsecurePasswordText.value,
    style: regularTextFont.copyWith(
        fontSize: ScreenUtil().setSp(12),
        color: Colors.black
    ),
    textAlign: textAlign != null ? textAlign : TextAlign.left,
    validator: (value) => value.toString().trim().isEmpty ? "$validatorText" : null,
  );
}