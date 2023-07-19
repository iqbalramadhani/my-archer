import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/dialog.dart';
import 'package:myarchery_archer/ui/shared/edittext.dart';
import 'package:myarchery_archer/ui/shared/item_list.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/modal_bottom.dart';
import 'package:myarchery_archer/ui/shared/shimmer_loading.dart';

import '../feature_club/detail_club/detail_club_controller.dart';
import '../feature_club/detail_club/detail_club_screen.dart';
import '../my_club_screen/my_club_controller.dart';

class FindClubScreen extends StatefulWidget {
  const FindClubScreen({Key? key}) : super(key: key);

  @override
  _FindClubScreenState createState() => _FindClubScreenState();
}

class _FindClubScreenState extends State<FindClubScreen> {
  var controller = MyClubController();
  var detailController = DetailClubController();
  RxString name = "".obs;
  var _scrollController = new ScrollController();

  @override
  void initState() {
    controller.currentPageClub.value = 1;
    controller.clubs.clear();
    controller.validLoadMoreClubs.value = false;

    controller.apiGetClubs();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller.validLoadMoreClubs.value) {
          if (name.value != "")
            controller.apiGetClubs(name: name.value);
          else
            controller.apiGetClubs();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Container(
        color: colorPrimary,
        child: SafeArea(child: Scaffold(
            appBar: appBar("Gabung Klub", (){
              Get.back();
            }),
            body: Obx(()=> Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cari Klub", style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                  hSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: SvgPicture.asset("assets/icons/ic_filter.svg"),
                        onTap: (){
                          modalFilterKlub(selectedProv : controller.selectedProvince.value, selectedCity : controller.selectedCity.value, onItemSelected: (province, city){
                            controller.selectedProvince.value = province;
                            controller.selectedCity.value = city;
                            controller.refreshDataClub();
                          });
                        },
                      ),
                      wSpace(5),
                      Expanded(child: Container(
                        child: EditText(hintText: "Cari Klub", leftIcon: "assets/icons/ic_search.svg", borderColor: gray200, onSubmit: (value){
                          name.value = value;
                          controller.currentPageClub.value = 1;
                          controller.clubs.clear();
                          controller.validLoadMoreClubs.value = false;

                          if(name.value.toString().isNotEmpty) {
                            controller.apiGetClubs(name: name.value);
                          }
                          else {
                            controller.apiGetClubs();
                          }
                        }, radius: wValue(8)),
                        height: hValue(38),
                      ), flex: 1,),
                    ],
                  ),
                  hSpace(20),
                  Expanded(child: (controller.isLoadingClub.value && controller.currentPageClub.value == 1) ? showShimmerList() :
                  SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: [
                        for(var item in controller.clubs) itemClub(data: item, onClick: (itm){
                          goToPage(DetailClubScreen(idClub: itm.detail!.id!));
                        }, onJoinClick: (){
                          showDialogJoinClub(context, onJoinClick: (){
                            detailController.apiJoinClub(item.detail!.id.toString(), onFinish: (){
                              controller.currentPageClub.value = 1;
                              controller.clubs.clear();
                              controller.validLoadMoreClubs.value = false;

                              controller.apiGetClubs();
                            });
                          });
                        }),
                        if((controller.isLoadingClub.value && controller.currentPageClub.value > 1)) Container(
                          child: loading(),
                          margin: EdgeInsets.all(wValue(10)),
                        )
                      ],
                    ),), flex: 1,)
                ],
              ),
              padding: EdgeInsets.all(wValue(25)),
            ),
            ))),
      ),
    );
  }
}
