
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/router.dart' as rt;
import 'utils/translator.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? locale;

  @override
  void initState(){
    super.initState();
    var locale = Locale('en', 'US');
    Get.updateLocale(locale);
    // Firebase.initializeApp();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyArchery Admin',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      translations: Translator(),
      locale: locale,
      getPages: rt.Router.route,
      initialRoute: '/splashScreen',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
