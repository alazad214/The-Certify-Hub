import 'dart:io';

import 'package:christiandimene/features/auth/presentation/forget_pass_screen.dart/create_new_pass.dart';
import 'package:christiandimene/features/auth/presentation/forget_pass_screen.dart/forget_pass_screen.dart';
import 'package:christiandimene/features/certification/presentation/certification_main_screen.dart';
import 'package:christiandimene/features/certification/presentation/certification_video_player_screen.dart';
import 'package:christiandimene/features/certification/presentation/course_section_screen.dart';
import 'package:christiandimene/features/certification/presentation/mock_test_section_screen.dart';

import 'package:christiandimene/features/auth/presentation/otp_screen/otp_verification.dart';
import 'package:christiandimene/features/home/presentation/home.dart';
import 'package:christiandimene/features/mock_test/presentation/mock_test_instruction/mock_test_instruction_screen.dart';
import 'package:christiandimene/features/mock_test/presentation/mock_test_result/mock_result_screen.dart';
import 'package:christiandimene/features/mock_test/presentation/mock_test_screen/question_screen.dart';

import 'package:christiandimene/features/onboading/presentation/another_onboading.dart';
import 'package:christiandimene/features/onboading/presentation/onbording_screen.dart';
import 'package:christiandimene/features/auth/presentation/registration_screen/login_screen.dart';
import 'package:christiandimene/features/auth/presentation/registration_screen/signup_screen.dart';
import 'package:christiandimene/features/profile_screen/presentation/notification/notification_screen.dart';
import 'package:christiandimene/features/profile_screen/presentation/profile/edit_profile.dart';
import 'package:christiandimene/features/test_exam/presentation/test_passed_result.dart';
import 'package:flutter/cupertino.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  static const String logInScreen = '/logIn';
  static const String signUpScreen = '/signUp';
  static const String home = '/home';
  static const String search = '/search';

  ///Zobayer Hasan Nayem
  static const String forgetPassword = '/forget_password';
  static const String createNewPassword = '/create_new_password';
  static const String profile = '/profile';
  static const String editProfile = '/edit_profile';
  static const String changePassword = '/change_password';

  ///AZAD ADDED-->
  static const String onboading = '/onboading_screen';
  static const String anotherOnboading = '/another_onboading_screen';

  static const String certificationScreen = '/certification_main_screen';
  static const String certificationSectionScreen =
      '/certification_section_screen';
  static const String mockTestSectionScreen = '/mockTest_section_screen';
  static const String videoPlayerScreen = '/video_player_screen';

  static const String otpVerification = '/otp_verification';
  static const String notification = '/notification';

  ///Zobayer (mock test instructions)
  static const String mock_test_instruction_screen =
      '/mock_test_instruction_screen';
  static const String question_screen = '/question_screen';
  static const String mock_test_result = '/mock_test_result';
  static const String testPassedResult = '/test_passed_result';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.signUpScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(widget: SignUpScreen(), settings: settings)
      //       : CupertinoPageRoute(builder: (context) => SignUpScreen());

      case Routes.onboading:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const OnBoardingScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const OnBoardingScreen());

      case Routes.anotherOnboading:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AnotherOnboading(), settings: settings)
            : CupertinoPageRoute(builder: (context) => AnotherOnboading());

      case Routes.signUpScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: SignupScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SignupScreen());

      case Routes.logInScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: LoginScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => LoginScreen());

      case Routes.certificationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CertificationMainScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => CertificationMainScreen());

      case Routes.certificationSectionScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CourseSectionScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => CourseSectionScreen());

      case Routes.mockTestSectionScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: MockTestSectionScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => MockTestSectionScreen());

      case Routes.videoPlayerScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CertificationVideoPlayerScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => CertificationVideoPlayerScreen());

      case Routes.otpVerification:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OtpVerification(), settings: settings)
            : CupertinoPageRoute(builder: (context) => OtpVerification());

      case Routes.editProfile:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EditProfileScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => EditProfileScreen());

      case Routes.forgetPassword:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ForgetPasswordScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ForgetPasswordScreen());

      case Routes.home:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: HomeScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => HomeScreen());

      case Routes.notification:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: NotificationScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => NotificationScreen());

      case Routes.mock_test_instruction_screen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: MockTestInstructions(), settings: settings)
            : CupertinoPageRoute(builder: (context) => MockTestInstructions());

      case Routes.question_screen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: QuestionWidget(), settings: settings)
            : CupertinoPageRoute(builder: (context) => QuestionWidget());

      case Routes.mock_test_result:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: MockTestResult(), settings: settings)
            : CupertinoPageRoute(builder: (context) => MockTestResult());

      case Routes.createNewPassword:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CreateNewPassScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => CreateNewPassScreen());

      case Routes.testPassedResult:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: TestPassesResultScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => TestPassesResultScreen());

      default:
        return null;
    }
  }
}

//  weenAnimationBuilder(
//   child: Widget,
//   tween: Tween<double>(begin: 0, end: 1),
//   duration: Duration(milliseconds: 1000),
//   curve: Curves.bounceIn,
//   builder: (BuildContext context, double _val, Widget child) {
//     return Opacity(
//       opacity: _val,
//       child: Padding(
//         padding: EdgeInsets.only(top: _val * 50),
//         child: child
//       ),
//     );
//   },
// );

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget,
    );
  }
}
