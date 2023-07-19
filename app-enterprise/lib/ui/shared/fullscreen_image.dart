import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:photo_view/photo_view.dart';

class FullscreenImage extends StatefulWidget {
  final String image;
  const FullscreenImage({Key? key, required this.image}) : super(key: key);

  @override
  _FullscreenImageState createState() => _FullscreenImageState();
}

class _FullscreenImageState extends State<FullscreenImage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                child: widget.image.toString().contains("http") ? PhotoView(
                  imageProvider: NetworkImage(widget.image),
                ) : widget.image.toString().contains("assets/") ?
                PhotoView(
                  imageProvider: AssetImage(widget.image),
                ) :
                PhotoView(
                  imageProvider: FileImage(File(widget.image)),
                ),
              ),
              Container(
                margin: EdgeInsets.all(wValue(15)),
                child: InkWell(
                  child: SvgPicture.asset(Assets.icons.icCloseCircle, width: wValue(25), height: hValue(25),),
                  onTap: (){
                    Get.back();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
