import 'package:flutter/material.dart';
import 'package:myarcher_enterprise/core/controllers/profile_controller.dart';
import 'package:myarcher_enterprise/ui/shared/button.dart';
import 'package:myarcher_enterprise/utils/app_color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var controller = ProfileController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Button(title: "LOGOUT!", color: AppColor.colorPrimary, enable: true, onClick: (){
          controller.logout();
        }),
      ),
    );
  }
}
