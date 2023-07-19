import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/item_list.dart';
import 'package:myarchery_archer/ui/shared/shimmer_loading.dart';

import '../feature_club/create_club/create_club_screen.dart';
import '../find_club/find_club_screen.dart';
import 'my_club_controller.dart';

class MyClubScreen extends StatefulWidget {
  const MyClubScreen({Key? key}) : super(key: key);

  @override
  _MyClubScreenState createState() => _MyClubScreenState();
}

class _MyClubScreenState extends State<MyClubScreen> {

  var controller = MyClubController();
  var _scrollController = new ScrollController();


  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if(controller.validLoadMoreMyClubs.value){
          controller.apiGetMyClub();
        }
      }
    });

    controller.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorAccent,
      child: BaseContainer(
        child: SafeArea(
          child: Obx(()=>Scaffold(
            backgroundColor: gray50,
            floatingActionButton: (controller.myClubs.length > 0) ? fabClub() : Container(),
            appBar: appBar("Klub Saya", (){
              Get.back();
            }, bgColor: colorAccent, textColor: Colors.white, iconColor: Colors.white),
            body: RefreshIndicator(child: controller.isLoading.value ? showShimmerList() :  controller.myClubs.isEmpty ? viewNoClub() : SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Container(
                  child: Column(
                    children: [
                      for(var item in controller.myClubs) itemMyClub(item, onConfigClick: () async {
                        final result = await Navigator.push(
                          Get.context!,
                          MaterialPageRoute(builder: (context) => CreateClubScreen(currentData: item,)),
                        );
                        if (result != null) controller.refreshData();
                      })
                    ],
                  ),
                  padding: EdgeInsets.all(wValue(15)),
                )
            ), onRefresh: refreshData),
          )),
        ),
      ),
    );
  }

  Widget fabClub() {
    return SpeedDial(
      backgroundColor: colorPrimary,
      icon: Icons.close,
      child: SvgPicture.asset("assets/icons/ic_master_club.svg"),
      useRotationAnimation: true,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
            child: SvgPicture.asset("assets/icons/ic_gabung_club.svg"),
            backgroundColor: colorPrimary,
            onTap: () {
              // modalBottomSearchClub(onClickClub: (itm){
              //   goToPage(DetailClubScreen(idClub: itm.detail!.id!));
              // });
              goToPage(FindClubScreen());
            },
            label: 'Gabung Klub',
            labelStyle: boldTextFont.copyWith(fontSize: fontSize(12), color: Colors.white),
            labelBackgroundColor: colorPrimary),
        // FAB 2
        SpeedDialChild(
            child: SvgPicture.asset("assets/icons/ic_create_club.svg"),
            backgroundColor: colorPrimary,
            onTap: () {
              goToPage(CreateClubScreen());
            },
            label: 'Buat Klub',
            labelStyle: boldTextFont.copyWith(fontSize: fontSize(12), color: Colors.white),
            labelBackgroundColor: colorPrimary)
      ],
    );
  }

  Future refreshData() async {
    controller.refreshData();
  }

  viewNoClub(){
    return Container(
      margin: EdgeInsets.only(left: wValue(25), right: wValue(25), top: wValue(60)),
      padding: EdgeInsets.all(wValue(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/img/img_no_club.svg"),
          hSpace(20),
          Text("Anda belum memiliki klub. Silakan gabung atau buat klub.", style: regularTextFont.copyWith(fontSize: fontSize(14)),textAlign: TextAlign.center,),
          hSpace(20),
          Row(
            children: [
              Expanded(child: Button("Buat Klub", Color(0xFFE7EDF6), true, (){
                goToPage(CreateClubScreen());
              }, height: hValue(34), textSize: fontSize(12), fontColor: colorAccent), flex: 1,),
              wSpace(10),
              Expanded(child: Button("Gabung Klub", colorAccent, true, (){
                // modalBottomSearchClub(onClickClub: (itm){
                //   goToPage(DetailClubScreen(idClub: itm.detail!.id!));
                // });
                goToPage(FindClubScreen());
              }, height: hValue(34), textSize: fontSize(12), fontColor: Colors.white), flex: 1,),
            ],
          )
        ],
      ),
    );
  }
}

