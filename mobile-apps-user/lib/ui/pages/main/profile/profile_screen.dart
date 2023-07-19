import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/key_storage.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/pages/main/profile/profile_controller.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/dialog.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';

import '../../landing_profile/landing_profile_screen.dart';
import '../../my_club_screen/my_club_controller.dart';
import '../../my_club_screen/my_club_screen.dart';
import '../../profile/verify/verify_screen.dart';
import '../../transcation/list/list_transaction_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var controller = ProfileController();
  var myClubController= MyClubController();

  @override
  void initState() {
    controller.initController();
    myClubController.apiGetMyClub();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorPrimary,
        child: SafeArea(child: Scaffold(
          backgroundColor: bgPage,
          body: Obx(()=> Column(
            children: [
              Container(
                height: hValue(50),
                padding: EdgeInsets.all(wValue(15)),
                color: colorAccent,
                child: Stack(
                  children: [
                    Center(
                      child: Text("Profil", style: boldTextFont.copyWith(fontSize: fontSize(16), color: Colors.white),),
                    ),
                    Positioned(child: InkWell(
                      child: Icon(Icons.logout, size: wValue(20), color: Colors.white,),
                      onTap: (){
                        showConfirmDialog(context, content :  "Apakah anda ingin keluar ?", assets: "assets/icons/ic_alert.svg", btn2: "Batal", onClickBtn2: (){}, btn3: "Keluar", onClickBtn3: (){
                          controller.logoutAction();
                        });
                      },
                    ), right: 0,)
                  ],
                ),
              ),
              Expanded(child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerView(),
                    menuView()
                  ],
                ),
              ),flex: 1,)
            ],
          )),
        ))
    );
  }

  headerView(){
    return Container(
      color: colorAccent,
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
                      border: Border.all(width: 2, color: Colors.white),
                      shape: BoxShape.circle,
                    ),

                    child: circleAvatar(
                        "${controller.user.value.avatar}",
                        wValue(50),
                        hValue(50)),
                  ),
                ],
              ),
              wSpace(15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.loadingProfile.value ? loading() : Row(
                    children: [
                      Text("${controller.user.value.name}", style: boldTextFont.copyWith(fontSize: fontSize(16), color: Colors.white),),
                      wSpace(5),
                      if(controller.user.value.verifyStatus == KEY_VERIFY_ACC_VERIFIED) SvgPicture.asset("assets/icons/ic_label_verified.svg"),
                    ],
                  ),
                  hSpace(5),
                  myClubController.isLoadingClub.value ? loading() : Text(myClubController.myClubs.isNotEmpty ? "${myClubController.myClubs.first.name}" : "Belum ada Klub", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.white),),
                ],
              )
            ],
          ),
          hSpace(15),
          Row(
            children: [
              if(controller.user.value.verifyStatus != KEY_VERIFY_ACC_VERIFIED) Button("${controller.user.value.statusVerify}", controller.user.value.verifyStatus == KEY_VERIFY_ACC_REJECTED ? Colors.red : gray100, true, (){
                if(controller.user.value.verifyStatus == KEY_VERIFY_ACC_UNVERIFIED){
                  modalBottomVerifyAccount(skipable: true, onVerifyClicked: () async {
                    final result = await goToPageWithResult(VerifyScreen());
                    if(result != null) controller.apiProfile();
                  });
                }else if(controller.user.value.verifyStatus == KEY_VERIFY_ACC_SENT){
                  modalBottomVerifySent();
                }else{
                  modalBottomVerifyReject(onVerifyClicked: () async {
                    final result = await goToPageWithResult(LandingProfileScreen());
                    if(result != null) controller.apiProfile();
                  });
                }
                }, leftView: SvgPicture.asset(controller.user.value.verifyStatus == KEY_VERIFY_ACC_REJECTED ? "assets/icons/ic_info_red.svg" : "assets/icons/ic_info_white.svg"), fontColor: Colors.black, textSize: fontSize(10), height: hValue(36)),
              wSpace(10),
              Expanded(child: Button("Ubah Profil", colorAccent, true, () async {
                final result = await Navigator.push(
                  Get.context!,
                  MaterialPageRoute(builder: (context) => LandingProfileScreen()),
                );
                if (result != null) controller.getCurrentUser();
              }, borderColor: Colors.white, fontColor: Colors.white, textSize: fontSize(12), height: hValue(36)), flex: 1,)
            ],
          ),
        ],
      ),
    );
  }

  menuView(){
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          hSpace(15),
          itemMenu(image: "assets/icons/ic_latihan_circle.svg", text: "Latihan", onClick: (){

          }),
          Divider(),
          itemMenu(image: "assets/icons/ic_sertifikat_circle.svg", text: "Sertifikat", onClick: (){}),
          Divider(),
          itemMenu(image: "assets/icons/ic_club_circle.svg", text: "Klub Saya", onClick: (){
            goToPage(MyClubScreen());
          }),
          Divider(),
          itemMenu(image: "assets/icons/ic_transaction_circle.svg", text: "Transaksi", onClick: (){
            goToPage(ListTransactionScreen());
          }),
          hSpace(15),
        ],
      ),
    );
  }

  itemMenu({String? image, String? text, Function? onClick}){
    return InkWell(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset("$image", width: wValue(36),),
                wSpace(10),
                Expanded(child: Text("$text", style: regularTextFont.copyWith(fontSize: fontSize(12)),), flex: 1,),
                Icon(Icons.arrow_forward_ios)
              ],
            )
          ],
        ),
        margin: EdgeInsets.only(left: wValue(15), right: wValue(15), top: hValue(7), bottom: hValue(7)),
      ),
      onTap: (){
        onClick!();
      },
    );
  }
}
