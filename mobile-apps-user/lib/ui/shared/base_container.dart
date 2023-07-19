import 'package:flutter/material.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';

import 'label_banner.dart';

class BaseContainer extends StatelessWidget {
  final Widget child;
  const BaseContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        baseUrl.contains("staging") ? const LabelBanner() : Container()
      ],
    );
  }
}
