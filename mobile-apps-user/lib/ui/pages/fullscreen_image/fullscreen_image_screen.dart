import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullscreenImageScreen extends StatefulWidget {
  final String image;
  const FullscreenImageScreen({Key? key, required this.image}) : super(key: key);

  @override
  _FullscreenImageScreenState createState() => _FullscreenImageScreenState();
}

class _FullscreenImageScreenState extends State<FullscreenImageScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          child: widget.image.toString().contains("http") ? PhotoView(
            imageProvider: NetworkImage("${widget.image}"),
          ) : widget.image.toString().contains("assets/") ?
          PhotoView(
            imageProvider: AssetImage("${widget.image}"),
          ) :
          PhotoView(
            imageProvider: FileImage(File("${widget.image}")),
          ),
        ),
      ),
    );
  }
}
