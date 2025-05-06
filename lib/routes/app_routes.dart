import 'package:chat_application/routes/route_names.dart';
import 'package:chat_application/view/login_screen.dart';
import 'package:chat_application/view/sign_up_screen.dart';
import 'package:chat_application/view/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: RouteNames.login, page: () => const LoginScreen()),
    GetPage(name: RouteNames.splashScreen, page: () => SplashScreen()),
    GetPage(name: RouteNames.signUpScreen, page: () => const SignupScreen()),
  ];
}
