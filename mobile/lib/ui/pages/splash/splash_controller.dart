import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_archery/ui/pages/scoring/elimination/scoresheet/scoresheet_elimination_screen.dart';
import 'package:my_archery/utils/key_storage.dart';

import '../../../core/models/saved_scoresheet_model.dart';
import '../login/login_controller.dart';
import '../main/main_screen.dart';
import '../scoring/qualification/sheet/scoresheet_qualification_screen.dart';

class SplashController extends GetxController {
  var box = GetStorage();
  RxList<SavedScoresheetModel> savedArcherData = <SavedScoresheetModel>[].obs;
  var loginController = LoginController();

  initController() async {
    box.write(KEY_ADD_PARTICIPANT, false);

    //check if data local score is empty and set into null
    if (box.read(KEY_SCORE) != null) {
      if (box.read(KEY_SCORE).toString() == "[]") {
        box.write(KEY_SCORE, null);
      }
    }

    // savedArcherData.addAll(ScoreDb().readLocalQualificationScores());
    nextPage();
  }

  void nextPage() {
    var duration = const Duration(seconds: 2);
    Timer(duration, () {
      if (box.read(KEY_TOKEN) == null) {
        // Get.offAll(LoginScreen());
        loginController.apiLogin();
      } else if (box.read(KEY_SCORE) != null) {
        Get.offAll(ScoresheetQualificationScreen());
      }else if (box.read(KEY_SCORE_ELIMINATION) != null) {
        Get.offAll(ScoresheetEliminationScreen());
      } else {
        Get.offAll(MainScreen());
      }
    });
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
