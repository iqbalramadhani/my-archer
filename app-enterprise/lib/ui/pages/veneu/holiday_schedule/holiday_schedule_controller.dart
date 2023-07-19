import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myarcher_enterprise/core/models/objects/facility_model.dart';
import 'package:myarcher_enterprise/core/models/objects/profile_model.dart';
import 'package:myarcher_enterprise/core/models/objects/region_model.dart';
import 'package:myarcher_enterprise/core/models/objects/schedule_holiday_model.dart';
import 'package:myarcher_enterprise/core/models/objects/time_operational_model.dart';
import 'package:myarcher_enterprise/core/models/objects/venue_model.dart';
import 'package:myarcher_enterprise/core/models/picked_image.dart';
import 'package:myarcher_enterprise/core/models/picked_location.dart';
import 'package:myarcher_enterprise/core/models/responses/base_response.dart';
import 'package:myarcher_enterprise/core/models/responses/detail_venue_response.dart';
import 'package:myarcher_enterprise/core/models/responses/facility_response.dart';
import 'package:myarcher_enterprise/core/models/responses/operational_time_response.dart';
import 'package:myarcher_enterprise/core/models/responses/schedule_holiday_response.dart';
import 'package:myarcher_enterprise/core/services/api_services.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/shared/loading.dart';
import 'package:myarcher_enterprise/ui/shared/modal_bottom.dart';
import 'package:myarcher_enterprise/ui/shared/toast.dart';
import 'package:myarcher_enterprise/utils/endpoint.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class HolidayScheduleController extends GetxController {
  var box = GetStorage();
  var dio = ApiServices().launch();

  RxBool isLoading = false.obs;

  RxList<ScheduleHolidayModel> schedules = <ScheduleHolidayModel>[].obs;

  void apiAddScheduleHoliday({required int id, required String startAt, required String endAt, Function? onFinish}) async {
    loadingDialog();

    try{
      var body = {
        "place_id" : id,
        "start_at" : startAt,
        "end_at" : endAt,
      };

      final resp = await dio.post(urlAddHolidaySchedule, data: body);
      Get.back();
      checkLogin(resp);

      try {
        if(resp.statusCode.toString().startsWith("2")){
         if(onFinish != null) onFinish();
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiAddScheduleHoliday(id: id, startAt: startAt, endAt: endAt, onFinish: onFinish);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiAddScheduleHoliday(id: id, startAt: startAt, endAt: endAt, onFinish: onFinish);
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiAddScheduleHoliday(id: id, startAt: startAt, endAt: endAt, onFinish: onFinish);
      });
    }
  }

  void apiUpdateScheduleHoliday({required int id, required String startAt, required String endAt, Function? onFinish}) async {
    loadingDialog();

    try{
      var body = {
        "id" : id,
        "start_at" : startAt,
        "end_at" : endAt,
      };

      final resp = await dio.post(urlUpdateHolidaySchedule, data: body);
      Get.back();
      checkLogin(resp);

      try {
        if(resp.statusCode.toString().startsWith("2")){
         if(onFinish != null) onFinish();
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiAddScheduleHoliday(id: id, startAt: startAt, endAt: endAt, onFinish: onFinish);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiAddScheduleHoliday(id: id, startAt: startAt, endAt: endAt, onFinish: onFinish);
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiAddScheduleHoliday(id: id, startAt: startAt, endAt: endAt, onFinish: onFinish);
      });
    }
  }

  void apiListScheduleHoliday({required int id, bool? isClear, Function? onFinish}) async {
    if(isClear != null && isClear){
      schedules.clear();
    }
    isLoading.value = true;

    try{
      var param = {
        "place_id" : id,
      };

      final resp = await dio.get(urlListHolidaySchedule, queryParameters: param);
      isLoading.value = false;
      checkLogin(resp);

      try {
        ScheduleHolidayResponse response = ScheduleHolidayResponse.fromJson(resp.data);
        if(resp.statusCode.toString().startsWith("2")){
          schedules.addAll(response.data!);
          if(onFinish != null){
            onFinish(response);
          }
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiListScheduleHoliday(id: id, onFinish: onFinish);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiListScheduleHoliday(id: id, onFinish: onFinish);
        });
      }
    }catch(_){
      isLoading.value = false;
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiListScheduleHoliday(id: id, onFinish: onFinish);
      });
    }
  }

  void apiDeleteScheduleHoliday({required int id, required int placeId}) async {
    loadingDialog();

    try{
      var param = {
        "id" : id,
      };

      final resp = await dio.post(urlDeleteHolidaySchedule, queryParameters: param);
      Get.back();
      checkLogin(resp);

      try {
        if(resp.statusCode.toString().startsWith("2")){
          apiListScheduleHoliday(id: placeId, isClear: true);
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiDeleteScheduleHoliday(id: id, placeId: placeId);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiDeleteScheduleHoliday(id: id, placeId: placeId);
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiDeleteScheduleHoliday(id: id, placeId: placeId);
      });
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
