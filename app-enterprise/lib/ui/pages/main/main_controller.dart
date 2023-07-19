import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myarcher_enterprise/ui/pages/main/home/home_screen.dart';
import 'package:myarcher_enterprise/ui/pages/main/order/order_screen.dart';
import 'package:myarcher_enterprise/ui/pages/main/profile/profile_screen.dart';
import 'package:myarcher_enterprise/ui/pages/main/schedule/schedule_screen.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  var box = GetStorage();

  initController(){

  }

  void setCurrentIndex(int index) async{
    currentIndex.value = index;
  }

  setCurrentPage({required int index}){
    if(index ==0){
      return HomeScreen();
    }else if(index == 1){
      return ScheduleScreen();
    }else if(index == 2){
      return OrderScreen();
    }else if(index == 3){
      return ProfileScreen();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}