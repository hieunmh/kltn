import 'package:get/get.dart';
import 'package:mobile/pages/auth/sign_in/signin_bindings.dart';
import 'package:mobile/pages/auth/sign_in/signin_view.dart';
import 'package:mobile/pages/auth/sign_up/signup_bindings.dart';
import 'package:mobile/pages/auth/sign_up/signup_view.dart';
import 'package:mobile/pages/auth/splash_view.dart';
import 'package:mobile/routes/routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.signin, 
      page: () => SigninView(),
      binding: SigninBindings(),
    ),
    GetPage(
      name: AppRoutes.signup, 
      page: () => SignupView(),
      binding: SignupBindings()
    ),
    GetPage(
      name: AppRoutes.splash, 
      page: () => SplashView(),
    )
  ];
}