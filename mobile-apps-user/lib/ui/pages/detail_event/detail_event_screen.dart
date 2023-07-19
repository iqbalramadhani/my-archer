import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/ui/pages/official/register_official/register_official_screen.dart';
import 'package:myarchery_archer/ui/pages/webview/webview_screen.dart';
import 'package:myarchery_archer/utils/endpoint.dart';
import 'package:myarchery_archer/utils/theme.dart';
import 'package:myarchery_archer/gen/assets.gen.dart';
import 'package:myarchery_archer/utils/global_helper.dart';
import 'package:myarchery_archer/utils/spacing.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/ui/shared/button.dart';
import 'package:myarchery_archer/ui/shared/item_list.dart';
import 'package:myarchery_archer/ui/shared/loading.dart';
import 'package:myarchery_archer/ui/shared/shimmer_loading.dart';
import 'package:myarchery_archer/utils/translator.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/models/objects/event_model.dart';
import '../fullscreen_image/fullscreen_image_screen.dart';
import '../register_event/register_event_screen.dart';
import 'detail_event_controller.dart';

class DetailEventScreen extends StatefulWidget {
  final EventModel event;
  const DetailEventScreen({Key? key, required this.event}) : super(key: key);

  @override
  _DetailEventScreenState createState() => _DetailEventScreenState();
}

class _DetailEventScreenState extends State<DetailEventScreen> {

  var controller = DetailEventController();

  @override
  void initState() {
    controller.currentEvent.value = widget.event;
    controller.initController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: BaseContainer(
        child: Obx(()=> SafeArea(
            child: Scaffold(
              backgroundColor: bgPage,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: [
                        Hero(tag: widget.event.id!, child: InkWell(
                          child: Image.network("${widget.event.poster}", width: Get.width, fit: BoxFit.fitWidth,),
                          onTap: (){
                            goToPage(FullscreenImageScreen(image: "${widget.event.poster}"));
                          },
                        )),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              hSpace(15),
                              Container(
                                color: Colors.white,
                                width: Get.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(wValue(20)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          labelView("${widget.event.eventCompetition!}", gray600, orange300, padding: EdgeInsets.only(left: wValue(10), right: wValue(10), top: wValue(5), bottom: wValue(5))),
                                          hSpace(10),
                                          Text("${widget.event.eventName}", style: boldTextFont.copyWith(fontSize: fontSize(18), color: colorAccent),),
                                          hSpace(5),
                                          Text("${Translator.by.tr} ${controller.currentEventResponse.value.data?.detailAdmin!.name}", style: regularTextFont.copyWith(fontSize: fontSize(12), color: gray600),),
                                          hSpace(5),
                                          Divider(),
                                          hSpace(10),
                                          Row(
                                            children: [
                                              SvgPicture.asset(Assets.icons.icDateRadius),
                                              wSpace(10),
                                              Text("${convertDateFormat("yyyy-MM-dd", "dd MMM yyyy", widget.event.eventStartDatetime!)} - ${convertDateFormat("yyyy-MM-dd", "dd MMM yyyy", widget.event.eventEndDatetime!)}", style: boldTextFont.copyWith(fontSize: fontSize(14)),),
                                            ],
                                          ),
                                          hSpace(10),
                                          Row(
                                            children: [
                                              SvgPicture.asset(Assets.icons.icLocationRadius),
                                              wSpace(10),
                                              Expanded(child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${widget.event.location}", style: boldTextFont.copyWith(fontSize: fontSize(14)),),
                                                  if(widget.event.detailCity?.name != null) Container(
                                                    child: Text("${widget.event.detailCity?.name}", style: regularTextFont.copyWith(fontSize: fontSize(12)),),
                                                    margin: EdgeInsets.only(top: hValue(3)),
                                                  ),
                                                ],
                                              ), flex: 1,)
                                            ],
                                          ),
                                          hSpace(10),
                                          Divider(),
                                        ],
                                      ),
                                    ),
                                    viewKategoriLomba(),
                                    hSpace(15),
                                  ],
                                ),
                              ),
                              hSpace(15),
                              viewRegistrationFee(),
                              viewHandbookAndKlasemen(),
                              hSpace(15),
                              viewDescription(),
                              viewFAQ(),
                              hSpace(10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(wValue(15)),
                    child: InkWell(
                      child: SimpleShadow(
                        child: SvgPicture.asset(Assets.icons.icBackCircle),
                        opacity: 0.6,
                        color: Colors.black.withAlpha(60),
                        offset: Offset(5, 5),
                        sigma: 7,
                      ),
                      onTap: (){
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ))),
      ),
    );
  }

  viewKategoriLomba(){
    return controller.categories.isEmpty ? showShimmerList() : Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: wValue(15), right: wValue(15)),
          width: Get.width,
          padding: EdgeInsets.only(top: wValue(10), bottom: wValue(10)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFE7EDF6),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                wSpace(15),
                for(int i = 0; i < controller.mastercategoryRegister.length; i++) InkWell(
                  child: Container(
                    margin: EdgeInsets.only(right: wValue(15)),
                    child: Column(
                      children: [
                        Text("${controller.mastercategoryRegister[i].name}", style: boldTextFont.copyWith(fontSize: fontSize(12), color: (controller.selectedCategory.value == i) ? colorPrimary : Color(0xFF90AAD4),)),
                        if(controller.selectedCategory.value == i) Container(
                          margin: EdgeInsets.only(top: hValue(5)),
                          color: colorSecondary,
                          height: hValue(2),
                          width: wValue(50),
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    controller.selectedCategory.value = i;
                    controller.classBySelectedCategory.clear();
                    for(var item in controller.mastercategoryRegister[i].classCategory!){
                      if(!controller.classBySelectedCategory.any((element) => element == item)){
                        controller.classBySelectedCategory.add(item);
                      }
                    }
                    controller.selectedClassByCategory.value = 0;
                    controller.getCurrentCategory();
                  },
                ),
                wSpace(15),
              ],
            ),
          ),
        ),
        hSpace(15),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              wSpace(15),
              for(int i = 0; i < controller.classBySelectedCategory.length; i++)  Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: (controller.selectedClassByCategory.value == i) ? colorSecondary : Colors.white),
                  borderRadius: BorderRadius.circular(8),
                  color: (controller.selectedClassByCategory.value == i) ? Color(0xFFFFF8E9) : Colors.white,
                ),
                margin: EdgeInsets.only(right: wValue(15)),
                padding: EdgeInsets.all(wValue(5)),
                child: InkWell(
                  child: Text("${controller.classBySelectedCategory[i]}", style: boldTextFont.copyWith(fontSize: fontSize(12), color: (controller.selectedClassByCategory.value == i) ? colorSecondary : gray600)),
                  onTap: (){
                    controller.visibleKuota.value = false;
                    controller.selectedClassByCategory.value= i;
                    controller.getCurrentCategory();
                    Timer(Duration(milliseconds: 300), () {
                      controller.visibleKuota.value = true;
                    });
                  },
                ),
              ),
              wSpace(15),
            ],
          ),
        ),
        hSpace(10),
        Container(
          margin: EdgeInsets.only(left: wValue(15), right: wValue(15)),
          width: Get.width,
          padding: EdgeInsets.only(top: wValue(10), bottom: wValue(10)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: gray50,
          ),
          child: Text(Translator.availableQuota.tr, style: boldTextFont.copyWith(fontSize: fontSize(14), color: colorPrimary), textAlign: TextAlign.center,),
        ),
        hSpace(10),
        AnimatedOpacity(
          opacity: controller.visibleKuota.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.5,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24, right: 24),
          children: [
            for(var item in controller.categoryByClassAndCategory) Container(
              padding: EdgeInsets.all(wValue(5)),
              child: Column(
                children: [
                  Text(convertTeamCategory(item.teamCategoryId!), style: boldTextFont.copyWith(fontSize: fontSize(10), color: colorPrimary), textAlign: TextAlign.center,),
                  hSpace(5),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xFFEFF2F7)),
                      borderRadius: BorderRadius.circular(8),
                      color: green200,
                    ),
                    padding: EdgeInsets.all(wValue(5)),
                    child: Text("${Translator.available.tr} : ${item.quota! - item.totalParticipant!}/${item.quota}", style: regularTextFont.copyWith(fontSize: fontSize(9)),),
                  )
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xFFEFF2F7)),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
            )
          ],
        ),),
      ],
    );
  }

  viewDescription(){
    return Container(
      color: Colors.white,
      width: Get.width,
      margin: EdgeInsets.only(bottom: hValue(15)),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: Row(
          children: [
            SvgPicture.asset(Assets.icons.icFile),
            wSpace(5),
            Text(Translator.description.tr, style: boldTextFont.copyWith(fontSize: fontSize(16), color: gray600),)
          ],
        ),
        children: [
          controller.isLoading.value ? showShimmerList() : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Translator.description.tr, style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                hSpace(10),
                Text(controller.currentEventResponse.value.data!.description ?? Translator.noDescription.tr, style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black),),
                hSpace(10),
                for(var item in controller.currentEventResponse.value.data!.moreInformation!) Container(
                  margin: EdgeInsets.only(bottom: hValue(15)),
                  color: Colors.white,
                  width: Get.width,
                  padding: EdgeInsets.all(wValue(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${item.title}", style: boldTextFont.copyWith(fontSize: fontSize(16), color: Colors.black),),
                      hSpace(10),
                      Text("${item.description}", style: regularTextFont.copyWith(fontSize: fontSize(12), color: Colors.black),),
                    ],
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.only(left: wValue(15), right: wValue(15), bottom: wValue(15)),
          ),
        ],
      ),
    );
  }

  viewFAQ(){
    return controller.isLoadingFaq.value ? showShimmerList() : Container(
      color: Colors.white,
      width: Get.width,
      margin: EdgeInsets.only(bottom: hValue(15)),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: Row(
          children: [
            SvgPicture.asset(Assets.icons.icFile),
            wSpace(5),
            Text("FAQ", style: boldTextFont.copyWith(fontSize: fontSize(16), color: gray600),)
          ],
        ),
        children: [
          if(controller.faqResponse.value.data != null) Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Translator.faq.tr, style: boldTextFont.copyWith(fontSize: fontSize(14), color: Colors.black),),
                hSpace(25),
                if(controller.faqResponse.value.data!.isNotEmpty) for(var item in controller.faqResponse.value.data!) Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${item.question}", style: boldTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.start,),
                      hSpace(10),
                      Text("${item.answer}", style: regularTextFont.copyWith(fontSize: fontSize(14)), textAlign: TextAlign.start,),
                      hSpace(20)
                    ],
                  ),
                )
              ],
            ),
            margin: EdgeInsets.only(left: wValue(15), right: wValue(15), bottom: wValue(15)),
          ),
        ],
      ),
    );
  }

  viewRegistrationFee(){
    return Container(
      color: Colors.white,
      width: Get.width,
      margin: EdgeInsets.only(bottom: hValue(15)),
      padding: EdgeInsets.all(wValue(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translator.registerFee.tr, style: boldTextFont.copyWith(fontSize: fontSize(16), color: Colors.black),),
          hSpace(10),
          // for(var item in controller.specificCategoryRegister) itemRegistrationFeeNew(item),
          Row(
            children: [
              for(var item in controller.dataEventPrice) itemRegistrationFeeNew(item)
            ],
          ),
          (!controller.dataEventPrice.any((element) => element.isEarlyBird == 1)) ? Container(
            child: Text("${Translator.registerYourselfsoon.tr} ${widget.event.eventName}", style: regularTextFont.copyWith(color: Colors.black, fontSize: fontSize(12))) ,
            margin: EdgeInsets.only(bottom: hValue(10)),
          ) : showEarlyBirdNote(),
          hSpace(10),
          viewCountdown()
        ],
      ),
    );
  }

  showEarlyBirdNote(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(var item in controller.dataEventPrice) if(item.isEarlyBird == 1) Container(
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
                text: '${Translator.earlyBirdUntil.tr}, ${convertDateFormat("yyyy-MM-dd HH:mm:ss", "dd MMM yyyy", item.endDateEarlyBird ?? DateTime.now().toString())} ',
                style: boldTextFont.copyWith(color: gray600, fontSize: fontSize(12)),
                children: <TextSpan>[
                  TextSpan(text: "| ${Translator.registerYourselfsoon.tr} ${widget.event.eventName}", style: regularTextFont.copyWith(color: Colors.black, fontSize: fontSize(12))),
                ]
            ),
          ),
          margin: EdgeInsets.only(bottom: hValue(10)),
        )
      ],
    );
  }
  
  viewHandbookAndKlasemen(){
    return Container(
      margin: EdgeInsets.only(left: wValue(15), right: wValue(15)),
      child: Column(
        children: [
          if(controller.currentEventResponse.value.data?.handbook != null && controller.currentEventResponse.value.data!.handbook!.isNotEmpty) InkWell(
            child: Assets.img.imgHandbook.image(),
            onTap: (){
              launchURL(controller.currentEventResponse.value.data?.handbook ?? "");
            },
          ),
          hSpace(10),
          InkWell(
            child: Assets.img.imgKlasemen.image(),
            onTap: (){
              // generalToast(msg: "Coming Soon");
              Get.to(()=> WebviewScreen(title: "${Translator.liveScore.tr} ${widget.event.eventName!}", url: "$urlLiveScore${widget.event.eventSlug!}/qualification"));
            },
          ),
          hSpace(10),
          if(controller.isOfficial.value) InkWell(
            child: Assets.img.imgOfficial.image(),
            onTap: (){
              goToPage(RegisterOfficialScreen(event: widget.event, official: controller.officialModel.value,));
            },
          ),
        ],
      ),
    );
  }

  viewCountdown(){
    return Column(
      children: [
        controller.isLoading.value ? loading() : controller.isExpired.value ? Text(Translator.expired.tr) : CountdownTimer(
          endTime : convertDateFormatIntoTimestamp("yyyy-MM-dd HH:mm:ss", controller.currentEventResponse.value.data!.eventStartDatetime!),
          widgetBuilder: (_, time){
            return Row(
              children: [
                Expanded(child: Container(
                  padding: EdgeInsets.all(wValue(5)),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xFFEFF2F7)),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text("${time!.days}"),
                      labelView(Translator.day.tr, Colors.black, Color(0xFFEFF2F7), isBold: false)
                    ],
                  ),
                ), flex: 1,),
                wSpace(10),
                Expanded(child: Container(
                  padding: EdgeInsets.all(wValue(5)),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xFFEFF2F7)),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text("${time.hours}"),
                      labelView(Translator.hour.tr, Colors.black, Color(0xFFEFF2F7), isBold: false)
                    ],
                  ),
                ), flex: 1,),
                wSpace(10),
                Expanded(child: Container(
                  padding: EdgeInsets.all(wValue(5)),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xFFEFF2F7)),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text("${time.min}"),
                      labelView(Translator.minute.tr, Colors.black, Color(0xFFEFF2F7), isBold: false)
                    ],
                  ),
                ), flex: 1,),
                wSpace(10),
                Expanded(child: Container(
                  padding: EdgeInsets.all(wValue(5)),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xFFEFF2F7)),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text("${time.sec}"),
                      labelView(Translator.second.tr, Colors.black, Color(0xFFEFF2F7), isBold: false)
                    ],
                  ),
                ), flex: 1,),
              ],
            );
          },
        ),
        hSpace(10),
        Button(Translator.registerEvent.tr, controller.isExpired.value ? Colors.grey : colorPrimary, controller.isLoading.value ? false : controller.isExpired.value ? false : true, (){
          goToPage(RegisterEvent(data: widget.event));
        })
      ],
    );
  }

  viewCardCountdown(){
    return Container(
      margin : EdgeInsets.all(wValue(10)),
      padding: EdgeInsets.all(wValue(15)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            blurRadius: 10.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: Column(
        children: [
          controller.isLoading.value ? loading() : controller.isExpired.value ? Text(Translator.expired.tr, style: regularTextFont,) : CountdownTimer(
            endTime : convertDateFormatIntoTimestamp("yyyy-MM-dd HH:mm:ss", controller.currentEventResponse.value.data!.eventStartDatetime!),
            widgetBuilder: (_, time){
              return Row(
                children: [
                  Expanded(child: Container(
                    padding: EdgeInsets.all(wValue(5)),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xFFEFF2F7)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text("${time!.days}"),
                        labelView(Translator.day.tr, Colors.black, Color(0xFFEFF2F7), isBold: false)
                      ],
                    ),
                  ), flex: 1,),
                  wSpace(10),
                  Expanded(child: Container(
                    padding: EdgeInsets.all(wValue(5)),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xFFEFF2F7)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text("${time.hours}"),
                        labelView(Translator.hour.tr, Colors.black, Color(0xFFEFF2F7), isBold: false)
                      ],
                    ),
                  ), flex: 1,),
                  wSpace(10),
                  Expanded(child: Container(
                    padding: EdgeInsets.all(wValue(5)),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xFFEFF2F7)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text("${time.min}"),
                        labelView(Translator.minute.tr, Colors.black, Color(0xFFEFF2F7), isBold: false)
                      ],
                    ),
                  ), flex: 1,),
                  wSpace(10),
                  Expanded(child: Container(
                    padding: EdgeInsets.all(wValue(5)),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xFFEFF2F7)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text("${time.sec}"),
                        labelView(Translator.second.tr, Colors.black, Color(0xFFEFF2F7), isBold: false)
                      ],
                    ),
                  ), flex: 1,),
                ],
              );
            },
          ),
          hSpace(10),
          VisibilityDetector(key: Key('ic_back'),
              child: Button(Translator.registerEvent.tr, controller.isExpired.value ? Colors.grey : colorPrimary, controller.isLoading.value ? false : controller.isExpired.value ? false : true, (){
                goToPage(RegisterEvent(data: widget.event));
              }),
              onVisibilityChanged: (_){
                if(_.visibleBounds.right == 0 && _.visibleBounds.bottom == 0){
                  print("visibility true ==> $_");
                  controller.isAppBarStick.value = true;
                }else{
                  controller.isAppBarStick.value = false;
                  print("visibility false ==> $_");
                }
              }),
          hSpace(10),
          Button(Translator.liveScore.tr, Colors.white, true, (){
            Get.to(()=> WebviewScreen(title: "${Translator.liveScore.tr} ${widget.event.eventName!}", url: "$urlLiveScore${widget.event.eventSlug!}/qualification"));
          }, fontColor: colorPrimary, borderColor: colorPrimary),
        ],
      ),
    );
  }
}
