import 'package:get/get.dart';
import 'package:mobile/pages/app/app_bindings.dart';
import 'package:mobile/pages/app/app_view.dart';
import 'package:mobile/pages/app/chat/message/msg_bindings.dart';
import 'package:mobile/pages/app/chat/message/msg_view.dart';
import 'package:mobile/pages/app/post/create/create_post_bindings.dart';
import 'package:mobile/pages/app/post/create/create_post_view.dart';
import 'package:mobile/pages/app/post/edit/edit_post_bindings.dart';
import 'package:mobile/pages/app/post/edit/edit_post_view.dart';
import 'package:mobile/pages/app/setting/change_pw/pw_bindings.dart';
import 'package:mobile/pages/app/setting/change_pw/pw_view.dart';
import 'package:mobile/pages/app/setting/profile/profile_view.dart';
import 'package:mobile/pages/app/setting/setting_bindings.dart';
import 'package:mobile/pages/app/tutor/result/result_bindings.dart';
import 'package:mobile/pages/app/tutor/result/result_view.dart';
import 'package:mobile/pages/app/tutor/review/review_bindings.dart';
import 'package:mobile/pages/app/tutor/review/review_view.dart';
import 'package:mobile/pages/app/tutor/tutor_bindings.dart';
import 'package:mobile/pages/app/tutor/voice/voice_view.dart';
import 'package:mobile/pages/auth/forgot-pw/forgot_pw_bindings.dart';
import 'package:mobile/pages/auth/forgot-pw/forgot_pw_view.dart';
import 'package:mobile/pages/auth/reset-pw/reset_pw_bindings.dart';
import 'package:mobile/pages/auth/reset-pw/reset_pw_view.dart';
import 'package:mobile/pages/auth/reset-pw/reset_success_view.dart';
import 'package:mobile/pages/auth/verify/verify_code_bindings.dart';
import 'package:mobile/pages/auth/verify/verify_code_view.dart';
import 'package:mobile/pages/auth/sign_in/signin_bindings.dart';
import 'package:mobile/pages/auth/sign_in/signin_view.dart';
import 'package:mobile/pages/auth/sign_up/signup_bindings.dart';
import 'package:mobile/pages/auth/sign_up/signup_view.dart';
import 'package:mobile/pages/auth/splash_view.dart';
import 'package:mobile/routes/routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.application, 
      page: () => AppView(),
      binding: AppBindings()
    ),
    GetPage(
      name: AppRoutes.signin, 
      page: () => SigninView(),
      binding: SigninBindings(),
    ),
    GetPage(
      name: AppRoutes.verifycode, 
      page: () => VerifyCodeView(),
      binding: VerifyCodeBindings()
    ),
    GetPage(
      name: AppRoutes.resetpassword, 
      page: () => ResetPwView(),
      binding: ResetPwBindings()
    ),
    GetPage(
      name:  AppRoutes.resetsuccess,
      page: () => ResetSuccessView(),
    ),
    GetPage(
      name: AppRoutes.forgotpassword, 
      page: () => ForgotPwView(),
      binding: ForgotPwBindings()
    ),
    GetPage(
      name: AppRoutes.signup, 
      page: () => SignupView(),
      binding: SignupBindings()
    ),
    GetPage(
      name: AppRoutes.message, 
      page: () => MsgView(),
      binding: MsgBindings()
    ),
    GetPage(
      name: AppRoutes.createpost, 
      page: () => CreatePostView(),
      binding: CreatePostBindings(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
      transitionDuration: const Duration(milliseconds: 200)
    ),
    GetPage(
      name: AppRoutes.editpost,
      page: () => EditPostView(),
      binding: EditPostBindings(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),
    GetPage(
      name: AppRoutes.profile, 
      page: () => ProfileView(),
      binding: ProfileBindings()
    ),
    GetPage(
      name: AppRoutes.review,
      page: () => ReviewView(),
      binding: ReviewBindings(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
      transitionDuration: const Duration(milliseconds: 200)
    ),
    GetPage(
      name: AppRoutes.result,
      page: () => ResultView(),
      binding: ResultBindings()
    ),
    GetPage(
      name: AppRoutes.voice, 
      page: () => VoiceView(),
      binding: VoiceBindings()
    ),
    GetPage(
      name: AppRoutes.changepw, 
      page: () => PwView(),
      binding: PwBindings()
    ),
    GetPage(
      name: AppRoutes.splash, 
      page: () => SplashView(), 
    ),
  ];
}