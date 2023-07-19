import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/dialog.dart';
import 'package:myarchery_archer/ui/shared/edittext.dart';
import 'package:myarchery_archer/ui/shared/item_list.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/shimmer_loading.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';

import '../create_club/create_club_screen.dart';
import 'detail_club_controller.dart';

class DetailClubScreen extends StatefulWidget {
  final int idClub;
  const DetailClubScreen({Key? key, required this.idClub}) : super(key: key);

  @override
  _DetailClubScreenState createState() => _DetailClubScreenState();
}

class _DetailClubScreenState extends State<DetailClubScreen> {
  var controller = DetailClubController();
  var _scrollController = ScrollController();

  @override
  void initState() {
    controller.idClub.value = widget.idClub;
    controller.initController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if(controller.validLoadMore.value){
          if(controller.name.value != "")
            controller.apiGetMember();
          else controller.apiGetMember();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: BaseContainer(
          child: SafeArea(child: Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar("Profil Klub", (){
              Get.back();
            }),
            body: Obx(()=> Container(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                controller: _scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.isLoadingClub.value ? showShimmerProfileClub() : viewProfileSection(),
                    viewMemberSection()
                  ],
                ),
              ),
              width: Get.width,
              height: Get.height,
            )),
          )),
      ),
    );
  }


  viewProfileSection(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: hValue(190),
          child: Stack(
            children: [
              imageRadius("${controller.data.value.banner}", Get.width, hValue(133), 0),
              Positioned(child: Container(
                padding: EdgeInsets.only(left: wValue(22), right: wValue(22)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        shape: BoxShape.circle,
                        color: Color(0xFFE7EDF6),
                      ),
                      child: circleAvatar("${controller.data.value.logo}", wValue(101), hValue(101)),
                      width: wValue(101),
                      height: hValue(101),
                    ),
                    (controller.data.value.isJoin == 0) ? Container(
                      margin: EdgeInsets.only(top: hValue(30)),
                      child: Button("Gabung Klub", colorAccent, true, (){
                        controller.apiJoinClub(widget.idClub.toString(), onFinish: (){
                          controller.apiGetProfileClub();
                          controller.reloadMember();
                        });
                      }, textSize: fontSize(10), fontColor: Colors.white),
                      height: hValue(30),
                    ) : Container(
                      margin: EdgeInsets.only(top: hValue(30)),
                      child: Button("Keluar Klub", gray100, true, (){
                        showConfirmDialog(context, assets: "assets/icons/ic_alert.svg", showIcon: true, content: "Anda akan tetap terdaftar sebagai perwakilan klub dalam event yang sudah diikuti. Anda harus bergabung ulang untuk menjadi bagian dari klub.",
                        btn1: "Yakin",
                        onClickBtn1: (){
                          controller.apiLeftClub(widget.idClub.toString(), onFinish: (){
                            controller.apiGetProfileClub();
                            controller.reloadMember();
                          });
                        },
                        btn3: "Batalkan",
                        onClickBtn3: (){

                        });
                      }, textSize: fontSize(10), fontColor: Colors.red),
                      height: hValue(30),
                    ),
                    if(controller.data.value.isAdmin == 1) Container(
                      margin: EdgeInsets.only(top: hValue(30)),
                      child: Button("Ubah Profil", Colors.white, true, (){
                        goToPage(CreateClubScreen(currentData: controller.data.value,));
                      }, borderColor: colorAccent, textSize: fontSize(10), fontColor: colorAccent),
                      height: hValue(30),
                    )
                  ],
                ),
                width: Get.width,
              ), bottom: 0,)
            ],
          ),
        ),
        hSpace(10),
        Container(
          margin: EdgeInsets.only(left: wValue(25), right: wValue(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${controller.data.value.name}", style: boldTextFont.copyWith(fontSize: fontSize(20), color: colorPrimary),),
              hSpace(15),
              Container(
                // margin: EdgeInsets.only(right: wValue(50)),
                color: Color(0xFFF5F9FF),
                padding: EdgeInsets.all(wValue(10)),
                child: Row(
                  children: [
                    Expanded(child: Text("$urlShareClub/${controller.data.value.id}", style: regularTextFont.copyWith(fontSize: fontSize(12), color: gray600),), flex: 1,),
                    InkWell(
                      child: SvgPicture.asset("assets/icons/ic_link.svg"),
                      onTap: (){
                        Clipboard.setData(ClipboardData(text: "$urlShareClub/${controller.data.value.id}"));
                        successToast(msg: "Link berhasil di salin");
                      },
                    ),
                  ],
                ),
              ),
              hSpace(15),
              Text("${controller.data.value.description}", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
              hSpace(5),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/ic_location.svg" ,width: wValue(15),),
                  wSpace(5),
                  Text("${controller.data.value.address}", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Color(0xFF1C1C1C)),),
                ],
              ),
              hSpace(5),
              Row(
                children: [
                  Expanded(child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/ic_target.svg", width: wValue(15), color: colorAccent,),
                      wSpace(5),
                      Text("${controller.data.value.placeName}", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                    ],
                  ), flex: 1,),
                  wSpace(20),
                  Expanded(child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/ic_users.svg", width: wValue(15),),
                      wSpace(5),
                      Text("${controller.members.length} Anggota", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                    ],
                  ), flex: 1,),
                ],
              ),
              hSpace(13),
              Divider(
                color: gray200,
                thickness: wValue(1),
              ),
              hSpace(13),
            ],
          ),
        )
      ],
    );
  }

  viewMemberSection(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Daftar Anggota", style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
          hSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/ic_filter.svg"),
              wSpace(5),
              Expanded(child: Container(
                child: EditText(hintText: "Cari Anggota", leftIcon: "assets/icons/ic_search.svg", borderColor: gray200, onChange: (value){
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    controller.name.value = value;
                    controller.reloadMember();
                  });
                }, radius: wValue(8)),
                height: hValue(38),
              ), flex: 1,),
            ],
          ),
          hSpace(10),
          controller.isLoadingMember.value ? showShimmerList() : Column(
            children: [
              for(var item in controller.members) itemMemberClub(item),
              if((controller.isLoadingClub.value && controller.currentPage.value > 1)) Container(
                child: loading(),
                margin: EdgeInsets.all(wValue(10)),
              )
            ],
          )
        ],
      ),
      padding: EdgeInsets.only(left: wValue(25), right: wValue(25)),
    );
  }
}

