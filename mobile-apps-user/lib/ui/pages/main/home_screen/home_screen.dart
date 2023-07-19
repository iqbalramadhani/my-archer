import 'package:fbroadcast_nullsafety/fbroadcast_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/ui/pages/main/profile/profile_controller.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/edittext.dart';
import 'package:myarchery_archer/ui/shared/item_list.dart';
import 'package:myarchery_archer/ui/shared/shimmer_loading.dart';
import 'package:myarchery_archer/ui/shared/toast.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../gen/assets.gen.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = HomeController();
  var profileController = ProfileController();

  @override
  void initState() {
    controller.initController();
    profileController.apiProfile(onFinish: () {
      controller.getCurrentUser();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorAccent,
        child: SafeArea(
            child: Obx(() => Scaffold(
                  backgroundColor: formInactive,
                  body: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            viewHeader(),
                            viewEvent(),
                            viewTransaksi(),
                          ],
                        ),
                      ),
                      if (controller.isHeaderHide.value) viewHeaderCollapse()
                    ],
                  ),
                ))));
  }

  viewHeader() {
    return Container(
      margin: EdgeInsets.all(0),
      color: colorAccent,
      child: Stack(
        children: [
          Assets.img.bgHeader.image(width: Get.width,
            height: hValue(160),
            fit: BoxFit.fill),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hSpace(36),
                Image.asset(
                  "assets/img/ic_logo_white.png",
                  width: wValue(50),
                ),
                hSpace(15),
                Text(
                  "Selamat Datang,",
                  style: regularTextFont.copyWith(
                      fontSize: fontSize(14), color: Colors.white),
                ),
                hSpace(5),
                VisibilityDetector(
                    key: Key('title'),
                    child: Text(
                      "${controller.user.value.name}",
                      style: boldTextFont.copyWith(
                          fontSize: fontSize(14), color: Colors.white),
                    ),
                    onVisibilityChanged: (_) {
                      if (_.visibleBounds.right == 0 &&
                          _.visibleBounds.bottom == 0) {
                        controller.isHeaderHide.value = true;
                      } else {
                        controller.isHeaderHide.value = false;
                      }
                    }),
                hSpace(20),
                EditText(
                    bgColor: Colors.white,
                    radius: wValue(15),
                    readOnly: true,
                    onClick: (){
                      FBroadcast.instance()!
                          .broadcast("change_tab", value: 1);
                    },
                    borderColor: Colors.white,
                    leftIcon: "assets/icons/ic_search.svg",
                    hintText: "Cari event")
              ],
            ),
            margin: EdgeInsets.only(left: wValue(15), right: wValue(15)),
          ),
        ],
      ),
      height: hValue(190),
    );
  }

  viewHeaderCollapse() {
    return Container(
      color: colorAccent,
      child: Stack(
        children: [
          Image.asset(
            "assets/img/bg_header.png",
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Container(
            child: EditText(
                bgColor: Colors.white,
                radius: wValue(15),
                borderColor: Colors.white,
                leftIcon: "assets/icons/ic_search.svg",
                hintText: "Cari event, latihan dll ..."),
            margin: EdgeInsets.only(
                left: wValue(15),
                right: wValue(15),
                bottom: wValue(10),
                top: wValue(25)),
          ),
        ],
      ),
      height: hValue(70),
    );
  }

  viewEvent() {
    return Container(
      margin: EdgeInsets.all(0),
      child: Stack(
        children: [
          Container(
            width: Get.width,
            color: controller.isHeaderHide.value ? formInactive : colorAccent,
            height: hValue(100),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(wValue(15)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Event terbaru",
                          style: boldTextFont.copyWith(
                              fontSize: fontSize(20),
                              color: controller.isHeaderHide.value
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        flex: 1,
                      ),
                      InkWell(
                        child: Text("Lihat Semua",
                            style: regularTextFont.copyWith(
                                fontSize: fontSize(14),
                                color: controller.isHeaderHide.value
                                    ? colorAccent
                                    : colorSecondary)),
                        onTap: () {
                          FBroadcast.instance()!
                              .broadcast("change_tab", value: 1);
                        },
                      ),
                    ],
                  ),
                ),
                controller.loadingEventOrder.value
                    ? showShimmerMenu()
                    : Container(
                        child: AnimationLimiter(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: controller.events.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext c, int i) {
                              return AnimationConfiguration.staggeredList(
                                position: i,
                                delay: Duration(milliseconds: 100),
                                child: SlideAnimation(
                                  duration: Duration(milliseconds: 3000),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  horizontalOffset: 300,
                                  verticalOffset: 0,
                                  child: itemEvent(controller.events[i]),
                                ),
                              );
                            },
                          ),
                        ),
                        height: hValue(270),
                      ),
              ],
            ),
            // margin: EdgeInsets.all(wValue(15)),
          )
        ],
      ),
    );
  }

  viewTransaksi() {
    return Container(
      margin: EdgeInsets.only(
          left: wValue(15), right: wValue(15), bottom: wValue(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hSpace(10),
          Text(
            "Latihan",
            style: boldTextFont.copyWith(
                fontSize: fontSize(20), color: Colors.black),
          ),
          hSpace(8),
          Container(
            width: Get.width,
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  blurRadius: 5.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: Offset(
                    1.0, // Move to right 10  horizontally
                    1.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: InkWell(
              child: Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(wValue(8))),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
                        child: Image.asset(
                          "assets/img/img_latihan.png",
                          height: hValue(120),
                          width: Get.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(wValue(8)),
                ),
              ),
              onTap: () {
                generalToast(msg: "Coming Soon...");
              },
            ),
          )
        ],
      ),
    );
  }
}
