import 'package:fbroadcast_nullsafety/fbroadcast_nullsafety.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarchery_archer/ui/pages/main/profile/profile_screen.dart';

import 'event/event_screen.dart';
import 'home_screen/home_screen.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  var box = GetStorage();

  initController(){
    FBroadcast.instance()!.register("change_tab", (value, callback) {
      print("change tab");
      setCurrentIndex(value);
      setCurrentPage(index: value);
    });
  }

  void setCurrentIndex(int index) async{
    currentIndex.value = index;
  }

  setCurrentPage({required int index}){
    if(index ==0){
      return HomeScreen();
    }else if(index == 1){
      return EventScreen();
    }else if(index == 2){
      return ProfileScreen();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}