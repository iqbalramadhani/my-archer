import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/core/controllers/profile_controller.dart';
import 'package:myarcher_enterprise/core/models/objects/venue_model.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/pages/main/home/home_controller.dart';
import 'package:myarcher_enterprise/ui/pages/veneu/add_veneu/add_veneu_screen.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/ui/shared/dialog.dart';
import 'package:myarcher_enterprise/ui/shared/item/item_venue.dart';
import 'package:myarcher_enterprise/ui/shared/modal/modal_bottom_two_actions.dart';
import 'package:myarcher_enterprise/ui/shared/modal_bottom.dart';
import 'package:myarcher_enterprise/ui/shared/shimmer_loading.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/generated_data.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = HomeController();
  var profileController = ProfileController();

  @override
  void initState() {
    controller.initController();

    if(controller.user.value.id == null){
      profileController.apiGetProfile(onFinish: (){
        controller.getCurrentUser();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: _viewMainContent(),
      ),
    );
  }

  _viewMainContent(){
    return Column(
      children: [
        Container(
          height: hValue(46),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
            color: AppColor.colorPrimary,
          ),
          padding: EdgeInsets.all(wValue(15)),
          child: Row(
            children: [
                Expanded(flex: 1,child: Obx(()=> Text("Halo, ${controller.user.value.name}", style: textBaseBold.copyWith(color: Colors.white),)),),
                Row(
                children: [
                  InkWell(
                    child: SvgPicture.asset(Assets.icons.icAddSquare, color: Colors.white, height: wValue(24),),
                    onTap: () async {
                      final result = await Navigator.push(
                        Get.context!,
                        MaterialPageRoute(builder: (context) => const AddVeneuScreen()),
                      );

                      if(result  != null){
                        controller.apiGetListVenue(isClear: true);
                      }
                    },
                  ),
                  wSpace(10),
                  SvgPicture.asset(Assets.icons.icSearch, color: Colors.white, height: wValue(24),),
                  wSpace(10),
                  SvgPicture.asset(Assets.icons.icNotification, height: wValue(24),),
                ],
              )
            ],
          ),
        ),
        Obx(()=> Expanded(child: controller.isLoading.value ? showShimmerList() : controller.venues.isEmpty ? _viewEmptyField() : _viewVenuesList(), flex: 1,))
      ],
    );
  }

  _viewEmptyField(){
    return Padding(
      padding: EdgeInsets.all(wValue(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.images.imgArcher),
          hSpace(5),
          Text(Translator.noField.tr, style: textLgBold,),
          hSpace(5),
          Text(Translator.kuyAddField.tr, style: textSmRegular, textAlign: TextAlign.center,),
          hSpace(15),
          SizedBox(
            width: wValue(181),
            height: hValue(36),
            child: Button(title: Translator.addField.tr, color: AppColor.colorPrimary, enable: true, onClick: () async {
              final result = await Navigator.push(
                Get.context!,
                MaterialPageRoute(builder: (context) => const AddVeneuScreen()),
              );

              if(result  != null){
                controller.apiGetListVenue(isClear: true);
              }
            }, leftView: const Icon(Icons.add, color: Colors.white,), textSize: fontSize(12)),
          )
        ],
      ),
    );
  }

  _viewVenuesList(){
    return RefreshIndicator(
      onRefresh: refreshData,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: controller.venues.length,
          itemBuilder: (context,index){
            var data = controller.venues[index];
            return  ItemVenue(data: data, onActionVeneu: (){
              modalBottomDynamicAction(actions: GeneratedData().actionVenue(status : data.status!), onItemSelected: (item){
                if(item.toString() == Translator.deleteDraftField.tr){
                  showConfirmDialog(Get.context!, content: Translator.msgDeleteDraft.tr, showIcon: true,
                      assets: Assets.icons.icAlert, typeAsset: "svg", btn1: Translator.cancel.tr, btn3: Translator.yes.tr, onClickBtn1: (){

                  }, onClickBtn3: (){
                    controller.apiDeleteDraft(id: data.id!);
                  });
                }else{
                  print("nonaktifkan clicked");
                }
              });
            }, onClick: () async {
              if(data.status == StatusVenue.lengkapiData){
                modalBottomTwoActions(skipable: true, title: Translator.verifyRequestData.tr, content: "${Translator.congratulation.tr} ${data.name!} ${Translator.verified.tr}. ${Translator.pleaseFillForPublish.tr}",
                btnPos: Translator.later.tr, btnNeg: Translator.completeFieldDetail.tr, onBtnPosClick: (){}, onBtnNegClick: (){
                  _goToDetailVenue(data: data);
                    });
                return;
              }

              _goToDetailVenue(data: data);

            },);
          }),
    );
  }

  _goToDetailVenue({required VenueModel data}) async {
    var result = await Navigator.push(
      Get.context!,
      MaterialPageRoute(builder: (context) => AddVeneuScreen(id: data.id.toString())),
    );
    if(result != null){
      controller.apiGetListVenue(isClear: true);
    }
  }

  Future refreshData() async {
    controller.apiGetListVenue(isClear: true);
  }
}
