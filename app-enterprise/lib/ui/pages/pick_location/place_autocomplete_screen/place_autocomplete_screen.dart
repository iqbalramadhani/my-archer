import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/pick_location/place_autocomplete_screen/place_autocomplete_controller.dart';
import 'package:myarcher_enterprise/ui/pages/pick_location/place_autocomplete_screen/widget/item_place.dart';
import 'package:myarcher_enterprise/ui/pages/pick_location/place_autocomplete_screen/widget/not_found_place.dart';
import 'package:myarcher_enterprise/ui/shared/appbar.dart';
import 'package:myarcher_enterprise/ui/shared/base_container.dart';
import 'package:myarcher_enterprise/ui/shared/edittext.dart';
import 'package:myarcher_enterprise/ui/shared/shimmer_loading.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/translator.dart';
import 'package:simple_shadow/simple_shadow.dart';

class PlaceAutocompleteScreen extends StatefulWidget {
  const PlaceAutocompleteScreen({Key? key}) : super(key: key);

  @override
  State<PlaceAutocompleteScreen> createState() => _PlaceAutocompleteScreenState();
}

class _PlaceAutocompleteScreenState extends State<PlaceAutocompleteScreen> {

  var controller = PlaceAutocompleteController();

  @override
  Widget build(BuildContext context) {
    return BaseContainer(child: Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: Translator.fieldLocation.tr, onClick: (){
            Get.back();
          }),
          SimpleShadow(
            sigma: 3,
            opacity: 0.3,
            child: Container(
              child: EditText(
                  controller: controller.searchC,
                  hintText: Translator.findAddress.tr,
                  contentPadding: EdgeInsets.all(wValue(10)),
                  radius: wValue(8),
                  rightIcon: Assets.icons.icClose,
                  onRightIconClicked: (){
                    controller.searchC.text = "";
                  },
                  bgColor: AppColor.gray80,
                  borderColor: AppColor.gray80,
                  leftIcon: Assets.icons.icMarkerBorder,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  onSubmit: (v){
                    controller.searchPlace(q: v);
                  }
              ),
              margin: EdgeInsets.all(wValue(15)),
            ),             // Default: 2
          ),
          Expanded(flex: 1,child: Obx(()=> controller.isLoading.value ? showShimmerList() : Container(
            margin: EdgeInsets.only(left: wValue(15), right: wValue(15)),
            child: controller.places.isEmpty ? const NotFoundPlace() : _viewList(),
          )),)
        ],
      ),
    ));
  }

  _viewList(){
    return ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: controller.places.length,
        itemBuilder: (context,index){
          var data = controller.places[index];
          return  ItemPlace(data: data, onClick: (){
            controller.getDetail(id: data.placeId!);
          },);
        });
  }
}
