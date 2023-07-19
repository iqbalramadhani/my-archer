
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:my_archery/ui/pages/scan_qr/scoring/scan_qr_controller.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/screen_util.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';
import 'package:my_archery/utils/translator.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  _ScanQrScreenState createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {

  MobileScannerController cameraController = MobileScannerController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var scanQrController = ScanQrController();

  @override
  void initState() {
    scanQrController.initController();
    super.initState();
  }

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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
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

                                          scanQrController.apiScanQr(code);
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
                                          child: SvgPicture.asset(scanQrController.isFlashOn.value ? "assets/icons/ic_flash_on.svg" : "assets/icons/ic_flash_off.svg"),
                                          margin: EdgeInsets.only(bottom: hValue(15)),
                                        )),
                                        onTap: () async {
                                          await cameraController.toggleTorch();
                                          scanQrController.isFlashOn.toggle();
                                        },
                                      ),
                                      wSpace(15),
                                      InkWell(
                                        child: Container(
                                          width: wValue(35),
                                          height: hValue(35),
                                          child: SvgPicture.asset("assets/icons/ic_switch_cam.svg"),
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
                            SizedBox(height: ScreenUtil().setHeight(25),),
                            Text(Translator.orInputArcher.tr, style: boldTextFont.copyWith(fontSize: ScreenUtil().setSp(12)),),
                            SizedBox(height: ScreenUtil().setHeight(10),),
                            EditText(
                                textInputType: TextInputType.text,
                                // textInputType: TextInputType.numberWithOptions(signed: true, decimal: false),
                                leftIcon: "assets/icons/ic_person.svg", textInputAction : TextInputAction.search, controller: scanQrController.idArcherControler.value,  obsecureText: false, hintText: "ex : 1-31",  onSubmit: (_){
                              scanQrController.apiScanQr(scanQrController.idArcherControler.value.text.toString());
                            }, formatters: [
                              // FilteringTextInputFormatter.allow(RegExp(r'[0,1,2,3,4,5,6,7,8,9,-,t]')),
                            ]),
                            SizedBox(height: ScreenUtil().setHeight(5),),
                            Align(
                              child: Container(
                                width: wValue(40),
                                child: InkWell(
                                  child: Card(
                                    color: colorAccent,
                                    child: Container(
                                      child: Icon(Icons.arrow_forward, color: Colors.white,),
                                      padding: EdgeInsets.all(wValue(5)),
                                    ),
                                  ),
                                  onTap: (){
                                    if(scanQrController.idArcherControler.value.text.toString().isNotEmpty)
                                      scanQrController.apiScanQr(scanQrController.idArcherControler.value.text.toString());
                                  },
                                ),
                              ),
                              alignment: Alignment.centerRight,
                            ),
                            SizedBox(height: ScreenUtil().setHeight(25),),
                          ],
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
            SizedBox(width: ScreenUtil().setWidth(15),),
            Text(Translator.scanQr.tr, style: boldTextFont.copyWith(fontSize: ScreenUtil().setSp(14), color: colorAccent),)
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
