import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';

EditText({TextEditingController? controller, bool? enable, bool? obsecureText, EdgeInsetsGeometry? contentPadding, TextAlign? textAlign, List<TextInputFormatter>? formatters,
  Color? borderColor, Color? bgColor, String? rightIcon,  Function? onRightIconClicked, String? leftIcon,  Function? onLeftIconClicked, bool? readOnly,
  TextInputType? textInputType, TextInputAction? textInputAction, int? maxLines, double? radius, TextStyle? textStyle, TextStyle? hintStyle, Function? onSubmit, Function? onChange, Function? onClick, String? hintText, String? validatorText}){
  return TextFormField(
    controller: controller,
    enabled: (enable != null) ? enable : true,
    readOnly: (readOnly != null) ? readOnly : false,
    enableInteractiveSelection: (readOnly != null) ? readOnly : false,
    onTap: () {
      if(onClick != null) onClick();
    },
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
      hintStyle: hintStyle ?? regularTextFont.copyWith(fontSize: fontSize(12), color: gray400),
      focusedBorder : border(borderColor ?? Color((readOnly != null && readOnly) ? 0xFFAFAFAF : 0xFF545454), radius : radius ?? 4.0),
      border: border(borderColor ?? Color((readOnly != null && readOnly) ? 0xFFAFAFAF : 0xFF545454), radius: radius ?? 4.0),
      enabledBorder: border(borderColor ?? Color((readOnly != null && readOnly) ? 0xFFAFAFAF : 0xFF545454), radius: radius ?? 4.0),
      disabledBorder: border(borderColor ?? Color((readOnly != null && readOnly) ? 0xFFAFAFAF : 0xFF545454), radius: radius ?? 4.0),
      fillColor: bgColor != null ? bgColor : Colors.white,
      filled: bgColor != null,
      errorText: validatorText == "" || validatorText == null ? null : validatorText,
      contentPadding: contentPadding != null ? contentPadding : EdgeInsets.only(left: wValue(15), right: wValue(15)),
      hintText: hintText != null ? hintText : "",
      prefixIcon: leftIcon != null ? Padding(
        padding: const EdgeInsets.all(12),
        child: InkWell(
          child: Container(
            child: SvgPicture.asset(leftIcon),
            margin: EdgeInsets.only(left: wValue(10)),
          ),
          onTap: (){
            if(onLeftIconClicked != null){
              onLeftIconClicked();
            }
          },
        ), // myIcon is a 48px-wide widget.
      ) : Padding(padding: const EdgeInsets.all(0)),
      prefixIconConstraints: BoxConstraints(
          minHeight: hValue(22),
          minWidth: wValue(22)
      ),
      suffixIcon: rightIcon != null ? Padding(
        padding: const EdgeInsets.all(12),
        child: InkWell(
          child: Container(
            child: SvgPicture.asset(rightIcon),
            margin: EdgeInsets.only(right: wValue(10)),
          ),
          onTap: (){
            if(onRightIconClicked != null){
              onRightIconClicked();
            }
          },
        ), // myIcon is a 48px-wide widget.
      ) : Padding(padding: const EdgeInsets.all(0)),
      suffixIconConstraints:  BoxConstraints(
          minHeight: hValue(22),
          minWidth: wValue(22)
      ),
    ),
    // obscureText: controller.obsecurePasswordText.value,
    style: textStyle ?? regularTextFont.copyWith(
        fontSize: fontSize(12),
        color: Colors.black
    ),
    textAlign: textAlign != null ? textAlign : TextAlign.left,
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
        focusedBorder : border(borderColor != null ? borderColor : Color(0xFF545454)),
        border: border(borderColor != null ? borderColor : Color(0xFF545454)),
        enabledBorder: border(borderColor != null ? borderColor : Color(0xFF545454)),
        fillColor: bgColor != null ? bgColor : Colors.white,
        filled: bgColor != null,
        contentPadding: contentPadding != null ? contentPadding : EdgeInsets.only(left: wValue(15), right: wValue(15)),
        hintText: hintText != null ? hintText : "",
        hintStyle: regularTextFont.copyWith(fontSize: fontSize(12)),
      ),
      // obscureText: controller.obsecurePasswordText.value,
      style: regularTextFont.copyWith(
          fontSize: fontSize(12),
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
      focusedBorder : border(borderColor != null ? borderColor : Color(0xFF545454)),
      border: border(borderColor != null ? borderColor : Color(0xFF545454)),
      enabledBorder: border(borderColor != null ? borderColor : Color(0xFF545454)),
      fillColor: bgColor != null ? bgColor : Colors.white,
      filled: bgColor != null,
      contentPadding: contentPadding != null ? contentPadding : EdgeInsets.only(left: wValue(15), right: wValue(15)),
      hintText: hintText != null ? hintText : "",
    ),
    // obscureText: controller.obsecurePasswordText.value,
    style: regularTextFont.copyWith(
        fontSize: fontSize(12),
        color: Colors.black
    ),
    textAlign: textAlign != null ? textAlign : TextAlign.left,
    validator: (value) => value.toString().trim().isEmpty ? "$validatorText" : null,
  );
}