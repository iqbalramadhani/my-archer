import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';
import 'package:myarcher_enterprise/utils/spacing.dart';
import 'package:shimmer/shimmer.dart';

Widget showShimmerMenu(){
  return Container(
    margin: EdgeInsets.all(wValue(10)),
    child: Shimmer.fromColors(
      baseColor: AppColor.greyShimmer,
      highlightColor: Colors.white60,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SvgPicture.asset("assets/img/rect_shimmer.svg", width: wValue(230),),
            wSpace(10),
            SvgPicture.asset("assets/img/rect_shimmer.svg", width: wValue(230),),
            wSpace(10),
            SvgPicture.asset("assets/img/rect_shimmer.svg", width: wValue(230),),
          ],
        ),
      ),
    ),
  );
}

Widget showShimmerProfileClub(){
  return Container(
    margin: EdgeInsets.all(wValue(10)),
    child: Shimmer.fromColors(
      baseColor: AppColor.greyShimmer,
      highlightColor: Colors.white60,
      child: SvgPicture.asset("assets/img/img_shimmer_profile.svg", width: Get.width,),
    ),
  );
}

Widget showShimmerList(){
  return Container(
    margin: EdgeInsets.all(wValue(15)),
    child: Shimmer.fromColors(
      baseColor: AppColor.greyShimmer,
      highlightColor: Colors.white60,
      child: Column(
        children: [
          SizedBox(
            height: hValue(15),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey,
                width: Get.width,
                height: hValue(10),
              ),
              SizedBox(
                height: hValue(5),
              ),
              Container(
                color: Colors.grey,
                width: wValue(150),
                height: hValue(10),
              )
            ],
          ),
          SizedBox(
            height: hValue(15),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey,
                width: Get.width,
                height: hValue(10),
              ),
              SizedBox(
                height: hValue(5),
              ),
              Container(
                color: Colors.grey,
                width: wValue(150),
                height: hValue(10),
              )
            ],
          ),
          SizedBox(
            height: hValue(15),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey,
                width: Get.width,
                height: hValue(10),
              ),
              SizedBox(
                height: hValue(5),
              ),
              Container(
                color: Colors.grey,
                width: wValue(150),
                height: hValue(10),
              )
            ],
          ),
          SizedBox(
            height: hValue(15),
          ),
        ],
      ),
    ),
  );
}