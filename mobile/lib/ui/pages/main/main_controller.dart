
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/utils/global_helper.dart';
import 'package:my_archery/utils/key_storage.dart';

import '../login/login_screen.dart';

class MainController extends GetxController {
  var box = GetStorage();

  var selectedMenu = 0.obs;

  initController() async {

  }

  logoutAction(){
    box.write(KEY_TOKEN, null);
    box.write(KEY_SCORE, null);
    box.write(KEY_SCORE_ELIMINATION, null);
    box.write(KEY_ADD_PARTICIPANT, false);
    goToPage(LoginScreen(), dismissAllPage: true);
  }

  setValueKeyParticipant(value){
    box.write(KEY_ADD_PARTICIPANT, value);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
