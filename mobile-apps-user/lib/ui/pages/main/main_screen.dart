import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';

import 'main_controller.dart';

class MainScreen extends StatefulWidget {
  final int? index;
  const MainScreen({Key? key, this.index}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  var _mainController = MainController();

  @override
  void initState() {
    _mainController.initController();
    if(widget.index != null) _mainController.setCurrentIndex(widget.index!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorAccent,
      child: BaseContainer(
          child: SafeArea(
            child: Obx(()=> Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: fontSize(10),
                selectedItemColor: colorAccent,
                unselectedItemColor: inactive,
                selectedLabelStyle: boldTextFont.copyWith(fontSize: fontSize(10)),
                unselectedLabelStyle: boldTextFont.copyWith(fontSize: fontSize(10)),
                onTap: (index) {
                  _mainController.setCurrentIndex(index);
                },
                currentIndex: _mainController.currentIndex.value, // this will be set when a new tab is tapped
                items: [
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset("assets/icons/ic_home.svg", color: colorAccent),
                    icon: SvgPicture.asset("assets/icons/ic_home.svg", color: inactive),
                    label: 'home'.tr,
                    // title: new Text('home'.tr, style: boldTextFont.copyWith(fontSize: fontSize(10),
                    // color: (_mainController.currentIndex.value == 0) ? colorAccent : inactive)),
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset("assets/icons/ic_event.svg", color: colorAccent),
                    icon: SvgPicture.asset("assets/icons/ic_event.svg", color: inactive),
                    label: 'event'.tr,
                    // title: new Text('event'.tr, style: boldTextFont.copyWith(fontSize: fontSize(10), color: (_mainController.currentIndex.value == 1) ? colorAccent : inactive)),
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset("assets/icons/ic_user.svg", color: colorAccent),
                    icon: SvgPicture.asset("assets/icons/ic_user.svg", color: inactive),
                    label: 'profile'.tr,
                    // title: new Text('profile'.tr, style: boldTextFont.copyWith(fontSize: fontSize(10), color: (_mainController.currentIndex.value == 2) ? colorAccent : inactive)),
                  ),
                ],
              ),
              body: _mainController.setCurrentPage(index: _mainController.currentIndex.value),
            )),
          ),
      ),
    );
  }
}
