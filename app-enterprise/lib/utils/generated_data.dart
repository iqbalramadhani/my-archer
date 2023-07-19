import 'package:get/get.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class GeneratedData{
  List<String> sourceInformation(){
    List<String> data = <String>[];
    data.add("Kerabat");
    data.add("Keluarga");
    data.add("Youtube");
    data.add("Instagram");
    data.add("Lainnya");

    return data;
  }

  List<String> actionsOtherFacility(){
    List<String> data = <String>[];
    data.add(Translator.editFacility.tr);
    data.add(Translator.deleteFacility.tr);

    return data;
  }

  List<String> actionChooseImage(){
    List<String> data = <String>[];
    data.add(Translator.captureFromCamera.tr);
    data.add(Translator.chooseFromGallery.tr);

    return data;
  }

  List<String> actionVenue({required int status}){
    List<String> data = <String>[];
    if(status == StatusVenue.draft){
      data.add(Translator.deleteDraftField.tr);
    }
    data.add(Translator.nonActiveField.tr);

    return data;
  }

  List<String> actionDistance(){
    List<String> data = <String>[];
    data.add(Translator.editDistance.tr);
    data.add(Translator.deleteDistance.tr);

    return data;
  }
}