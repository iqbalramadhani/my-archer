/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_add_photo.svg
  String get icAddPhoto => 'assets/icons/ic_add_photo.svg';

  /// File path: assets/icons/ic_add_square.svg
  String get icAddSquare => 'assets/icons/ic_add_square.svg';

  /// File path: assets/icons/ic_alert.svg
  String get icAlert => 'assets/icons/ic_alert.svg';

  /// File path: assets/icons/ic_arrow_down.svg
  String get icArrowDown => 'assets/icons/ic_arrow_down.svg';

  /// File path: assets/icons/ic_calendar.svg
  String get icCalendar => 'assets/icons/ic_calendar.svg';

  /// File path: assets/icons/ic_camera.svg
  String get icCamera => 'assets/icons/ic_camera.svg';

  /// File path: assets/icons/ic_checked.svg
  String get icChecked => 'assets/icons/ic_checked.svg';

  /// File path: assets/icons/ic_circle_marker.svg
  String get icCircleMarker => 'assets/icons/ic_circle_marker.svg';

  /// File path: assets/icons/ic_close.svg
  String get icClose => 'assets/icons/ic_close.svg';

  /// File path: assets/icons/ic_close_circle.svg
  String get icCloseCircle => 'assets/icons/ic_close_circle.svg';

  /// File path: assets/icons/ic_current_loc.svg
  String get icCurrentLoc => 'assets/icons/ic_current_loc.svg';

  /// File path: assets/icons/ic_gallery.svg
  String get icGallery => 'assets/icons/ic_gallery.svg';

  /// File path: assets/icons/ic_hide_pass.svg
  String get icHidePass => 'assets/icons/ic_hide_pass.svg';

  /// File path: assets/icons/ic_home.svg
  String get icHome => 'assets/icons/ic_home.svg';

  /// File path: assets/icons/ic_info.svg
  String get icInfo => 'assets/icons/ic_info.svg';

  /// File path: assets/icons/ic_marker_border.svg
  String get icMarkerBorder => 'assets/icons/ic_marker_border.svg';

  /// File path: assets/icons/ic_notification.svg
  String get icNotification => 'assets/icons/ic_notification.svg';

  /// File path: assets/icons/ic_order.svg
  String get icOrder => 'assets/icons/ic_order.svg';

  /// File path: assets/icons/ic_profile.svg
  String get icProfile => 'assets/icons/ic_profile.svg';

  /// File path: assets/icons/ic_pull_modal_bottom.svg
  String get icPullModalBottom => 'assets/icons/ic_pull_modal_bottom.svg';

  /// File path: assets/icons/ic_radio_selected.svg
  String get icRadioSelected => 'assets/icons/ic_radio_selected.svg';

  /// File path: assets/icons/ic_radio_unselected.svg
  String get icRadioUnselected => 'assets/icons/ic_radio_unselected.svg';

  /// File path: assets/icons/ic_search.svg
  String get icSearch => 'assets/icons/ic_search.svg';

  /// File path: assets/icons/ic_show_pass.svg
  String get icShowPass => 'assets/icons/ic_show_pass.svg';

  /// File path: assets/icons/ic_three_dots.svg
  String get icThreeDots => 'assets/icons/ic_three_dots.svg';

  /// File path: assets/icons/ic_uncheck.svg
  String get icUncheck => 'assets/icons/ic_uncheck.svg';

  /// File path: assets/icons/ic_vertical_dot.svg
  String get icVerticalDot => 'assets/icons/ic_vertical_dot.svg';
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ic_launcher.png
  AssetGenImage get icLauncher =>
      const AssetGenImage('assets/images/ic_launcher.png');

  /// File path: assets/images/img_archer.svg
  String get imgArcher => 'assets/images/img_archer.svg';

  /// File path: assets/images/img_check.svg
  String get imgCheck => 'assets/images/img_check.svg';

  /// File path: assets/images/img_placeholder.png
  AssetGenImage get imgPlaceholder =>
      const AssetGenImage('assets/images/img_placeholder.png');

  /// File path: assets/images/img_recheck.png
  AssetGenImage get imgRecheck =>
      const AssetGenImage('assets/images/img_recheck.png');

  /// File path: assets/images/img_success.svg
  String get imgSuccess => 'assets/images/img_success.svg';

  /// File path: assets/images/img_success_ajukan.png
  AssetGenImage get imgSuccessAjukan =>
      const AssetGenImage('assets/images/img_success_ajukan.png');

  /// File path: assets/images/img_unlock.png
  AssetGenImage get imgUnlock =>
      const AssetGenImage('assets/images/img_unlock.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
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
