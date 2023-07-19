
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_place/google_place.dart';
import 'package:myarcher_enterprise/core/models/picked_location.dart';
import 'package:myarcher_enterprise/core/services/api_services.dart';
import 'package:myarcher_enterprise/core/services/environment.dart';
import 'package:myarcher_enterprise/ui/shared/toast.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class PlaceAutocompleteController extends GetxController {
  var box = GetStorage();
  var dio = ApiServices().launch();

  RxBool isLoading = false.obs;
  var searchC = TextEditingController();

  RxList<AutocompletePrediction> places = <AutocompletePrediction>[].obs;

  searchPlace({required String q}) async {
    places.clear();
    var googlePlace = GooglePlace(Environment.placesApiKey);
    isLoading.value = true;
    var result = await googlePlace.autocomplete.get(q, region: "id", language: "id_ID");
    isLoading.value = false;
    if(result!.status != StatusPlacesAPI.ok){
      Toast().errorToast(msg: Translator.failedGetData.tr);
    }else{
      places.addAll(result.predictions!);
    }
  }

  getDetail({required String id}) async {
    var googlePlace = GooglePlace(Environment.placesApiKey);
    var result = await googlePlace.details.get(id, region: "id", language: "id_ID");
    PickedLocation data = PickedLocation(
      address: result?.result!.formattedAddress,
      latitude: result?.result!.geometry!.location?.lat,
      longitude: result?.result!.geometry!.location?.lng,
    );
    Navigator.pop(Get.context!, data);
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
