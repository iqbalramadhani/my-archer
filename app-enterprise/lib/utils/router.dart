import 'package:get/get.dart';

import '../ui/pages/splash/splash_screen.dart';
import 'app_route.dart';

class Router {
  static final route = [
    GetPage(
      name: AppRoute.SPLASHPAGE,
      page: () => const SplashScreen(),
    ),
  ];
}
