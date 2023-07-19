
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myarcher_enterprise/core/models/picked_location.dart';
import 'package:myarcher_enterprise/core/services/api_services.dart';

class PickLocationController extends GetxController {
  var box = GetStorage();
  var dio = ApiServices().launch();

  late GoogleMapController mapController;
  var addressTxtCtrl = TextEditingController();
  RxString address = "".obs;
  Rx<Coordinates> selectedLoc = Coordinates(0,0).obs;
  Rx<PickedLocation> currentLocation = PickedLocation().obs;

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

  updateLocationMap({required double latitude, required double longitude}){
    currentPosition.value = Position(
        latitude: latitude,
        longitude: longitude,
        accuracy: 0.0,
        altitude: 0.0,
        timestamp: DateTime.now(),
        speed: 0,
        speedAccuracy: 0,
        heading: 0);

    currentCameraMap.value =  CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 20.0,
    );

    mapController.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
                latitude,
                longitude),
            zoom: 20.0)));

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
