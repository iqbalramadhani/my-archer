import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/core/controllers/facility_controller.dart';
import 'package:myarcher_enterprise/core/controllers/option_distance_controller.dart';
import 'package:myarcher_enterprise/core/controllers/province_controller.dart';
import 'package:myarcher_enterprise/core/models/objects/facility_model.dart';
import 'package:myarcher_enterprise/core/models/objects/option_distance_model.dart';
import 'package:myarcher_enterprise/core/models/objects/time_operational_model.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/operational_schedule/widget/item_jam.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/ui/shared/dialog.dart';
import 'package:myarcher_enterprise/ui/shared/edittext.dart';
import 'package:myarcher_enterprise/ui/shared/item/item_exist_facility.dart';
import 'package:myarcher_enterprise/ui/shared/item/item_option_distance.dart';
import 'package:myarcher_enterprise/ui/shared/item_option.dart';
import 'package:myarcher_enterprise/ui/shared/item_region.dart';
import 'package:myarcher_enterprise/ui/shared/loading.dart';
import 'package:myarcher_enterprise/ui/shared/shimmer_loading.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

modalBottomProvince({required Function onItemSelected}) {
  var controller = ProvinceController();

  controller.currentPageProvince.value = 1;
  controller.provinces.clear();
  controller.validLoadMoreProvince.value = false;

  controller.apiGetProvince();
  var _scrollController = ScrollController();
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
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(wValue(25)),
          margin: EdgeInsets.only(top: hValue(100)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Translator.findProvince.tr, style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Text(Translator.cancel.tr, style: boldTextFont.copyWith(fontSize: fontSize(14), color: AppColor.gray400),),
                  ),
                ],
              ),
              hSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 1,child: SizedBox(
                    child: EditText(hintText: Translator.findProvince.tr, leftIcon: Assets.icons.icSearch, borderColor: AppColor.gray200, onChange: (value){
                      controller.filterProvinces.clear();
                      if(value.toString().isEmpty){
                        controller.filterProvinces.addAll(controller.provinces);
                      }else{
                        controller.filterProvinces.addAll(controller.provinces.where((p0) => p0.name!.toLowerCase().contains(value.toString().toLowerCase())));
                      }
                    }, radius: wValue(8)),
                    height: hValue(38),
                  ),),
                ],
              ),
              hSpace(20),
              Expanded(flex: 1,child: (controller.isLoadingProvince.value && controller.currentPageProvince.value == 1) ? showShimmerList() :
              SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    for(var item in controller.filterProvinces) ItemRegion(data : item, onClick: (data){
                      Get.back();
                      onItemSelected(data);
                    }),
                    if((controller.isLoadingProvince.value && controller.currentPageProvince.value > 1)) Container(
                      child: loading(),
                      margin: EdgeInsets.all(wValue(10)),
                    )
                  ],
                ),),)
            ],
          ),
        ));
      });
}

modalBottomCity({required String idProvince, required Function onItemSelected}) {
  var controller = ProvinceController();

  controller.currentPageCity.value = 1;
  controller.cities.clear();
  controller.validLoadMoreCity.value = false;

  controller.apiGetCity(idProvince);

  var _scrollController = ScrollController();
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
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(wValue(25)),
          margin: EdgeInsets.only(top: hValue(100)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Translator.findCity.tr, style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Text(Translator.cancel.tr, style: boldTextFont.copyWith(fontSize: fontSize(14), color: AppColor.gray400),),
                  ),
                ],
              ),
              hSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 1,child: SizedBox(
                    child: EditText(hintText: Translator.findCity.tr, leftIcon: Assets.icons.icSearch, borderColor: AppColor.gray200, onChange: (value){
                      controller.filterCities.clear();
                      if(value.toString().isEmpty){
                        controller.filterCities.addAll(controller.cities);
                      }else{
                        controller.filterCities.addAll(controller.cities.where((p0) => p0.name!.toLowerCase().contains(value.toString().toLowerCase())));
                      }
                    }, radius: wValue(8)),
                    height: hValue(38),
                  ),),
                ],
              ),
              hSpace(20),
              Expanded(flex: 1,child: (controller.isLoadingCity.value && controller.currentPageCity.value == 1) ? showShimmerList() :
              SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    for(var item in controller.filterCities) ItemRegion(data : item, onClick: (item){
                      Get.back();
                      onItemSelected(item);
                    }),
                    if((controller.isLoadingCity.value && controller.currentPageCity.value > 1)) Container(
                      child: loading(),
                      margin: EdgeInsets.all(wValue(10)),
                    )
                  ],
                ),),)
            ],
          ),
        ));
      });
}

modalBottomDynamicAction({required List<String> actions, required Function onItemSelected}) {
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(wValue(25)),
              margin: EdgeInsets.only(top: hValue(100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: SvgPicture.asset(Assets.icons.icPullModalBottom),),
                  hSpace(15),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: [
                        for(var item in actions) ItemOption(data: item, onClick: (){
                          Get.back();
                          onItemSelected(item);
                        })
                      ],
                    ),)
                ],
              ),
            )
          ],
        );
      });
}

modalBottomExistOtherFacilities({required Function onItemSelected}) {
  var controller = FacilityController();

  controller.filterOtherFacilities.clear();

  controller.apiGetOtherFacility();

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return Obx(()=> Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(wValue(25)),
          margin: EdgeInsets.only(top: hValue(100)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Translator.otherFacility.tr, style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Text(Translator.cancel.tr, style: boldTextFont.copyWith(fontSize: fontSize(14), color: AppColor.gray400),),
                  ),
                ],
              ),
              hSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 1,child: SizedBox(
                    child: EditText(hintText: Translator.findOtherFacility.tr, leftIcon: Assets.icons.icSearch, borderColor: AppColor.gray200, onChange: (value){
                      controller.filterOtherFacilities.clear();
                      if(value.toString().isEmpty){
                        controller.filterOtherFacilities.addAll(controller.otherFacilities);
                      }else{
                        controller.filterOtherFacilities.addAll(controller.otherFacilities.where((p0) => p0.name!.toLowerCase().contains(value.toString().toLowerCase())));
                      }
                    }, radius: wValue(8)),
                    height: hValue(38),
                  ),),
                ],
              ),
              hSpace(20),
              Expanded(flex: 1,child: (controller.isLoading.value) ? showShimmerList() :
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    for(var item in controller.filterOtherFacilities) ItemExistFacility(data: item, onCheked: (isChecked){
                      controller.filterOtherFacilities[controller.filterOtherFacilities.indexWhere((element) => element.name == item.name)] = FacilityModel(
                          icon: item.icon,
                          name: item.name,
                          eoId: item.eoId,
                          createdAt: item.createdAt,
                          updatedAt: item.updatedAt,
                          id: item.id,
                          checked: isChecked
                      );
                    }, onDelete: (){
                      showConfirmDialog(Get.context!, content: Translator.msgDeleteOtherFacility.tr, showIcon: true,
                          assets: Assets.icons.icAlert, typeAsset: "svg",
                          showCloseTopCorner: true,
                          btn1: Translator.canceling.tr,
                          btn3: Translator.delete.tr,
                          onClickBtn1: (){

                          }, onClickBtn3: (){
                            controller.apiHideItemOtherFacility(id: item.id!);
                          });
                    },),
                  ],
                ),),),
              Button(title: Translator.add.tr, color: controller.filterOtherFacilities.where((p0) => p0.checked!).isNotEmpty ? AppColor.colorPrimary : AppColor.gray500, enable: controller.filterOtherFacilities.where((p0) => p0.checked!).isNotEmpty, onClick: (){
                Get.back();
                  onItemSelected(controller.filterOtherFacilities.where((p0) => p0.checked!));
              })
            ],
          ),
        ));
      });
}

modalBottomCurrentDistance({List<OptionDistanceModel>? currentData, required Function onItemSelected}) {
  var controller = OptionDistanceController();
  controller.apiGetOptionDistance(isClear: true, onFinish: (){
    if(currentData != null){
      controller.filterOptionDistance.clear();
      for(var item in controller.optionDistance){
        if(currentData.any((element) => element.id == item.id)){
          controller.optionDistance[controller.optionDistance.indexWhere((element) => element.id == item.id)] = OptionDistanceModel(
             id: item.id,
            distance: item.distance,
            eoId: item.eoId,
            checked: true,
            createdAt: item.createdAt,
            updatedAt: item.updatedAt
          );
        }
      }

      controller.filterOptionDistance.addAll(controller.optionDistance);
    }
  });

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return Obx(()=> Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(wValue(25)),
          margin: EdgeInsets.only(top: hValue(100)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Translator.chooseDistance.tr, style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Text(Translator.cancel.tr, style: boldTextFont.copyWith(fontSize: fontSize(14), color: AppColor.gray400),),
                  ),
                ],
              ),
              hSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 1,child: SizedBox(
                    child: EditText(hintText: Translator.searchDistance.tr, leftIcon: Assets.icons.icSearch, borderColor: AppColor.gray200, onChange: (value){
                      controller.filterOptionDistance.clear();
                      if(value.toString().isEmpty){
                        controller.filterOptionDistance.addAll(controller.optionDistance);
                      }else{
                        controller.filterOptionDistance.addAll(controller.optionDistance.where((p0) => p0.distance!.toString().toLowerCase().contains(value.toString().toLowerCase())));
                      }
                    }, radius: wValue(8)),
                    height: hValue(38),
                  ),),
                ],
              ),
              hSpace(20),
              Expanded(flex: 1,child: (controller.isLoading.value) ? showShimmerList() :
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    for(var item in controller.filterOptionDistance) ItemOptionDistance(data: item, onCheked: (isChecked){
                      controller.filterOptionDistance[controller.filterOptionDistance.indexWhere((element) => element.distance.toString().toLowerCase() == item.distance.toString().toLowerCase())] = OptionDistanceModel(
                          distance: item.distance,
                          eoId: item.eoId,
                          createdAt: item.createdAt,
                          updatedAt: item.updatedAt,
                          id: item.id,
                          checked: isChecked
                      );
                    }),
                  ],
                ),),),
              Button(title: Translator.add.tr, color: controller.filterOptionDistance.where((p0) => p0.checked!).isNotEmpty ? AppColor.colorPrimary : AppColor.gray500, enable: controller.filterOptionDistance.where((p0) => p0.checked!).isNotEmpty, onClick: (){
                Get.back();
                var datas = controller.filterOptionDistance.where((p0) => p0.checked!);
                onItemSelected(datas);
              })
            ],
          ),
        ));
      });
}

modalBottomDialog({required String title, String? icon, String? textButton, bool? isDismisable, Function? onClick, required String content}) {
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: isDismisable ?? true,
      context: Get.context!,
      builder: (context) {
        return WillPopScope(child: Wrap(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(wValue(25)),
              margin: EdgeInsets.only(top: hValue(100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  hSpace(10),
                  Text(title, style: boldTextFont.copyWith(fontSize: fontSize(16), color: AppColor.colorPrimary),),
                  hSpace(20),
                  (icon == null) ? SvgPicture.asset(Assets.images.imgSuccess, width: wValue(194)) :
                  (icon.contains(".svg")) ?  SvgPicture.asset(icon, width: wValue(194)) : Image.asset(icon, width: wValue(194)),
                  hSpace(14),
                  Text(content, style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.center,),
                  hSpace(30),
                  Button(title : textButton ?? Translator.close.tr, color : AppColor.colorPrimary, enable : true, onClick: (){
                    Get.back();
                    if(onClick != null){
                      onClick();
                    }
                  }, textSize: fontSize(14)),
                ],
              ),
            )
          ],
        ), onWillPop: () async => isDismisable ?? true);
      });
}

