import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarchery_archer/ui/shared/base_container.dart';
import 'package:myarchery_archer/utils/theme.dart';

class ReviewPaymentOfficialScreen extends StatefulWidget {
  const ReviewPaymentOfficialScreen({Key? key}) : super(key: key);

  @override
  _ReviewPaymentOfficialScreenState createState() => _ReviewPaymentOfficialScreenState();
}

class _ReviewPaymentOfficialScreenState extends State<ReviewPaymentOfficialScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Container(
        width: Get.width,
        child: SafeArea(
          child: Scaffold(

          ),
        ),
      ),
    );
  }
}
