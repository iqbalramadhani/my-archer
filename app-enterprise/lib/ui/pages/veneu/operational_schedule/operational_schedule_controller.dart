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
import 'package:myarcher_enterprise/core/models/objects/time_operational_model.dart';
import 'package:myarcher_enterprise/core/models/objects/venue_model.dart';
import 'package:myarcher_enterprise/core/models/picked_image.dart';
import 'package:myarcher_enterprise/core/models/picked_location.dart';
import 'package:myarcher_enterprise/core/models/responses/detail_venue_response.dart';
import 'package:myarcher_enterprise/core/models/responses/facility_response.dart';
import 'package:myarcher_enterprise/core/models/responses/operational_time_response.dart';
import 'package:myarcher_enterprise/core/services/api_services.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/shared/loading.dart';
import 'package:myarcher_enterprise/ui/shared/modal_bottom.dart';
import 'package:myarcher_enterprise/ui/shared/toast.dart';
import 'package:myarcher_enterprise/utils/endpoint.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class OperationalScheduleController extends GetxController {
  var box = GetStorage();
  var dio = ApiServices().launch();

  RxBool isLoading = false.obs;

  RxList<TimeOperationalModel> schedules = <TimeOperationalModel>[].obs;

  void apiAddScheduleOperational({required int id, required String day, required bool isOpen, String? openTime, String? closeTime, String? breakTime, String? endBreakTime, Function? onFinish}) async {
    loadingDialog();

    try{
      var body = {
        "place_id" : id,
        "day" : day,
        "open_time" : openTime == ""? null : openTime,
        "closed_time" : closeTime == "" ? null : closeTime,
        "start_break_time" :  breakTime == "" ? null : breakTime,
        "end_break_time" :  endBreakTime == "" ? null : endBreakTime,
        "is_open" : isOpen,
      };

      final resp = await dio.post(urlAddScheduleOperational, data: body);
      Get.back();
      checkLogin(resp);

      try {
        if(resp.statusCode.toString().startsWith("2")){
         if(onFinish != null) onFinish();
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiAddScheduleOperational(id: id, day: day, openTime: openTime, closeTime: closeTime, breakTime: breakTime, endBreakTime: endBreakTime,
            isOpen: isOpen);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiAddScheduleOperational(id: id, day: day, openTime: openTime, closeTime: closeTime, breakTime: breakTime, endBreakTime: endBreakTime,
              isOpen: isOpen);
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiAddScheduleOperational(id: id, day: day, openTime: openTime, closeTime: closeTime, breakTime: breakTime, endBreakTime: endBreakTime,
            isOpen: isOpen);
      });
    }
  }

  void apiUpdateScheduleOperational({required int id, required String day, required bool isOpen, bool? isDelete, String? openTime, String? closeTime, String? breakTime, String? endBreakTime, Function? onFinish}) async {
    loadingDialog();

    try{
      var body = {
        "id" : id,
        "day" : day,
        "open_time" : isDelete != null && isDelete ? null : openTime == ""? null : openTime,
        "closed_time" : isDelete != null && isDelete ? null : closeTime == "" ? null : closeTime,
        "start_break_time" : isDelete != null && isDelete ? null : breakTime == "" ? null : breakTime,
        "end_break_time" : isDelete != null && isDelete ? null : endBreakTime == "" ? null : endBreakTime,
        "is_open" : isDelete != null && isDelete ? true : isOpen,
      };

      final resp = await dio.post(urlUpdateScheduleOperational, data: body);
      Get.back();
      checkLogin(resp);

      try {
        if(resp.statusCode.toString().startsWith("2")){
          if(onFinish != null) onFinish();
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiAddScheduleOperational(id: id, day: day, openTime: openTime, closeTime: closeTime, breakTime: breakTime, endBreakTime: endBreakTime,
                isOpen: isOpen);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiAddScheduleOperational(id: id, day: day, openTime: openTime, closeTime: closeTime, breakTime: breakTime, endBreakTime: endBreakTime,
              isOpen: isOpen);
        });
      }
    }catch(_){
      Get.back();
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiAddScheduleOperational(id: id, day: day, openTime: openTime, closeTime: closeTime, breakTime: breakTime, endBreakTime: endBreakTime,
            isOpen: isOpen);
      });
    }
  }

  void apiListScheduleOperational({required int id, bool? isClear, Function? onFinish}) async {
    if(isClear != null && isClear){
      schedules.clear();
    }
    isLoading.value = true;

    try{
      var param = {
        "place_id" : id,
      };

      final resp = await dio.get(urlListScheduleOperational, queryParameters: param);
      isLoading.value = false;
      checkLogin(resp);

      try {
        OperationalTimeResponse response = OperationalTimeResponse.fromJson(resp.data);
        if(resp.statusCode.toString().startsWith("2")){
          schedules.addAll(response.data!);
          if(onFinish != null){
            onFinish(response);
          }
        }else{
          showDialogError(msg: getErrorMessage(resp), onPosClick: (){
            apiListScheduleOperational(id: id, onFinish: onFinish);
          });
        }
      } catch (_) {
        var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
        showDialogError(msg: msg, onPosClick: (){
          apiListScheduleOperational(id: id, onFinish: onFinish);
        });
      }
    }catch(_){
      isLoading.value = false;
      var msg = (kDebugMode) ? "Terjadi kesalahan. Harap ulangi kembali ${_.toString()}" : "Terjadi kesalahan. Harap ulangi kembali";
      showDialogError(msg: msg, onPosClick: (){
        apiListScheduleOperational(id: id, onFinish: onFinish);
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
