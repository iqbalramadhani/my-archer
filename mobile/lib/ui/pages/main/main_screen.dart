
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_archery/ui/pages/scan_qr/id_card/scan_qr_idcard_screen.dart';
import 'package:my_archery/ui/shared/widget.dart';
import 'package:my_archery/utils/global_helper.dart';
import 'package:my_archery/utils/screen_util.dart';
import 'package:my_archery/utils/spacing.dart';
import 'package:my_archery/utils/theme.dart';

import '../scan_qr/scoring/scan_qr_screen.dart';
import 'main_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {

  var controller = MainController();
  TabController? tabController;

  @override
  void initState() {
    controller.initController();
    tabController = TabController(vsync: this, length: 3);
    tabController?.addListener(() {
      if(tabController!.indexIsChanging){
        controller.selectedMenu.value = tabController!.index;
      }
    });
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
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/img/logo.png", width: ScreenUtil().setWidth(45),),
                      // baseUrl.contains("staging") ? Text("Staging", style: boldTextFont.copyWith(fontSize: fontSize(15)),) : Container(),
                      // InkWell(
                      //   child: Icon(Icons.logout),
                      //   onTap: (){
                      //     showConfirmDialog(context, content :  "Logout from this account ?", assets: "assets/icons/ic_alert.svg", btn2: "Cancel", onClickBtn2: (){}, btn3: "Logout", onClickBtn3: (){
                      //       controller.logoutAction();
                      //     });
                      //   },
                      // )
                    ],
                  ),
                  Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        child: Column(
                          children: [
                            hSpace(25),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/img/img_scan_qr.svg", width: wValue(200),),
                                  hSpace(10),
                                  Text("Scan QR", style: boldTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.center,),
                                  hSpace(15),
                                ],
                              ),
                            ),
                            _viewScanContainer(title: "Verifikasi Data", btnText: "ID Card", desc: "Scan QR pada ID card peserta untuk melakukan verifikasi", onClick: (){
                              goToPage(ScanQrIdCardScreen());
                            }),
                            hSpace(10),
                            _viewScanContainer(title: "Skoring", btnText: "Skoring", desc: "Scan QR pada lembar skor untuk melakukan skoring peserta", onClick: (){
                              controller.setValueKeyParticipant(false);
                              goToPage(ScanQrScreen());
                            }),
                          ],
                        ),
                      )
                  )
                ],
              ),
              padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
            ),
          ),
        ),
      ),
    );
  }

  _viewScanContainer({required String title, required String desc, required String btnText, required Function onClick}){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(wValue(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("$title".toUpperCase(),style: boldTextFont.copyWith(fontSize: fontSize(12)),),
            hSpace(10),
            Button(title : btnText, color : colorAccentDark,  enable : true,  onClick:(){
              onClick();
            }, leftView: SvgPicture.asset("assets/icons/ic_scan.svg"), fontSize: ScreenUtil().setSp(12), height: ScreenUtil().setHeight(40)),
            hSpace(10),
            Text("$desc",style: regularTextFont.copyWith(fontSize: fontSize(10)),),
          ],
        ),
      ),
    );
  }

  viewHistoryList(){
    return Expanded(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hSpace(30),
        TabBar(
          isScrollable: true,
          controller: tabController,
          labelColor: colorAccentDark,
          unselectedLabelColor: inactive,
          labelStyle: boldTextFont.copyWith(fontSize: fontSize(10)),
          indicatorColor: colorAccentDark,
          tabs: [
            Container(
              child: Tab(text: "Semua"),
            ),
            Container(
              child: Tab(text: "Berlangsung",),
            ),
            Container(
              child: Tab(text: "Selesai",),
            ),
          ],
        ),
        Expanded(child: SingleChildScrollView(
          child: Container(
            child: viewEmpty(),
            padding: EdgeInsets.only(bottom: hValue(15)),
          ),
        ), flex: 1,)
      ],
    ), flex: 1,);
  }
}
