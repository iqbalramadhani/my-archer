/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************
import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_add_circle.svg
  String get icAddCircle => 'assets/icons/ic_add_circle.svg';

  /// File path: assets/icons/ic_add_person.svg
  String get icAddPerson => 'assets/icons/ic_add_person.svg';

  /// File path: assets/icons/ic_alert.svg
  String get icAlert => 'assets/icons/ic_alert.svg';

  /// File path: assets/icons/ic_arrow.svg
  String get icArrow => 'assets/icons/ic_arrow.svg';

  /// File path: assets/icons/ic_barebow.svg
  String get icBarebow => 'assets/icons/ic_barebow.svg';

  /// File path: assets/icons/ic_camera.svg
  String get icCamera => 'assets/icons/ic_camera.svg';

  /// File path: assets/icons/ic_category.svg
  String get icCategory => 'assets/icons/ic_category.svg';

  /// File path: assets/icons/ic_close_border_circle.svg
  String get icCloseBorderCircle => 'assets/icons/ic_close_border_circle.svg';

  /// File path: assets/icons/ic_delete.svg
  String get icDelete => 'assets/icons/ic_delete.svg';

  /// File path: assets/icons/ic_distance.svg
  String get icDistance => 'assets/icons/ic_distance.svg';

  /// File path: assets/icons/ic_edit.svg
  String get icEdit => 'assets/icons/ic_edit.svg';

  /// File path: assets/icons/ic_enter.svg
  String get icEnter => 'assets/icons/ic_enter.svg';

  /// File path: assets/icons/ic_flash.svg
  String get icFlash => 'assets/icons/ic_flash.svg';

  /// File path: assets/icons/ic_flash_off.svg
  String get icFlashOff => 'assets/icons/ic_flash_off.svg';

  /// File path: assets/icons/ic_flash_on.svg
  String get icFlashOn => 'assets/icons/ic_flash_on.svg';

  /// File path: assets/icons/ic_person.svg
  String get icPerson => 'assets/icons/ic_person.svg';

  /// File path: assets/icons/ic_question.svg
  String get icQuestion => 'assets/icons/ic_question.svg';

  /// File path: assets/icons/ic_reg_qr.svg
  String get icRegQr => 'assets/icons/ic_reg_qr.svg';

  /// File path: assets/icons/ic_scan.svg
  String get icScan => 'assets/icons/ic_scan.svg';

  /// File path: assets/icons/ic_switch_cam.svg
  String get icSwitchCam => 'assets/icons/ic_switch_cam.svg';

  /// File path: assets/icons/ic_trophy.svg
  String get icTrophy => 'assets/icons/ic_trophy.svg';

  /// File path: assets/icons/ic_trophy_active.svg
  String get icTrophyActive => 'assets/icons/ic_trophy_active.svg';
}

class $AssetsImgGen {
  const $AssetsImgGen();

  /// File path: assets/img/ic_launcher.png
  AssetGenImage get icLauncher =>
      const AssetGenImage('assets/img/ic_launcher.png');

  /// File path: assets/img/img_qr_code.png
  AssetGenImage get imgQrCode =>
      const AssetGenImage('assets/img/img_qr_code.png');

  /// File path: assets/img/img_scan_qr.svg
  String get imgScanQr => 'assets/img/img_scan_qr.svg';

  /// File path: assets/img/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/img/logo.png');
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImgGen img = $AssetsImgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
