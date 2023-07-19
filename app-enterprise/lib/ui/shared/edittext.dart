import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';

EditText(
    {TextEditingController? controller,
    bool? enable,
    bool? obsecureText,
    EdgeInsetsGeometry? contentPadding,
    TextAlign? textAlign,
    List<TextInputFormatter>? formatters,
    Color? borderColor,
    Color? bgColor,
    String? rightIcon,
    Function? onRightIconClicked,
    String? leftIcon,
    Function? onLeftIconClicked,
    FocusNode? focusNode,
    bool? readOnly,
    TextInputType? textInputType,
    TextInputAction? textInputAction,
    int? maxLines,
    double? radius,
    TextStyle? textStyle,
    TextStyle? hintStyle,
    Function? onSubmit,
    Function? onChange,
    Function? onClick,
    String? hintText,
    String? validatorText}) {
  return TextFormField(
    controller: controller,
    focusNode: focusNode,
    enabled: (enable != null) ? enable : true,
    readOnly: (readOnly != null) ? readOnly : false,
    enableInteractiveSelection: (readOnly != null) ? readOnly : false,
    onTap: () {
      if (onClick != null) onClick();
    },
    maxLines: maxLines ?? 1,
    inputFormatters: formatters ?? [],
    keyboardType: textInputType ?? TextInputType.text,
    textInputAction:
        (textInputAction == null) ? TextInputAction.done : textInputAction,
    obscureText: (obsecureText == null) ? false : obsecureText,
    onChanged: (value) {
      if (onChange != null) onChange(value);
    },
    onFieldSubmitted: (_) {
      if (onSubmit != null) onSubmit(_);
    },
    decoration: InputDecoration(
      hintStyle: hintStyle ??
          regularTextFont.copyWith(
              fontSize: fontSize(12), color: AppColor.gray400),
      focusedBorder: border(
          borderColor ??
              Color((readOnly != null && readOnly) ? 0xFFAFAFAF : 0xFF545454),
          radius: radius ?? 4.0),
      border: border(
          borderColor ??
              Color((readOnly != null && readOnly) ? 0xFFAFAFAF : 0xFF545454),
          radius: radius ?? 4.0),
      enabledBorder: border(
          borderColor ??
              Color((readOnly != null && readOnly) ? 0xFFAFAFAF : 0xFF545454),
          radius: radius ?? 4.0),
      disabledBorder: border(
          borderColor ??
              Color((readOnly != null && readOnly) ? 0xFFAFAFAF : 0xFF545454),
          radius: radius ?? 4.0),
      fillColor: bgColor ?? Colors.white,
      filled: bgColor != null,
      errorText:
          validatorText == "" || validatorText == null ? null : validatorText,
      contentPadding: contentPadding ??
          EdgeInsets.only(left: wValue(15), right: wValue(15)),
      hintText: hintText ?? "",
      prefixIcon: leftIcon != null
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.only(left: wValue(10)),
                  child: SvgPicture.asset(leftIcon),
                ),
                onTap: () {
                  if (onLeftIconClicked != null) {
                    onLeftIconClicked();
                  }
                },
              ), // myIcon is a 48px-wide widget.
            )
          : const Padding(padding: EdgeInsets.all(0)),
      prefixIconConstraints:
          BoxConstraints(minHeight: hValue(22), minWidth: wValue(22)),
      suffixIcon: rightIcon != null
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.only(right: wValue(10)),
                  child: SvgPicture.asset(rightIcon),
                ),
                onTap: () {
                  if (onRightIconClicked != null) {
                    onRightIconClicked();
                  }
                },
              ), // myIcon is a 48px-wide widget.
            )
          : const Padding(padding: EdgeInsets.all(0)),
      suffixIconConstraints:
          BoxConstraints(minHeight: hValue(22), minWidth: wValue(22)),
    ),
    // obscureText: controller.obsecurePasswordText.value,
    style: textStyle ??
        regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black),
    textAlign: textAlign ?? TextAlign.left,
  );
}

EditTextWoIcon(
    {TextEditingController? controller,
    bool? enable,
    bool? obsecureText,
    EdgeInsetsGeometry? contentPadding,
    TextAlign? textAlign,
    Color? borderColor,
    Color? bgColor,
    String? rightIcon,
    Function? onRightIconClicked,
    String? leftIcon,
    Function? onLeftIconClicked,
    TextInputType? textInputType,
    TextInputAction? textInputAction,
    Function? onSubmit,
    Function? onChange,
    FocusNode? focusNode,
    String? hintText,
    bool? needValidation,
    String? validatorText}) {
  if (needValidation == null && needValidation == false) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      enabled: (enable != null) ? enable : true,
      keyboardType: textInputType ?? TextInputType.text,
      textInputAction:
          (textInputAction == null) ? TextInputAction.done : textInputAction,
      obscureText: (obsecureText == null) ? false : obsecureText,
      onChanged: (value) {
        if (onChange != null) onChange(value);
      },
      onFieldSubmitted: (_) {
        if (onSubmit != null) onSubmit(_);
      },
      decoration: InputDecoration(
        focusedBorder: border(borderColor ?? const Color(0xFF545454)),
        border: border(borderColor ?? const Color(0xFF545454)),
        enabledBorder: border(borderColor ?? const Color(0xFF545454)),
        fillColor: bgColor ?? Colors.white,
        filled: bgColor != null,
        contentPadding: contentPadding ??
            EdgeInsets.only(left: wValue(15), right: wValue(15)),
        hintText: hintText ?? "",
        hintStyle: regularTextFont.copyWith(fontSize: fontSize(12)),
      ),
      // obscureText: controller.obsecurePasswordText.value,
      style:
          regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black),
      textAlign: textAlign ?? TextAlign.left,
    );
  }
  return TextFormField(
    controller: controller,
    focusNode: focusNode,
    enabled: (enable != null) ? enable : true,
    keyboardType: textInputType ?? TextInputType.text,
    textInputAction:
        (textInputAction == null) ? TextInputAction.done : textInputAction,
    obscureText: (obsecureText == null) ? false : obsecureText,
    onChanged: (value) {
      if (onChange != null) onChange(value);
    },
    onFieldSubmitted: (_) {
      if (onSubmit != null) onSubmit(_);
    },
    decoration: InputDecoration(
      focusedBorder: border(borderColor ?? const Color(0xFF545454)),
      border: border(borderColor ?? const Color(0xFF545454)),
      enabledBorder: border(borderColor ?? const Color(0xFF545454)),
      fillColor: bgColor ?? Colors.white,
      filled: bgColor != null,
      contentPadding: contentPadding ??
          EdgeInsets.only(left: wValue(15), right: wValue(15)),
      hintText: hintText ?? "",
    ),
    // obscureText: controller.obsecurePasswordText.value,
    style:
        regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black),
    textAlign: textAlign ?? TextAlign.left,
    validator: (value) =>
        value.toString().trim().isEmpty ? "$validatorText" : null,
  );
}
