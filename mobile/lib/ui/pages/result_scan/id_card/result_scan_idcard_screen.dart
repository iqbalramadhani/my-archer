import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_archery/ui/pages/main/main_screen.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:printing/printing.dart';

import '../../../../utils/theme.dart';
import '../../../shared/appbar.dart';
import '../../../shared/button.dart';

class ResultScanIdCardScreen extends StatefulWidget {
  final String? idCardUrl;
  const ResultScanIdCardScreen({Key? key, this.idCardUrl}) : super(key: key);

  @override
  State<ResultScanIdCardScreen> createState() => _ResultScanIdCardScreenState();
}

class _ResultScanIdCardScreenState extends State<ResultScanIdCardScreen> {
  late Uint8List pdfData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorPrimary,
        child: BaseContainer(
          child: SafeArea(
            child: Scaffold(
              appBar: appBar("ID Card", (){
                Get.back();
              }, textColor: Colors.white, bgColor: colorPrimary, iconColor: Colors.white),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: hValue(400),
                      margin: EdgeInsets.all(wValue(25)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FutureBuilder<Uint8List>(
                            future: _fetchPdfContent(widget.idCardUrl!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return PdfPreview(
                                  allowPrinting: true,
                                  allowSharing: true,
                                  canChangePageFormat: false,
                                  build: (format) => snapshot.data!,
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          )
                      ),
                    ),
                    Container(
                      child: Button(title: "Lanjut Scan QR", color : colorAccent, enable : true, onClick: (){
                        Get.back();
                      }, fontSize: fontSize(13)),
                      margin: EdgeInsets.only(left: wValue(15), right: wValue(15)),
                    ),
                    hSpace(10),
                    Container(
                      child: ButtonBorder(title: "Kembali Ke Beranda", color : colorAccent, enable : true, onClick: (){
                        Get.offAll(MainScreen());
                      }, fontSize: fontSize(13)),
                      margin: EdgeInsets.only(left: wValue(15), right: wValue(15)),
                    ),
                    hSpace(10),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  Future<Uint8List> _fetchPdfContent(final String url) async {
    final d.Response<List<int>> response = await d.Dio().get<List<int>>(
      url,
      options: d.Options(responseType: d.ResponseType.bytes),
    );
    pdfData = Uint8List.fromList(response.data!);
    return pdfData;
  }
}
