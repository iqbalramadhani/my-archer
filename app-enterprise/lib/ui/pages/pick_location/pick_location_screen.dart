import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myarcher_enterprise/core/models/picked_location.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/pick_location/pick_location_controller.dart';
import 'package:myarcher_enterprise/ui/pages/pick_location/place_autocomplete_screen/place_autocomplete_screen.dart';
import 'package:myarcher_enterprise/ui/shared/appbar.dart';
import 'package:myarcher_enterprise/ui/shared/base_container.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/ui/shared/edittext.dart';
import 'package:myarcher_enterprise/ui/shared/toast.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';
import 'package:simple_shadow/simple_shadow.dart';

class PickLocationScreen extends StatefulWidget {
  final PickedLocation? currentLoc;
  const PickLocationScreen({Key? key, this.currentLoc}) : super(key: key);

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  var controller = PickLocationController();

  @override
  void initState() {
    if(widget.currentLoc != null){
      controller.currentLocation.value = widget.currentLoc!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(title: Translator.fieldLocation.tr, onClick: (){
              Get.back();
            }),
            Expanded(flex: 1,child: Stack(
              children: [
                Obx(()=> GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  initialCameraPosition: controller.currentCameraMap.value,
                  onMapCreated: (GoogleMapController ctrl) {
                    try{
                      controller.mapController = ctrl;
                      if(widget.currentLoc == null){
                        GlobalHelper().getCurrentLoc().then((value) {
                          controller.currentPosition.value = value;
                          controller.mapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: LatLng(
                                      controller.currentPosition.value.latitude,
                                      controller.currentPosition.value
                                          .longitude),
                                  zoom: 20.0)));
                        });
                      }else{
                        controller.currentPosition.value = Position(
                            latitude: widget.currentLoc!.latitude!,
                            longitude: widget.currentLoc!.longitude!,
                            accuracy: 0.0,
                            altitude: 0.0,
                            timestamp: DateTime.now(),
                            speed: 0,
                            speedAccuracy: 0,
                            heading: 0);

                        controller.currentCameraMap.value =  CameraPosition(
                          target: LatLng(widget.currentLoc!.latitude!,widget.currentLoc!.longitude!),
                          zoom: 20.0,
                        );

                        controller.mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(
                                widget.currentLoc!.latitude!,
                                widget.currentLoc!.longitude!),
                            zoom: 20.0)));
                      }
                    }catch(e){}
                  },
                  onCameraIdle: (){
                    getCenter().then((value)  {
                      var coord = Coordinates(value.latitude, value.longitude);
                      getAddress(coord).then((value)  {
                        controller.address.value = value.addressLine;
                        controller.selectedLoc.value = coord;
                      });
                    });
                  },
                  zoomControlsEnabled: false,
                )),
                Center(
                  child: SvgPicture.asset(Assets.icons.icCircleMarker),
                ),
                SimpleShadow(
                  sigma: 3,
                  opacity: 0.3,
                  child: Container(
                    child: EditText(
                        controller: controller.addressTxtCtrl,
                        hintText: Translator.findAddress.tr,
                        contentPadding: EdgeInsets.all(wValue(10)),
                        radius: wValue(8),
                        readOnly: true,
                        onClick: () async {
                          PickedLocation? result = await Navigator.push(
                            Get.context!,
                            MaterialPageRoute(builder: (context) => const PlaceAutocompleteScreen()),
                          );

                          if(result  != null){
                            controller.address.value = result.address ?? "";
                            controller.selectedLoc.value = Coordinates(result.latitude, result.longitude);

                            controller.updateLocationMap(latitude: result.latitude!, longitude: result.longitude!);
                          }
                        },
                        bgColor: AppColor.gray80,
                        borderColor: AppColor.gray80,
                        leftIcon: Assets.icons.icMarkerBorder,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.done
                    ),
                    margin: EdgeInsets.all(wValue(15)),
                  ),             // Default: 2
                ),
                Positioned(
                  bottom: 0,
                  child:  SimpleShadow(
                    sigma: 6,
                    opacity: 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.all(wValue(10)),
                          child: InkWell(
                            child: SvgPicture.asset(Assets.icons.icCurrentLoc),
                            onTap: (){
                              GlobalHelper().getCurrentLoc().then((value) {
                                controller.currentPosition.value = value;
                                controller.mapController.animateCamera(
                                    CameraUpdate.newCameraPosition(CameraPosition(
                                        target: LatLng(
                                            controller.currentPosition.value.latitude,
                                            controller.currentPosition.value
                                                .longitude),
                                        zoom: 20.0)));
                              });
                            },
                          ),
                        ),
                        Container(
                          width: Get.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            color: AppColor.white,
                          ),
                          padding: EdgeInsets.all(wValue(25)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Translator.fieldAddress.tr, style: textBaseBold.copyWith(color: AppColor.colorPrimary, fontSize: fontSize(13))),
                              hSpace(3),
                              Obx(()=> Text(controller.address.value, style: textBaseRegular.copyWith(fontSize: fontSize(12)))),
                              hSpace(10),
                              Row(
                                children: [
                                  Expanded(flex: 1,child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(Translator.latitude.tr, style: textBaseBold.copyWith(color: AppColor.colorPrimary, fontSize: fontSize(13))),
                                      hSpace(3),
                                      Obx(()=> Text("${controller.currentPosition.value.latitude}", style: textBaseRegular.copyWith(fontSize: fontSize(10))))
                                    ],
                                  ),),
                                  Expanded(flex: 1,child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(Translator.longitude.tr, style: textBaseBold.copyWith(color: AppColor.colorPrimary)),
                                      hSpace(3),
                                      Obx(()=> Text("${controller.currentPosition.value.longitude}", style: textBaseRegular.copyWith(fontSize: fontSize(10))))
                                    ],
                                  ),),
                                ],
                              ),
                              hSpace(10),
                              Button(title: Translator.confirmLocation.tr, color: AppColor.colorPrimary, enable: true, onClick: (){
                                if(controller.address.value.isEmpty){
                                  Toast().errorToast(msg: Translator.addressMustFill.tr);
                                  return;
                                }

                                PickedLocation data = PickedLocation(address : controller.address.value, latitude : controller.selectedLoc.value.latitude, longitude: controller.selectedLoc.value.longitude);
                                Navigator.pop(Get.context!, data);
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),)
          ],
        ),
      ),
    );
  }

  Future<LatLng> getCenter() async {
    GoogleMapController ctrl = controller.mapController;
    LatLngBounds visibleRegion = await ctrl.getVisibleRegion();
    LatLng centerLatLng = LatLng(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) / 2,
    );

    return centerLatLng;
  }
}
