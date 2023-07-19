import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/appbar.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/item_list.dart';
import 'package:myarchery_archer/ui/shared/shimmer_loading.dart';
import 'package:myarchery_archer/utils/translator.dart';

import '../detail_my_event_category/detail_my_event_category_screen.dart';
import 'detail_my_event_controller.dart';

class DetailMyEventScreen extends StatefulWidget {
  final int eventId;
  const DetailMyEventScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  _DetailMyEventScreenState createState() => _DetailMyEventScreenState();
}

class _DetailMyEventScreenState extends State<DetailMyEventScreen> {
  var controller = DetailMyEventController();

  @override
  void initState() {
    controller.idEvent.value = widget.eventId;
    controller.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Container(
        color: colorPrimary,
        child: SafeArea(
          child: Scaffold(
            appBar: appBar(Translator.myEvent.tr, (){
              Get.back();
            }),
            body: Obx(()=> Column(
              children: [
                //TODO call status view later
                hSpace(15),
                controller.isLoading.value ? showShimmerList() : Expanded(child: controller.datas.isEmpty ? viewEmpty() : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Padding(
                    padding: EdgeInsets.all(wValue(15)),
                    child: Column(
                      children: [
                        for(var item in controller.datas) itemDetailMyEvent(controller.eventDetail.value, item, (){
                          goToPage(DetailMyEventCategoryScreen(category:item, event: controller.eventDetail.value, ));
                        })
                      ],
                    ),
                  ),
                ), flex: 1,)
              ],
            )),
          ),
        ),
      ),
    );
  }

  viewListStatus(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hSpace(15),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              wSpace(15),
              for(var item in controller.statusPayments) itemStatusPayment(item, controller.selectedStatus.value.id == item.id, (){
                controller.selectedStatus.value = item;
                // controller.orders.clear();
                // controller.apiGetListOrder();
              }),
              wSpace(15),
            ],
          ),
        )
      ],
    );
  }
}
