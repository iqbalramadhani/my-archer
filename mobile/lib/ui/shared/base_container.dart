import 'package:flutter/material.dart';
import 'package:my_archery/utils/global_helper.dart';

class BaseContainer extends StatelessWidget {
  final Widget child;
  const BaseContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        isTesting() ? bannerStaging() : Container()
      ],
    );
  }
}
