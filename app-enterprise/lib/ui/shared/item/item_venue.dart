import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/core/models/objects/venue_model.dart';
import 'package:myarcher_enterprise/gen/assets.gen.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/ui/shared/label_status.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/global_helper.dart';
import 'package:myarcher_enterprise/utils/key_value.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:myarcher_enterprise/utils/theme.dart';
import 'package:myarcher_enterprise/utils/translator.dart';

class ItemVenue extends StatelessWidget {
  final VenueModel data;
  final Function onActionVeneu;
  final Function onClick;
  const ItemVenue({Key? key, required this.data, required this.onActionVeneu, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            blurRadius: 10.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: const Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      margin: EdgeInsets.only(left: wValue(15), right: wValue(15), top: hValue(15)),
      child: InkWell(
        child: Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(wValue(8))),
          child: Container(
            padding: EdgeInsets.all(wValue(10)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      child: data.galleries!.isEmpty ? GlobalHelper().imageRadiusLocal(
                          Assets.images.imgPlaceholder.path, wValue(65), hValue(55), wValue(8), boxFit: BoxFit.fitWidth) : GlobalHelper().imageRadius(
                          "${data.galleries?.first.file}", wValue(65), hValue(55), wValue(8),
                          boxFit: BoxFit.fitWidth),
                      tag: data.id!,
                    ),
                    wSpace(10),
                    Expanded(flex: 1,child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 1,child: Text(
                              data.name ?? "",
                              style: textBaseBold.copyWith(color: AppColor.colorPrimary),
                              maxLines: 2,
                            ),),
                            LabelStatus(status: data.status!)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              Assets.icons.icMarkerBorder,
                              width: wValue(13),
                              color: AppColor.black,
                            ),
                            wSpace(5),
                            Expanded(
                                child: Text(
                                  "${data.address}",
                                  style: textXsRegular,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ],
                        ),
                        hSpace(10),
                      ],
                    ),)
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Button(title: Translator.detailField.tr, color: Colors.white, enable: true, onClick: (){
                        onClick();
                      }, fontColor: AppColor.colorPrimary, textSize: fontSize(10), height: hValue(30), borderColor: AppColor.colorPrimary),
                      wSpace(10),
                      if(data.status != StatusVenue.diajukan) InkWell(
                        child: SvgPicture.asset(Assets.icons.icVerticalDot),
                        onTap: (){
                          onActionVeneu();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {

        },
      ),
    );
  }
}
