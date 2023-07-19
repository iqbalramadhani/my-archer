import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myarcher_enterprise/utils/app_route.dart';
import 'package:oktoast/oktoast.dart';

import 'utils/router.dart' as rt;
import 'utils/translator.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? locale;

  @override
  void initState() {
    super.initState();
    var locale = const Locale('id', 'ID');
    Get.updateLocale(locale);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(child: GetMaterialApp(
      title: Translator.appName.tr,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      translations: Translator(),
      locale: locale,
      getPages: rt.Router.route,
      initialRoute: AppRoute.SPLASHPAGE,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    ));
  }
}
