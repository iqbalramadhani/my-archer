import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/edittext.dart';
import 'package:myarchery_archer/ui/shared/item_list.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/shimmer_loading.dart';

import '../../detail_event/detail_event_screen.dart';
import '../../event/my_event/my_event_screen.dart';
import 'event_controller.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  var _scrollController = ScrollController();
  var controller = EventController();
  RxBool show = true.obs;

  @override
  void initState() {
    _scrollController.addListener(() {

      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if(controller.currentPage.value < controller.totalPages.value){
          controller.currentPage.value += 1;
          controller.apiGetEventOrder();
        }
      }
    });

    controller.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Obx(()=> Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            child: controller.isLoading.value && controller.currentPage.value == 1 ? showShimmerList() :
            RefreshIndicator(child: Column(
              children: [
                hSpace(25),
                Expanded(child: AnimationLimiter(
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    itemCount: controller.events.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext c, int i) {
                      return AnimationConfiguration.staggeredList(
                        position: i,
                        delay: Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          horizontalOffset: 0,
                          verticalOffset: 300,
                          child: itemEventTab(controller.events[i], (){
                            goToPage(DetailEventScreen(event: controller.events[i],));
                          }),
                        ),
                      );
                    },
                  ),
                ), flex: 1,),
                if(controller.isLoading.value && controller.currentPage.value > 1) loading()
              ],
            ), onRefresh: refreshData),
            margin: EdgeInsets.only(top: hValue(55)),
          ),
          Container(
            child: Stack(
              children: [
                Container(
                  color: colorPrimary,
                  width: Get.width,
                  height: hValue(56),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(left: wValue(25), right: wValue(25), top: hValue(36)),
                  child: EditText(hintText: "Cari event", leftIcon: "assets/icons/ic_search.svg", controller: controller.searchTxtCtrl.value, borderColor: Colors.white, bgColor: Colors.white, radius: wValue(15),
                  onSubmit: (v){
                    controller.reloadData();
                  }),
                )
              ],
            ),
          ),
          Positioned(
            child: AnimatedOpacity(
              // If the widget is visible, animate to 0.0 (invisible).
              // If the widget is hidden, animate to 1.0 (fully visible).
              opacity: show.value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              // The green box must be a child of the AnimatedOpacity widget.
              child: InkWell(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(wValue(8))),
                  color: Color(0xFFE7EDF6),
                  child: Container(
                    padding: EdgeInsets.all(wValue(15)),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/ic_archer.svg"),
                        wSpace(10),
                        Expanded(child: Text("Event Saya", style: boldTextFont.copyWith(fontSize: fontSize(12), color: colorPrimary),), flex: 1,),
                        wSpace(10),
                        Icon(Icons.arrow_forward, color: colorPrimary,)
                      ],
                    ),
                    width: Get.width,
                  ),),
                onTap: (){
                  goToPage(MyEventScreen());
                },
              ),
            ),
            bottom: hValue(10),
            left: wValue(15),
            right: wValue(15),)
        ],
      )),
    );
  }


  Future refreshData() async {
    controller.reloadData();
  }

}
