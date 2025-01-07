import 'dart:io';
import 'package:christiandimene/features/auth/presentation/forget_pass_screen.dart/create_new_pass.dart';
import 'package:christiandimene/features/auth/presentation/forget_pass_screen.dart/forget_pass_screen.dart';
import 'package:christiandimene/features/auth/presentation/otp_screen/forget_verify_screen.dart';
import 'package:christiandimene/features/certification/presentation/certification_main_screen.dart';
import 'package:christiandimene/features/certification/presentation/certification_video_player_screen.dart';
import 'package:christiandimene/features/certification/presentation/course_section_screen.dart';
import 'package:christiandimene/features/certification/presentation/mock_test_section_screen.dart';
import 'package:christiandimene/features/auth/presentation/otp_screen/otp_verification.dart';
import 'package:christiandimene/features/home/presentation/home.dart';
import 'package:christiandimene/features/practice_exam/presentation/practice_exam_instruction_screen.dart';
import 'package:christiandimene/features/practice_exam/presentation/practice_exam_result.dart';
import 'package:christiandimene/features/practice_exam/presentation/practice_question_screen.dart';
import 'package:christiandimene/features/nav_screen/presentation/nav_screen.dart';
import 'package:christiandimene/features/onboading/presentation/another_onboading.dart';
import 'package:christiandimene/features/onboading/presentation/onbording_screen.dart';
import 'package:christiandimene/features/auth/presentation/registration_screen/login_screen.dart';
import 'package:christiandimene/features/auth/presentation/registration_screen/signup_screen.dart';
import 'package:christiandimene/features/profile_screen/presentation/notification/notification_screen.dart';
import 'package:christiandimene/features/profile_screen/presentation/profile/edit_profile.dart';
import 'package:christiandimene/features/test_exam/presentation/test_exam_instruction_screen.dart';
import 'package:christiandimene/features/test_exam/presentation/test_exam_question_screen.dart';
import 'package:christiandimene/features/test_exam/presentation/test_exam_result.dart';
import 'package:flutter/cupertino.dart';
import '../features/certification/presentation/pdf_Viewer_Screen.dart';

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
  static const String pdfViewerScreen = '/pdf_Viewer_Screen';
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

  static const String practiceQuestionScreen = '/practice_question_screen';
  static const String testExamQuestionScreen = '/test_exam_question_screen';
  static const String testExamInstructionScreen = '/test_exam_instruction';
  static const String practiceExamResult = '/practice_exam_result_screen';
  static const String testExamResult = '/test_exam_result_screen';
  static const String bottomNavBarScreen = '/bottom_vavBar_screen';
  static const String practiceExamInstruction = '/practice_exam_instruction';
  static const String forgetVerifyScreen = '/forget_verify_screen';
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
        final arg = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CertificationMainScreen(
                  data: arg!['data'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => CertificationMainScreen(
                      data: arg!['data'],
                    ));

      case Routes.pdfViewerScreen:
        final arg = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PdfViewerScreen(
                  data: arg!['data'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => PdfViewerScreen(
                      data: arg!['data'],
                    ));

      case Routes.certificationSectionScreen:
        final arg = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CourseSectionScreen(
                  courseModule: arg!['data'],
                  aiData: arg['aidata'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => CourseSectionScreen(
                      courseModule: arg!['data'],
                      aiData: arg['aidata'],
                    ));

      case Routes.mockTestSectionScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: MockTestSectionScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => MockTestSectionScreen());

      case Routes.videoPlayerScreen:
        final arg = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CertificationVideoPlayerScreen(
                  data: arg!['data'],
                  lessonData: arg['lessonData'],
                  courseModule: arg['module'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => CertificationVideoPlayerScreen(
                      data: arg!['data'],
                      lessonData: arg['lessonData'],
                      courseModule: arg['module'],
                    ));

      case Routes.otpVerification:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OtpVerification(), settings: settings)
            : CupertinoPageRoute(builder: (context) => OtpVerification());

      case Routes.editProfile:
        final arg = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EditProfileScreen(
                  data: arg!['data'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => EditProfileScreen(
                      data: arg!['data'],
                    ));

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

      case Routes.practiceExamInstruction:
        final arg = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PracticeExamInstructionScreen(
                  quiz: arg!['data'],
                  data: arg['courseId'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => PracticeExamInstructionScreen(
                      quiz: arg!['data'],
                      data: arg['courseId'],
                    ));

      case Routes.practiceQuestionScreen:
        final arg = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PracticeQuestionScreen(
                  quiz: arg!['data'],
                  data: arg['course'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => PracticeQuestionScreen(
                  quiz: arg!['data'],
                  data: arg['course'],
                ),
              );

      case Routes.practiceExamResult:
        final arg = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PracticeExamResult(
                  quiz: arg!['quiz'],
                  attempted: arg['attempted'],
                  selectedOptions: arg['selectedOptions'],
                  data: arg['course'],
                ),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => PracticeExamResult(
                  quiz: arg!['quiz'],
                  attempted: arg['attempted'],
                  selectedOptions: arg['selectedOptions'],
                ),
              );

      case Routes.createNewPassword:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CreateNewPassScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => CreateNewPassScreen());

      case Routes.bottomNavBarScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: BottomNavBarScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => BottomNavBarScreen());

      case Routes.testExamInstructionScreen:
        final arg = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: TestExamInstructionScreen(
                  quiz: arg!['data'],
                  data: arg['courseId'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => TestExamInstructionScreen(
                      quiz: arg!['data'],
                      data: arg['courseId'],
                    ));

      case Routes.testExamQuestionScreen:
        final arg = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: TestExamQuiz(
                  quiz: arg!['data'],
                  data: arg['courseId'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => TestExamQuiz(
                  quiz: arg!['data'],
                  data: arg['courseId'],
                ),
              );

      case Routes.testExamResult:
        final arg = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: TestExamResult(
                  quiz: arg!['data'],
                  data: arg['courseId'],
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => TestExamResult(
                  quiz: arg!['data'],
                  data: arg['courseId'],
                ),
              );

      case Routes.forgetVerifyScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ForgetVerifyScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => ForgetVerifyScreen(),
              );

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
//

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
