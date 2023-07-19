import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myarcher_enterprise/core/models/objects/facility_model.dart';
import 'package:myarcher_enterprise/core/models/objects/option_distance_model.dart';
import 'package:myarcher_enterprise/core/models/objects/profile_model.dart';
import 'package:myarcher_enterprise/core/models/objects/region_model.dart';
import 'package:myarcher_enterprise/core/models/objects/schedule_holiday_model.dart';
import 'package:myarcher_enterprise/core/models/objects/time_operational_model.dart';
import 'package:myarcher_enterprise/core/models/objects/venue_model.dart';
import 'package:myarcher_enterprise/core/models/picked_image.dart';
import 'package:myarcher_enterprise/core/models/picked_location.dart';
import 'package:myarcher_enterprise/core/models/responses/detail_venue_response.dart';
import 'package:myarcher_enterprise/core/models/responses/facility_response.dart';
import 'package:myarcher_enterprise/core/models/responses/operational_time_response.dart';
import 'package:myarcher_enterprise/core/models/responses/schedule_holiday_response.dart';
import 'package:myarcher_enterprise/core/services/api_services.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/holiday_schedule/holiday_schedule_controller.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/operational_schedule/operational_schedule_controller.dart';
import 'package:myarcher_enterprise/ui/shared/loading.dart';
import 'package:myarcher_enterprise/ui/shared/modal_bottom.dart';
import 'package:myarcher_enterprise/ui/shared/toast.dart';
import 'package:myarcher_enterprise/utils/endpoint.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class AddVeneuController extends GetxController {
  var box = GetStorage();
  var dio = ApiServices().launch();

  var operationalController = OperationalScheduleController();
  var holidayController = HolidayScheduleController();
  late GoogleMapController mapController;

  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  Rx<VenueModel> dataVenue = VenueModel().obs;

  RxInt selectedState = 0.obs;
  RxInt selectedVenueId = 0.obs;
  RxInt selectedType = 0.obs;
  RxInt maxPhotos = 11.obs; ///means 10 photos
  RxBool isValid = false.obs;
  RxBool isEditable = true.obs;
  Rx<ProfileModel> user = ProfileModel().obs;

  Rx<TextEditingController> fieldNameC = TextEditingController().obs;
  Rx<TextEditingController> shortDescC = TextEditingController().obs;
  Rx<TextEditingController> contactC = TextEditingController().obs;
  Rx<TextEditingController> addressFieldC = TextEditingController().obs;
  Rx<TextEditingController> provinceC = TextEditingController().obs;
  Rx<TextEditingController> cityC = TextEditingController().obs;

  RxBool sameWithPhoneBusiness = false.obs;
  RxList<FacilityModel> facilities = <FacilityModel>[].obs;
  RxList<FacilityModel> otherFacilities = <FacilityModel>[].obs;
  RxList<String> finalOtherFacilities = <String>[].obs;
  RxList<int> currentOtherFacilities = <int>[].obs;
  RxList<PickedImage> selectedImages = <PickedImage>[].obs;
  Rx<RegionModel> selectedProvince = RegionModel().obs;
  Rx<RegionModel> selectedCity = RegionModel().obs;

  Rx<PickedLocation> selectedLocation = PickedLocation().obs;

  RxString errorFieldName = "".obs;
  RxString errorContact = "".obs;
  RxString errorLocationMap = "".obs;
  RxString errorFieldAddress = "".obs;
  RxString errorProvince = "".obs;
  RxString errorCity = "".obs;
  RxString errorFacility = "".obs;
  RxString errorPhoto = "".obs;

  ///capacity
  RxBool isValidToPublish = false.obs;
  RxList<TimeOperationalModel> schedules = <TimeOperationalModel>[].obs;
  RxList<ScheduleHolidayModel> holidaySchedules = <ScheduleHolidayModel>[].obs;
  RxList<OptionDistanceModel> optionDistances = <OptionDistanceModel>[].obs;
  RxInt budrestQty = 0.obs;
  RxInt targetQty = 0.obs;
  RxInt arrowQty = 0.obs;
  RxInt peopleQty = 0.obs;

  Rx<Position> currentPosition = Position(
      latitude: -6.2293866,
      longitude: 106.6890892,
      accuracy: 0.0,
      altitude: 0.0,
      timestamp: DateTime.now(),
      speed: 0,
      speedAccuracy: 0,
      heading: 0)
      .obs;

  Rx<CameraPosition> currentCameraMap =  const CameraPosition(
    target: LatLng(-6.2293866,106.6890892),
    zoom: 20.0,
  ).obs;

  initController() async {
    user.value = GlobalHelper().getCurrentUser();
    isEditable.value = selectedVenueId.value == 0;
  }

  updateCurrentPosition(){
    currentPosition.value = Position(
        latitude: selectedLocation.value.latitude!,
        longitude: selectedLocation.value.longitude!,
        accuracy: 0.0,
        altitude: 0.0,
        timestamp: DateTime.now(),
        speed: 0,
        speedAccuracy: 0,
        heading: 0);

    currentCameraMap.value =  CameraPosition(
      target: LatLng(selectedLocation.value.latitude!,selectedLocation.value.longitude!),
      zoom: 20.0,
    );

    addMarker();

    mapController.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
                currentPosition.value.latitude,
                currentPosition.value
                    .longitude),
            zoom: 20.0)));


  }

  void addMarker() {
    var markerIdVal = "1";
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        currentPosition.value.latitude,
        currentPosition.value.longitude,
      ),
    );

    markers[markerId] = marker;
  }

  manipulatePhotos({required String action, PickedImage? data, int? index}){
    if(action == "add"){
      selectedImages.add(data!);

      ///remove icon add photos when photos already 10
      if(selectedImages.length == maxPhotos.value){
        selectedImages.removeAt(0);
      }
    }else{
      selectedImages.removeAt(index!);
      ///for add icon add photos when photos less than 10
      if(selectedImages.length < maxPhotos.value && !selectedImages.first.isPicker){
        selectedImages.insert(0, PickedImage(isPicker: true, image: File("")));
      }
    }
    checkValidation();
  }

  checkValidation(){
    isValid.value = false;

    if(fieldNameC.value.text.isNotEmpty &&
        contactC.value.text.isNotEmpty &&
        addressFieldC.value.text.isNotEmpty &&
        selectedProvince.value.id != null &&
        selectedCity.value.id != null &&
        facilities.where((p0) => p0.checked!).isNotEmpty &&
        selectedImages.length > 1 &&
        selectedLocation.value.address != null
    ){
      isValid.value = true;
    }
  }

  ifAnyFormFilled(){
    return (fieldNameC.value.text.isNotEmpty ||
        shortDescC.value.text.isNotEmpty ||
        contactC.value.text.isNotEmpty ||
        addressFieldC.value.text.isNotEmpty ||
        facilities.where((p0) => p0.checked!).isNotEmpty ||
        selectedImages.length > 1 ||
        selectedProvince.value.id != null && selectedCity.value.id != null);
  }

  checkIfNumberSameWithPhoneUser(String phone){
    sameWithPhoneBusiness.value = user.value.phoneNumber == phone;
  }

  void apiAddVeneu({bool? isDraft, Function? onFinish}) async {
    bool draft = isDraft != null && isDraft;
    loadingDialog();

    List<int> selectedFacilitiesId = <int>[];
    for(var item in facilities){
      if(item.checked!){
        selectedFacilitiesId.add(item.id!);
      }
    }

    try{

      ///assign id current other facilities
      currentOtherFacilities.clear();
      for(var item in otherFacilities){
        if(item.eoId != 0){
          currentOtherFacilities.add(item.id!);
        }
      }

      ///assign name new other facilities
      finalOtherFacilities.clear();
      for(var item in otherFacilities){
        if(item.eoId == 0){
          finalOtherFacilities.add(item.name!);
        }
      }

      List<String> galleries = <String>[];
      for(var item in selectedImages){
        if(!item.isPicker) {
          if(item.image != null) {
            var value = await GlobalHelper().convertImagetoBase64(File(item.image!.path));
            galleries.add("data:image/png;base64,$value");
          }
        }
      }

      var body = {
        "name" : fieldNameC.value.text,
        "description" : shortDescC.value.text,
        "type" : selectedType.value == 0 ? "Indoor" : selectedType.value == 1 ? "Outdoor" : "Both",
        "phone_number" : contactC.value.text,
        "address" : selectedLocation.value.address,
        "latitude" : selectedLocation.value.latitude,
        "longitude" : selectedLocation.value.longitude,
        "province_id" : selectedProvince.value.id,
        "city_id" : selectedCity.value.id,
        "status" : draft ? 1 : 2,
        "facilities" : selectedFacilitiesId,
        "current_other_facilities" : currentOtherFacilities,
        "other_facilities" : finalOtherFacilities,
        "galleries" : galleries,
      };

      final resp = await dio.post(urlVenue, data: body);
      Get.back();
      checkLogin(resp);

      try {
        if(resp.statusCode.toString().startsWith("2")){
          if(draft){
            Navigator.pop(Get.context!, true);
            Toast().successToast(msg: Translator.successSaveAsDraft.tr);
          }else{
            modalBottomDialog(title: Translator.pengajuanData.tr, isDismisable: false, content: Translator.successAjukanDataMsg.tr, icon: Assets.images.imgSuccessAjukan.path, textButton: Translator.close.tr, onClick: (){
              Navigator.pop(Get.context!, true);
            });
          }
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiAddVeneu(isDraft: isDraft);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiAddVeneu(isDraft: isDraft);
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiAddVeneu(isDraft: isDraft);
      });
    }
  }

  void apiPublishVenue({Function? onFinish}) async {
    loadingDialog();
    try{

      ///assign id master distance
      var masterCapacity = <int>[];
      var otherCapacity = <String>[];
      for(var item in optionDistances){
        if(item.eoId != 0){
          masterCapacity.add(item.id!);
        }else if(item.eoId == 0){
          otherCapacity.add("${item.distance}");
        }
      }


      var body = {
        "id" : dataVenue.value.id,
        "budrest_quantity" : budrestQty.value,
        "target_quantity" : targetQty.value,
        "arrow_quantity" : arrowQty.value,
        "people_quantity" : peopleQty.value,
        "capacity_area" : masterCapacity,
        "current_capacity_area" : [],
        "other_capacity_area" : otherCapacity,
      };

      final resp = await dio.post(urlPublishVenue, data: body);
      Get.back();
      checkLogin(resp);

      try {
        if(resp.statusCode.toString().startsWith("2")){
          Toast().successToast(msg: resp.data['message']);
          if(onFinish != null){
            onFinish();
          }
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiPublishVenue(onFinish: onFinish);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiPublishVenue(onFinish: onFinish);
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiPublishVenue(onFinish: onFinish);
      });
    }
  }

  void apiUpdateVeneu({bool? isDraft, Function? onFinish}) async {
    bool draft = isDraft != null && isDraft;
    loadingDialog();

    List<int> selectedFacilitiesId = <int>[];
    for(var item in facilities){
      if(item.checked!){
        selectedFacilitiesId.add(item.id!);
      }
    }

    try{

      ///assign id current other facilities
      currentOtherFacilities.clear();
      for(var item in otherFacilities){
        if(item.eoId != 0){
          currentOtherFacilities.add(item.id!);
        }
      }

      ///assign name new other facilities
      finalOtherFacilities.clear();
      for(var item in otherFacilities){
        if(item.eoId == 0){
          finalOtherFacilities.add(item.name!);
        }
      }

      List<String> galleries = <String>[];
      for(var item in selectedImages){
        if(!item.isPicker) {
          if(item.image != null) {
            var value = await GlobalHelper().convertImagetoBase64(File(item.image!.path));
            galleries.add("data:image/png;base64,$value");
          }
        }
      }

      var body = {
        "id" : selectedVenueId.value,
        "name" : fieldNameC.value.text,
        "description" : shortDescC.value.text,
        "type" : selectedType.value == 0 ? "Indoor" : selectedType.value == 1 ? "Outdoor" : "Both",
        "phone_number" : contactC.value.text,
        "address" : selectedLocation.value.address,
        "latitude" : selectedLocation.value.latitude,
        "longitude" : selectedLocation.value.longitude,
        "province_id" : selectedProvince.value.id,
        "city_id" : selectedCity.value.id,
        "status" : draft ? 1 : 2,
        "facilities" : selectedFacilitiesId,
        "current_other_facilities" : currentOtherFacilities,
        "other_facilities" : finalOtherFacilities,
        "galleries" : galleries,
      };

      final resp = await dio.post(urlUpdateVenue, data: body);
      Get.back();
      checkLogin(resp);

      try {
        if(resp.statusCode.toString().startsWith("2")){
          if(draft){
            Navigator.pop(Get.context!, true);
            Toast().successToast(msg: Translator.successSaveAsDraft.tr);
          }else{
            modalBottomDialog(title: Translator.pengajuanData.tr, isDismisable: false, content: Translator.successAjukanDataMsg.tr, icon: Assets.images.imgSuccessAjukan.path, textButton: Translator.close.tr, onClick: (){
              Navigator.pop(Get.context!, true);
            });
          }
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiUpdateVeneu(isDraft: isDraft);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiUpdateVeneu(isDraft: isDraft);
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiUpdateVeneu(isDraft: isDraft);
      });
    }
  }

  void apiDetailVenue({required String id, Function? onFinish}) async {
    loadingDialog();

    try {
      final resp = await dio.get(urlVenue, queryParameters: {
        "id" : id
      });
      Get.back();
      checkLogin(resp);

      try {
        DetailVenueResponse response = DetailVenueResponse.fromJson(resp.data);
        if(response.data != null){
          dataVenue.value = response.data!;

          fieldNameC.value.text = dataVenue.value.name ?? "-";
          shortDescC.value.text = dataVenue.value.description ?? "-";

          ///set number
          contactC.value.text = dataVenue.value.phoneNumber ?? "-";
          checkIfNumberSameWithPhoneUser(contactC.value.text);

          otherFacilities.addAll(dataVenue.value.otherFacilities!);
          addressFieldC.value.text = dataVenue.value.address ?? "-";

          ///set type field
          if(dataVenue.value.placeType != null && dataVenue.value.placeType!.isNotEmpty){
            if(dataVenue.value.placeType == "Indoor"){
              selectedType.value = 0;
            }else if(dataVenue.value.placeType == "Outdoor"){
              selectedType.value = 1;
            }else{
              selectedType.value = 2;
            }
          }

          ///set location
          selectedLocation.value = PickedLocation(
            latitude: double.parse(dataVenue.value.latitude),
            longitude: double.parse(dataVenue.value.longitude),
            address: dataVenue.value.address
          );
          updateCurrentPosition();

          ///set current province
          selectedProvince.value = dataVenue.value.province!;
          provinceC.value.text = dataVenue.value.province?.name ?? "";

          ///set current city
          selectedCity.value = dataVenue.value.city!;
          cityC.value.text = dataVenue.value.city?.name ?? "";


          ///set current facilities
          for(var item in facilities){
            if(dataVenue.value.facilities!.any((element) => element.id == item.id)){
              facilities[facilities.indexWhere((p0) => p0.id == item.id)] = FacilityModel(id: item.id, name: item.name, icon: item.icon, eoId: item.eoId, checked: true, updatedAt: item.updatedAt, createdAt: item.createdAt);
            }
          }

          ///set current images
          for(var item in dataVenue.value.galleries!){
            selectedImages.add(PickedImage(isPicker: false, url: item));
          }

          if(dataVenue.value.status == StatusVenue.draft){
            isEditable.value = true;
            selectedImages.insert(0, PickedImage(isPicker: true, image: File("")));
          }

          checkValidation();

          if(dataVenue.value.status == StatusVenue.lengkapiData){
            operationalController.apiListScheduleOperational(id: dataVenue.value.id!, onFinish: (OperationalTimeResponse resp){
              schedules.clear();
              schedules.addAll(resp.data!);
            });

            holidayController.apiListScheduleHoliday(id: dataVenue.value.id!, onFinish: (ScheduleHolidayResponse resp){
              holidaySchedules.clear();
              holidaySchedules.addAll(resp.data!);
            });
          }

        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiDetailVenue(id: id);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiDetailVenue(id: id);
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiDetailVenue(id: id);
      });
    }
  }

  void apiGetFacility() async {
    loadingDialog();

    try{
      final resp = await dio.get(urlFacilityVeneu);
      Get.back();
      checkLogin(resp);

      try {
        FacilityResponse response = FacilityResponse.fromJson(resp.data);
        if(response.data != null){
          for(var item in response.data!){
            facilities.add(FacilityModel(
              id: item.id,
              name: item.name,
              eoId: item.eoId,
              icon: item.icon,
              createdAt: item.createdAt,
              updatedAt: item.updatedAt,
              checked: false
            ));
          }

          if(selectedVenueId.value != 0){
            apiDetailVenue(id: selectedVenueId.value.toString());
          }
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiGetFacility();
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiGetFacility();
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiGetFacility();
      });
    }
  }

  void apiGetOtherFacility() async {
    loadingDialog();

    try{
      final resp = await dio.get(urlHistoryOtherFacilities);
      Get.back();
      checkLogin(resp);

      try {
        FacilityResponse response = FacilityResponse.fromJson(resp.data);
        if(response.data != null){
          for(var item in response.data!){
            otherFacilities.add(FacilityModel(
                id: item.id,
                name: item.name,
                eoId: item.eoId,
                icon: item.icon,
                createdAt: item.createdAt,
                updatedAt: item.updatedAt,
                checked: false
            ));
          }
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiGetOtherFacility();
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiGetOtherFacility();
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiGetOtherFacility();
      });
    }
  }

  void apiDeleteImageVenue({required int id, required int index}) async {
    loadingDialog();

    try{
      final resp = await dio.post(urlDeleteImageVenue, queryParameters: {
        "id" : id,
      });
      Get.back();
      checkLogin(resp);

      try {
        if(resp.statusCode.toString().startsWith("2")){
          manipulatePhotos(action: "remove", index: index);
        }else{
          Toast().errorToast(msg: getErrorMessage(resp));
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        Toast().errorToast(msg: msg);
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      Toast().errorToast(msg: msg);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
