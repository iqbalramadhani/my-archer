import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:my_archery/gen/assets.gen.dart';
import 'package:my_archery/ui/pages/scan_qr/id_card/scan_qr_idcard_controller.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/screen_util.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/translator.dart';
import '../../../../utils/theme.dart';

class ScanQrIdCardScreen extends StatefulWidget {
  const ScanQrIdCardScreen({Key? key}) : super(key: key);

  @override
  State<ScanQrIdCardScreen> createState() => _ScanQrIdCardScreenState();
}

class _ScanQrIdCardScreenState extends State<ScanQrIdCardScreen> {
  MobileScannerController cameraController = MobileScannerController();
  Barcode? result;
  var scanQrController = ScanQrIdCardController();


  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorPrimary,
        child: BaseContainer(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: bgPage,
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      appBar(),
                      SizedBox(height: ScreenUtil().setHeight(25),),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                          child: Container(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  child: MobileScanner(
                                    allowDuplicates: false,
                                    controller: cameraController,
                                    onDetect: (barcode, args) {
                                      if (barcode.rawValue == null) {
                                        debugPrint('Failed to scan Barcode');
                                      } else {
                                        final String code = barcode.rawValue!;
                                        debugPrint('Barcode found! $code');

                                        scanQrController.apiScanQrIdCard(code);
                                      }
                                    },
                                  ),
                                ),
                                Align(child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Obx(()=> Container(
                                        width: wValue(35),
                                        height: hValue(35),
                                        child: SvgPicture.asset(scanQrController.isFlashOn.value ?Assets.icons.icFlashOn : Assets.icons.icFlashOff),
                                        margin: EdgeInsets.only(bottom: hValue(15)),
                                      )),
                                      onTap: () async {
                                        cameraController.toggleTorch();
                                        scanQrController.isFlashOn.toggle();
                                      },
                                    ),
                                    wSpace(15),
                                    InkWell(
                                      child: Container(
                                        width: wValue(35),
                                        height: hValue(35),
                                        child: SvgPicture.asset(Assets.icons.icSwitchCam),
                                        margin: EdgeInsets.only(bottom: hValue(15)),
                                      ),
                                      onTap: () async {
                                        await cameraController.switchCamera();
                                      },
                                    )
                                  ],), alignment: Alignment.bottomCenter,)
                              ],
                            ), height: ScreenUtil().setHeight(350),
                          ),
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.all(ScreenUtil().setWidth(15)),
                ),
              ),
            ),
          ),
        )
    );
  }

  appBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              child: Icon(Icons.arrow_back_outlined, color: colorAccent,),
              onTap: (){
                Get.back();
              },
            ),
            SizedBox(width: wValue(15),),
            Text(Translator.scanQr.tr, style: boldTextFont.copyWith(fontSize: fontSize(14), color: colorAccent),)
          ],
        ),
        // SvgPicture.asset("assets/icons/ic_question.svg")
      ],
    );
  }

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
