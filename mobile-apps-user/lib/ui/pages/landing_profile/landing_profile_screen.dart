import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';

import '../main/main_screen.dart';
import '../main/profile/profile_controller.dart';
import '../my_club_screen/my_club_controller.dart';
import '../profile/edit_profile/edit_profile_screen.dart';
import '../profile/verify/verify_screen.dart';

class LandingProfileScreen extends StatefulWidget {
  final from;
  const LandingProfileScreen({Key? key, this.from}) : super(key: key);

  @override
  _LandingProfileScreenState createState() => _LandingProfileScreenState();
}

class _LandingProfileScreenState extends State<LandingProfileScreen> {

  var controller = ProfileController();
  var myClubController = MyClubController();

  @override
  void initState() {
    controller.initController();
    myClubController.apiGetMyClub();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Container(
        color: colorPrimary,
        child: SafeArea(
          child: WillPopScope(
            child: Scaffold(
              appBar: appBar("Profil", (){
                onWillPop();
              }),
              body: Obx(()=> SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (controller.user.value.verifyStatus == KEY_VERIFY_ACC_VERIFIED) ? viewCardVerified() :  viewCardVerify(),
                      viewProfile(),
                      hSpace(25),
                      Text("Keamanan Akun", style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                      hSpace(15),
                      Text("Email", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black),),
                      hSpace(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${controller.user.value.email}", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black),),
                          InkWell(
                            child: Text("Ubah", style: regularTextFont.copyWith(fontSize: fontSize(12), color: colorPrimary),),
                            onTap: () async {

                            },
                          )
                        ],
                      ),
                      hSpace(20),
                      Text("Sandi", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black),),
                      hSpace(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("**********", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black),),
                          Text("Ubah", style: regularTextFont.copyWith(fontSize: fontSize(12), color: colorPrimary),)
                        ],
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(wValue(15)),
                ),
              )),
            ),
            onWillPop: onWillPop,
          ),
        ),
      ),
    );
  }

  viewCardVerify(){
    return Card(
      child: Container(
        padding: EdgeInsets.all(wValue(15)),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/icons/ic_alert.svg", width: wValue(17),),
                wSpace(10),
                Text("Verifikasi Data", style: boldTextFont.copyWith(fontSize: fontSize(16), color: Colors.black),),
              ],
            ),
            hSpace(15),
            Text("${controller.contentStatusVerify.value}", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black), ),
            hSpace(15),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: gray100,
              ),
              padding: EdgeInsets.all(wValue(7)),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/ic_info_white.svg"),
                  wSpace(10),
                  Text("${controller.user.value.statusVerify}", style: regularTextFont.copyWith(fontSize: fontSize(12), color: controller.user.value.verifyStatus == KEY_VERIFY_ACC_REJECTED ? Colors.red : Colors.black,),)
                ],
              ),
            ),
            hSpace(10),
            Button("${controller.btnStatusVerify.value}", colorPrimary, true, () async {
              if(controller.user.value.verifyStatus == KEY_VERIFY_ACC_REJECTED || controller.user.value.verifyStatus == KEY_VERIFY_ACC_UNVERIFIED){
                final result = await goToPageWithResult(VerifyScreen());
                if(result != null){
                  controller.apiProfile();
                }
              }else if(controller.user.value.verifyStatus == KEY_VERIFY_ACC_SENT){
                modalBottomReviewVerifyData(controller.user.value);
              }
            })
          ],
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    if(widget.from != null && widget.from == key_register_page){
      goToPage(MainScreen(), dismissAllPage: true);
    }else{
      Navigator.pop(Get.context!, true);
    }
    return true;
  }

  viewCardVerified(){
    return Card(
      child: Container(
        padding: EdgeInsets.all(wValue(15)),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/icons/ic_check_green.svg", width: wValue(17),),
                wSpace(10),
                Text("Verifikasi Data", style: boldTextFont.copyWith(fontSize: fontSize(16), color: Colors.black),),
              ],
            ),
            hSpace(15),
            Text("${controller.contentStatusVerify.value}", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black), ),
            hSpace(15),
            Container(
              width: Get.width,
              child: Align(child: InkWell(
                child: Text("Lihat Detail", style: boldTextFont.copyWith(fontSize: fontSize(13), color: colorPrimary),),
                onTap: (){
                  modalBottomReviewVerifyData(controller.user.value);
                },
              ),
              alignment: Alignment.centerRight,),
            ),
          ],
        ),
      ),
    );
  }

  viewProfile(){
    return Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(wValue(15)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: gray100),
                          shape: BoxShape.circle,
                        ),

                        child: circleAvatar(
                            "${controller.user.value.avatar}",
                            wValue(80),
                            hValue(80)),
                      ),
                    ],
                  ),
                  wSpace(10),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.loadingProfile.value ? loading() : Text("${controller.user.value.name}", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                      hSpace(5),
                      controller.loadingProfile.value ? loading() : (controller.user.value.phoneNumber == null) ? Container() : Text("${controller.user.value.phoneNumber}", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                      hSpace(5),
                      myClubController.isLoadingClub.value ? loading() : Text(myClubController.myClubs.isNotEmpty ? "${myClubController.myClubs.first.name}" : "Belum ada Klub", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black),),
                    ],
                  ), flex: 1,)
                ],
              ),
              Align(
                child: InkWell(
                  child: Text("Ubah", style: regularTextFont.copyWith(fontSize: fontSize(14), color: colorPrimary),),
                  onTap: () async {
                    final result = await Navigator.push(
                      Get.context!,
                      MaterialPageRoute(builder: (context) => EditProfileScreen()),
                    );
                    if (result != null) controller.apiProfile();
                  },
                ),
                alignment: Alignment.centerRight,
              )
            ],
          ),
        ),
      ),
      margin: EdgeInsets.only(top: hValue(15)),
    );
  }
}
