import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/strings.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/core/controllers/province_controller.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/dialog.dart';
import 'package:myarchery_archer/ui/shared/edittext.dart';
import 'package:myarchery_archer/ui/shared/item_list.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/shimmer_loading.dart';

import '../../core/models/objects/category_register_event_model.dart';
import '../../core/models/objects/member_club_model.dart';
import '../../core/models/objects/profile_model.dart';
import '../../core/models/objects/region_model.dart';
import '../../core/models/response/get_verify_data_response.dart';
import '../pages/feature_club/detail_club/detail_club_controller.dart';
import '../pages/my_club_screen/my_club_controller.dart';
import '../pages/profile/verify/verify_controller.dart';
import '../pages/register_event/register_event_controller.dart';

modalBottomSearchClub({required Function onClickClub}) {
  var controller = MyClubController();
  var detailController = DetailClubController();

  controller.currentPageClub.value = 1;
  controller.clubs.clear();
  controller.validLoadMoreClubs.value = false;

  RxString name = "".obs;

  controller.apiGetClubs();
  var _scrollController = new ScrollController();
  _scrollController.addListener(() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if(controller.validLoadMoreClubs.value){
        if(name.value != "")
          controller.apiGetClubs(name: name.value);
        else controller.apiGetClubs();
      }
    }
  });

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return Obx(()=> Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cari Klub", style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Text("Batal", style: boldTextFont.copyWith(fontSize: fontSize(14), color: gray400),),
                  ),
                ],
              ),
              hSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/ic_filter.svg"),
                  wSpace(5),
                  Expanded(child: Container(
                    child: EditText(hintText: "Cari Klub", leftIcon: "assets/icons/ic_search.svg", borderColor: gray200, onChange: (value){
                      name.value = value;
                      Future.delayed(const Duration(milliseconds: 1500), () {
                        controller.currentPageClub.value = 1;
                        controller.clubs.clear();
                        controller.validLoadMoreClubs.value = false;

                        if(name.value.toString().isNotEmpty) {
                          controller.apiGetClubs(name: name.value);
                        }
                        else {
                          controller.apiGetClubs();
                        }

                      });
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
                      Get.back();
                      onClickClub(itm);
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
          margin: EdgeInsets.only(top: hValue(100)),
        ));
      });
}

modalBottomProvince({required Function onItemSelected}) {
  var controller = ProvinceController();

  controller.currentPageProvince.value = 1;
  controller.provinces.clear();
  controller.validLoadMoreProvince.value = false;

  controller.apiGetProvince();
  var _scrollController = new ScrollController();
  _scrollController.addListener(() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if(controller.validLoadMoreProvince.value){
        controller.apiGetProvince();
      }
    }
  });

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return Obx(()=> Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cari Provinsi", style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Text("Batal", style: boldTextFont.copyWith(fontSize: fontSize(14), color: gray400),),
                  ),
                ],
              ),
              hSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Container(
                    child: EditText(hintText: "Cari Provinsi", leftIcon: "assets/icons/ic_search.svg", borderColor: gray200, onChange: (value){
                      controller.filterProvinces.clear();
                      if(value.toString().isEmpty){
                        controller.filterProvinces.addAll(controller.provinces);
                      }else{
                        controller.filterProvinces.addAll(controller.provinces.where((p0) => p0.name!.toLowerCase().contains(value.toString().toLowerCase())));
                      }
                    }, radius: wValue(8)),
                    height: hValue(38),
                  ), flex: 1,),
                ],
              ),
              hSpace(20),
              Expanded(child: (controller.isLoadingProvince.value && controller.currentPageProvince.value == 1) ? showShimmerList() :
              SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    for(var item in controller.filterProvinces) itemRegion(item, (data){
                      Get.back();
                      onItemSelected(data);
                    }),
                    if((controller.isLoadingProvince.value && controller.currentPageProvince.value > 1)) Container(
                      child: loading(),
                      margin: EdgeInsets.all(wValue(10)),
                    )
                  ],
                ),), flex: 1,)
            ],
          ),
          padding: EdgeInsets.all(wValue(25)),
          margin: EdgeInsets.only(top: hValue(100)),
        ));
      });
}

modalBottomCity({required String idProvince, required Function onItemSelected}) {
  var controller = ProvinceController();

  controller.currentPageCity.value = 1;
  controller.cities.clear();
  controller.validLoadMoreCity.value = false;

  controller.apiGetCity(idProvince);

  var _scrollController = new ScrollController();
  _scrollController.addListener(() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if(controller.validLoadMoreCity.value){
        controller.apiGetCity(idProvince);
      }
    }
  });

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return Obx(()=> Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cari Kota", style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Text("Batal", style: boldTextFont.copyWith(fontSize: fontSize(14), color: gray400),),
                  ),
                ],
              ),
              hSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Container(
                    child: EditText(hintText: "Cari Kota", leftIcon: "assets/icons/ic_search.svg", borderColor: gray200, onChange: (value){
                      controller.filterCities.clear();
                      if(value.toString().isEmpty){
                        controller.filterCities.addAll(controller.cities);
                      }else{
                        controller.filterCities.addAll(controller.cities.where((p0) => p0.name!.toLowerCase().contains(value.toString().toLowerCase())));
                      }
                    }, radius: wValue(8)),
                    height: hValue(38),
                  ), flex: 1,),
                ],
              ),
              hSpace(20),
              Expanded(child: (controller.isLoadingCity.value && controller.currentPageCity.value == 1) ? showShimmerList() :
              SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    for(var item in controller.filterCities) itemRegion(item, (item){
                      Get.back();
                      onItemSelected(item);
                    }),
                    if((controller.isLoadingCity.value && controller.currentPageCity.value > 1)) Container(
                      child: loading(),
                      margin: EdgeInsets.all(wValue(10)),
                    )
                  ],
                ),), flex: 1,)
            ],
          ),
          padding: EdgeInsets.all(wValue(25)),
          margin: EdgeInsets.only(top: hValue(100)),
        ));
      });
}

modalBottomCategoryRegisterEvent({required List<CategoryRegisterEventModel> data, required CategoryRegisterEventModel selectedCategory, required Function onItemSelected}) {

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return Obx(()=> Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(10),
              Text("Kategori", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
              hSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Container(
                    child: EditText(hintText: "Cari Kategori", leftIcon: "assets/icons/ic_search.svg", borderColor: gray200, onChange: (value){

                    }, radius: wValue(8)),
                    height: hValue(38),
                  ), flex: 1,),
                ],
              ),
              hSpace(20),
              Expanded(child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    for(var item in data) itemCategoryRegisterEvent(item, item.id == selectedCategory.id,  (){
                      Get.back();
                      onItemSelected(item);
                    }),
                  ],
                ),), flex: 1,),
            ],
          ),
          padding: EdgeInsets.all(wValue(25)),
          margin: EdgeInsets.only(top: hValue(100)),
        ));
      });
}

modalBottomSearchMemberClub({required teamName, required int idClub, required String categoryId, required String clubId, required Function onClickItem}) {
  var controller = DetailClubController();
  var registerController = RegisterEventController();

  controller.idClub.value = idClub;
  controller.currentPage.value = 1;
  controller.members.clear();
  controller.validLoadMore.value = false;

  controller.apiGetMember();
  var _scrollController = new ScrollController();
  _scrollController.addListener(() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if(controller.validLoadMore.value){
        controller.apiGetMember();
      }
    }
  });

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return Obx(()=> Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cari Member", style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Text("Batal", style: boldTextFont.copyWith(fontSize: fontSize(14), color: gray400),),
                  ),
                ],
              ),
              hSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/ic_filter.svg"),
                  wSpace(5),
                  Expanded(child: Container(
                    child: EditText(hintText: "Cari Member", leftIcon: "assets/icons/ic_search.svg", borderColor: gray200, radius: wValue(8)),
                    height: hValue(38),
                  ), flex: 1,),
                ],
              ),
              hSpace(20),
              Expanded(child: (controller.isLoadingMember.value && controller.currentPage.value == 1) ? showShimmerList() :
              SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    for(var item in controller.members) itemMemberClub(item, onClick: (itm){
                      registerController.apiCheckEmailMember(teamName, item.email!, clubId, categoryId, onFinish: (){
                        try{
                          onClickItem(itm);
                        }catch(e){
                          printLog(msg: "error $e");
                        }
                        Get.back();
                      });
                    }),
                    if((controller.isLoadingMember.value && controller.currentPage.value > 1)) Container(
                      child: loading(),
                      margin: EdgeInsets.all(wValue(10)),
                    )
                  ],
                ),), flex: 1,)
            ],
          ),
          padding: EdgeInsets.all(wValue(25)),
          margin: EdgeInsets.only(top: hValue(100)),
        ));
      });
}

modalBottomSearchMemberRegisterEvent({required teamName, required String categoryId, required int clubId, required Function onClickItem}) {
  var controller = RegisterEventController();

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return Obx(()=> Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cari Member", style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Text("Batal", style: boldTextFont.copyWith(fontSize: fontSize(14), color: gray400),),
                  ),
                ],
              ),
              hSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/ic_filter.svg"),
                  wSpace(5),
                  Expanded(child: Container(
                    child: EditText(hintText: "Cari Member", leftIcon: "assets/icons/ic_search.svg", borderColor: gray200, radius: wValue(8), onSubmit: (v){
                      controller.apiCheckEmailMember(teamName, v, clubId.toString(), categoryId, onFinish: (){

                      });
                    }),
                    height: hValue(38),
                  ), flex: 1,),
                ],
              ),
              hSpace(20),
              Expanded(child: (controller.isLoading.value) ? showShimmerList() :
              (controller.members.length <= 0) ? viewEmpty() : SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    for(var item in controller.members) itemMemberClub(MemberClubModel(
                      id: item.userId,
                      name: item.name,
                      age: item.age,
                      gender: item.gender,
                      avatar: item.avatar,
                      email: item.email,
                    ), onClick: (itm){
                      Get.back();
                      onClickItem(itm);
                    }),
                  ],
                ),), flex: 1,)
            ],
          ),
          padding: EdgeInsets.all(wValue(25)),
          margin: EdgeInsets.only(top: hValue(100)),
        ));
      });
}

modalBottomPaymentNotComplete({ String? btnNo, String? btnYes, required Function onPaymentCLicked, required Function onCloseClicked}) {
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  hSpace(10),
                  Text("Pembayaran Belum Selesai", style: boldTextFont.copyWith(fontSize: fontSize(16), color: colorPrimary),),
                  hSpace(20),
                  Image.asset("assets/img/img_payment.png", width: wValue(194),),
                  hSpace(14),
                  Text("Pembayaran belum selesai. Yuk lanjutkan pembayaran untuk dapat mengikuti event.", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.center,),
                  hSpace(30),
                  Button(btnYes ?? "Lanjutkan Pembayaran", colorPrimary, true, (){
                    Get.back();
                    onPaymentCLicked();
                  }, textSize: fontSize(14)),
                  hSpace(10),
                  Button(btnNo ?? "Ubah Data", Colors.white, true, (){
                    Get.back();
                    onCloseClicked();
                  }, borderColor: colorPrimary, fontColor: colorPrimary, textSize: fontSize(14)),
                ],
              ),
              padding: EdgeInsets.all(wValue(25)),
              margin: EdgeInsets.only(top: hValue(100)),
            )
          ],
        );
      });
}

modalFilterKlub({required RegionModel selectedProv, required RegionModel selectedCity, required Function onItemSelected}) {
  var provinceController = ProvinceController();

  provinceController.selectedProvince.value = selectedProv;
  provinceController.selectedCity.value = selectedCity;

  RxString focusActive = "province".obs;
  RxBool showKota  = false.obs;

  var provinceCtrl = TextEditingController().obs;
  var kabCtrl = TextEditingController().obs;

  if(selectedProv.id != null){
    provinceCtrl.value.text = selectedProv.name!;
    focusActive.value = "none";
  }else{
    provinceController.apiGetProvince();
  }

  if(selectedCity.id != null){
    kabCtrl.value.text = selectedCity.name!;
    focusActive.value = "none";
    showKota.value = true;
  }

  clearProvinceAndCity(){
    focusActive.value = "province";
    provinceController.selectedProvince.value = RegionModel();
    provinceCtrl.value.text = "";

    provinceController.selectedCity.value = RegionModel();
    kabCtrl.value.text= "";
    showKota.value = false;

    provinceController.filterProvinces.clear();
    provinceController.filterProvinces.addAll(provinceController.provinces);

    provinceController.filterCities.clear();
    provinceController.cities.clear();
  }

  clearCity(){
    provinceController.selectedCity.value = RegionModel();
    kabCtrl.value.text= "";
    showKota.value = true;

    provinceController.filterCities.clear();
  }

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return Obx(()=> Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Pilih Filter", style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Text("Batal", style: boldTextFont.copyWith(fontSize: fontSize(14), color: gray400),),
                  ),
                ],
              ),


              hSpace(20),
              EditText(hintText: "Masukkan Provisi", controller: provinceCtrl.value,
                  leftIcon: "assets/icons/ic_location.svg", borderColor: gray200,
                  rightIcon: (provinceController.selectedProvince.value.id != null) ? "assets/icons/ic_close.svg" : null,
                  onRightIconClicked: (){
                    clearProvinceAndCity();
                  },
                  onChange: (v){
                    provinceController.filterProvinces.clear();
                    if(v.toString().isEmpty){
                      provinceController.filterProvinces.addAll(provinceController.provinces);
                    }else{
                      provinceController.filterProvinces.addAll(provinceController.provinces.where((p0) => p0.name!.toLowerCase().contains(v.toString().toLowerCase())));
                    }
                  },
                  onClick: (){
                    focusActive.value = "province";
                    if(provinceController.provinces.isEmpty) {
                      provinceController.apiGetProvince();
                    }
                  }, radius: wValue(8)),


              if(provinceController.selectedProvince.value.id != null && !showKota.value) Container(
                child: Button("Tambah Kota", Colors.white, true, (){
                  showKota.value = true;
                }, borderColor: gray200, fontColor: gray500, textSize: fontSize(14), height: hValue(30)),
                margin: EdgeInsets.only(top: hValue(10)),
              ),

              hSpace(10),
              if(showKota.value) EditText(hintText: "Masukkan Kota", controller: kabCtrl.value,
                  leftIcon: "assets/icons/ic_location.svg",
                  rightIcon: (provinceController.selectedCity.value.id != null) ? "assets/icons/ic_close.svg" : null,
                  onRightIconClicked: (){
                    clearCity();
                  },
                  borderColor: gray200,
                  onChange: (v){
                    provinceController.filterCities.clear();
                    if(v.toString().isEmpty){
                      provinceController.filterCities.addAll(provinceController.cities);
                    }else{
                      provinceController.filterCities.addAll(provinceController.cities.where((p0) => p0.name!.toLowerCase().contains(v.toString().toLowerCase())));
                    }
                  },
                  onClick: (){
                      focusActive.value = "city";
                      if(provinceController.cities.isEmpty) {
                        provinceController.apiGetCity(provinceController.selectedProvince.value.id!);
                      }else{
                        provinceController.filterCities.addAll(provinceController.cities);
                      }
                  }, radius: wValue(8)),

              Expanded(child: Column(children: [
                if(focusActive.value == "province") provinceController.isLoadingProvince.value ? showShimmerList() : Expanded(child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: hValue(10)),
                      child: Column(
                        children: [
                          for(var item in provinceController.filterProvinces) itemRegion(item, (item){
                            clearProvinceAndCity();

                            provinceController.selectedProvince.value = item;
                            provinceCtrl.value.text = item.name!;
                            focusActive.value = "none";

                            closeKeyboard(Get.context!);
                          })
                        ],
                      ),
                    )
                ), flex: 1,),

                if(focusActive.value == "city") provinceController.isLoadingCity.value ? showShimmerList() : Expanded(child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: hValue(10)),
                    child: Column(
                      children: [
                        for(var item in provinceController.filterCities) itemRegion(item, (item){
                          provinceController.selectedCity.value = item;
                          kabCtrl.value.text = item.name!;
                          focusActive.value = "none";
                          closeKeyboard(Get.context!);
                        })
                      ],
                    ),
                  ),
                ), flex: 1,),
              ],), flex: 1,),

              Button("Simpan", colorPrimary, true, (){
                Get.back();
                onItemSelected(provinceController.selectedProvince.value, provinceController.selectedCity.value);
              }),

            ],
          ),
          padding: EdgeInsets.all(wValue(25)),
          margin: EdgeInsets.only(top: hValue(100)),
        ));
      });
}

modalBottomAlertDialog({String? image, required String typeAsset, required String title, required String content, String? btnPos, String? btnNeg, Function? btnPosClicked, Function? btnNegClicked}) {
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return WillPopScope(child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  hSpace(10),
                  Text(title, style: boldTextFont.copyWith(fontSize: fontSize(16), color: colorPrimary),),
                  hSpace(20),
                  typeAsset == "png" ? Image.asset(image ?? "assets/img/img_verify_sent.png", width: wValue(194),) : SvgPicture.asset(image ?? "assets/icons/ic_alert.svg", width: wValue(194),),
                  hSpace(14),
                  Text(content, style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.center,),
                  hSpace(30),
                  if(btnNeg != null) Button("$btnNeg", Colors.white, true, (){
                    Get.back();
                    if(btnNegClicked != null) btnNegClicked();
                  }, textSize: fontSize(14), borderColor: colorPrimary, fontColor: colorPrimary),
                  hSpace(5),
                  if(btnPos != null) Button("$btnPos", colorPrimary, true, (){
                    Get.back();
                    if(btnPosClicked != null) btnPosClicked();
                  }, textSize: fontSize(14)),
                ],
              ),
              padding: EdgeInsets.all(wValue(25)),
              margin: EdgeInsets.only(top: hValue(100)),
            )
          ],
        ), onWillPop: () async => true);
      });
}

modalBottomVerifyAccount({String? title, String? content, String? btnPos, required bool skipable, required Function onVerifyClicked}) {
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: skipable,
      enableDrag: skipable,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return WillPopScope(child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  hSpace(10),
                  Text(title ?? "Verifikasi Akun", style: boldTextFont.copyWith(fontSize: fontSize(16), color: colorPrimary),),
                  hSpace(20),
                  SvgPicture.asset("assets/img/img_verify_account.svg", width: wValue(194),),
                  hSpace(14),
                  Text(skipable ? "Akun Anda belum terverifikasi. Silakan lengkapi data untuk dapat mengikuti berbagai event panahan." : "Anda sedang mengikuti Event A, harap lengkapi data Anda.", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.center,),
                  hSpace(30),
                  if(skipable) Container(
                    child: Button("Nanti Saja", Colors.white, true, (){
                      Get.back();
                    }, borderColor: colorPrimary, fontColor: colorPrimary, textSize: fontSize(14)),
                    margin: EdgeInsets.only(bottom: hValue(10)),
                  ),
                  Button(btnPos ?? "Ya, Lengkapi Data", colorPrimary, true, (){
                    onVerifyClicked();
                  }, textSize: fontSize(14)),
                ],
              ),
              padding: EdgeInsets.all(wValue(25)),
              margin: EdgeInsets.only(top: hValue(100)),
            )
          ],
        ), onWillPop: () async => skipable);
      });
}

modalBottomVerifyAccountHaveTransaction({String? title, String? content, bool? skipable,  required Function onVerifyClicked, Function? onLater}) {
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: skipable ?? true,
      enableDrag: skipable ?? true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return WillPopScope(child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  hSpace(10),
                  Text(title ?? "Verifikasi Akun", style: boldTextFont.copyWith(fontSize: fontSize(16), color: colorPrimary),),
                  hSpace(20),
                  SvgPicture.asset("assets/img/img_verify_account.svg", width: wValue(194),),
                  hSpace(14),
                  Text(
                  content ?? str_unverified_acc_w_transaction, style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.center,),
                  hSpace(30),
                  Button("Nanti Saja", Colors.white, true, (){
                    Get.back();
                    if(onLater != null) onLater();
                  }, borderColor: colorPrimary, fontColor: colorPrimary, textSize: fontSize(14)),
                  hSpace(10),
                  Button("Ya, Lengkapi Data", colorPrimary, true, (){
                    onVerifyClicked();
                  }, textSize: fontSize(14)),

                ],
              ),
              padding: EdgeInsets.all(wValue(25)),
              margin: EdgeInsets.only(top: hValue(100)),
            )
          ],
        ), onWillPop: () async => true);
      });
}

modalBottomVerifySent({String? content}) {
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return WillPopScope(child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  hSpace(10),
                  Text("Verifikasi Akun", style: boldTextFont.copyWith(fontSize: fontSize(16), color: colorPrimary),),
                  hSpace(20),
                  Image.asset("assets/img/img_verify_sent.png", width: wValue(194),),
                  hSpace(14),
                  Text(content ?? "Akun Anda dalam proses pengajuan. Anda dapat mengedit profil jika proses verifikasi sudah selesai.", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.center,),
                  hSpace(30),
                  Button("Tutup", colorPrimary, true, (){
                    Get.back();
                  }, textSize: fontSize(14)),
                ],
              ),
              padding: EdgeInsets.all(wValue(25)),
              margin: EdgeInsets.only(top: hValue(100)),
            )
          ],
        ), onWillPop: () async => true);
      });
}

modalBottomVerifyReject({required Function onVerifyClicked}) {
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return WillPopScope(child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  hSpace(10),
                  Text("Verifikasi Akun", style: boldTextFont.copyWith(fontSize: fontSize(16), color: colorPrimary),),
                  hSpace(20),
                  Image.asset("assets/img/img_verify_reject.png", width: wValue(194),),
                  hSpace(14),
                  Text("Verifikasi akun Anda ditolak. SIlakan ajukan ulang sesuai data yang diminta.", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.center,),
                  hSpace(30),
                  Button("Nanti Saja", Colors.white, true, (){
                    Get.back();
                  }, borderColor: colorPrimary, fontColor: colorPrimary, textSize: fontSize(14)),
                  hSpace(10),
                  Button("Ajukan Ulang", colorPrimary, true, (){
                    onVerifyClicked();
                  }, textSize: fontSize(14)),
                ],
              ),
              padding: EdgeInsets.all(wValue(25)),
              margin: EdgeInsets.only(top: hValue(100)),
            )
          ],
        ), onWillPop: () async => true);
      });
}

modalBottomReviewVerifyData(ProfileModel user) {

  var controller = VerifyController();
  var response = GetVerifyDataResponse().obs;
  controller.apiGetDataVerify(user.id.toString(), onFinish: (GetVerifyDataResponse resp){
    response.value = resp;
  });

  itemData(String title, String content){
    return Container(
      child: Row(
        children: [
          Expanded(child: Text("$title", style: boldTextFont.copyWith(fontSize: fontSize(14)),), flex: 1,),
          Text(" : ", style: regularTextFont.copyWith(fontSize: fontSize(12))),
          Expanded(child: Text("$content", style: regularTextFont.copyWith(fontSize: fontSize(12)),), flex: 1,),
        ],
      ),
      width: Get.width,
    );
  }

  itemDataPhoto(String title, String content){
    return Container(
      child: Row(
        children: [
          Expanded(child: Text("$title", style: boldTextFont.copyWith(fontSize: fontSize(14)),), flex: 1,),
          Text(" : ", style: regularTextFont.copyWith(fontSize: fontSize(12))),
          Expanded(child: Image.network("$content"), flex: 1,),
        ],
      ),
      width: Get.width,
    );
  }

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return WillPopScope(child: Obx(()=> Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              hSpace(10),
              Text("Resume Data Peserta", style: boldTextFont.copyWith(fontSize: fontSize(16), color: colorPrimary),),
              hSpace(10),
              Expanded(child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    hSpace(20),
                    controller.isLoadingGetData.value ? showShimmerList() :
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        itemData("Nama Lengkap", "${user.name}"),
                        hSpace(15),
                        itemData("Tanggal Lahir", convertDateFormat("yyyy-MM-dd", "dd/MM/yyyy", "${user.dateOfBirth}")),
                        hSpace(15),
                        itemData("Jenis Kelamin", user.gender.toString().toLowerCase() == "female" ? "Perempuan" : "Laki-Laki"),
                        hSpace(15),
                        itemData("NIK", "${response.value.data!.nik}"),
                        hSpace(15),
                        itemDataPhoto("Foto KTP/KK", "${response.value.data!.ktpKk}"),
                        // hSpace(15),
                        // itemDataPhoto("Foto Selfie", "${response.value.data!.selfieKtpKk}"),
                      ],
                    ),
                    hSpace(15),
                  ],
                ),
              ), flex: 1,),
              hSpace(10),
              Button("Tutup", colorPrimary, true, (){Get.back();})
            ],
          ),
          padding: EdgeInsets.all(wValue(25)),
          margin: EdgeInsets.only(top: hValue(100)),
        )), onWillPop: () async => true);
      });
}

modalBottomChooseImage({required onClick}) {
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return WillPopScope(child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(child: InkWell(
                    child: Column(
                      children: [
                        SvgPicture.asset("assets/icons/ic_gallery.svg"),
                        hSpace(5),
                        Text("Galeri", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                      ],
                    ),
                    onTap: (){
                      Get.back();
                      onClick(1);
                    },
                  ), flex: 1,),
                  wSpace(10),
                  Expanded(child: InkWell(
                    child: Column(
                      children: [
                        SvgPicture.asset("assets/icons/ic_camera.svg"),
                        hSpace(5),
                        Text("Kamera", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                      ],
                    ),
                    onTap: (){
                      Get.back();
                      onClick(2);
                    },
                  ), flex: 1,)
                ],
              ),
              padding: EdgeInsets.all(wValue(25)),
              margin: EdgeInsets.only(top: hValue(100)),
            )
          ],
        ), onWillPop: () async => true);
      });
}

