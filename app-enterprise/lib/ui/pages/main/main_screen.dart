import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/main/main_controller.dart';
import 'package:myarcher_enterprise/ui/shared/base_container.dart';
import 'package:myarcher_enterprise/ui/shared/modal_bottom.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class MainScreen extends StatefulWidget {
  final int? index;
  final String? from;
  const MainScreen({Key? key, this.index, this.from}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final controller = MainController();

  @override
  void initState() {
    controller.initController();
    if(widget.index != null) controller.setCurrentIndex(widget.index!);
    WidgetsBinding.instance.addPostFrameCallback((_) => afterInit());
    super.initState();
  }

  afterInit(){
    if(widget.from != null && widget.from == "register"){
      modalBottomDialog(title: Translator.congratsAccountCreated.tr, content: Translator.kuyRegisterVenueMu.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Obx(()=> Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: fontSize(10),
          selectedItemColor: AppColor.colorAccent,
          unselectedItemColor: AppColor.inactive,
          selectedLabelStyle: boldTextFont.copyWith(fontSize: fontSize(10)),
          unselectedLabelStyle: boldTextFont.copyWith(fontSize: fontSize(10)),
          onTap: (index) {
            controller.setCurrentIndex(index);
          },
          currentIndex: controller.currentIndex.value,
          items: [
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(Assets.icons.icHome, color: AppColor.colorAccent),
              icon: SvgPicture.asset(Assets.icons.icHome, color: AppColor.inactive),
              label: Translator.reservation.tr,
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(Assets.icons.icCalendar, color: AppColor.colorAccent),
              icon: SvgPicture.asset(Assets.icons.icCalendar, color: AppColor.inactive),
              label: Translator.schedule.tr,
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(Assets.icons.icOrder, color: AppColor.colorAccent),
              icon: SvgPicture.asset(Assets.icons.icOrder, color: AppColor.inactive),
              label: Translator.order.tr,
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(Assets.icons.icProfile, color: AppColor.colorAccent),
              icon: SvgPicture.asset(Assets.icons.icProfile, color: AppColor.inactive),
              label: Translator.profile.tr,
            ),
          ],
        ),
        body: controller.setCurrentPage(index: controller.currentIndex.value),
      )),
    );
  }
}
