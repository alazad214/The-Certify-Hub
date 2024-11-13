import 'dart:io';

import 'package:christiandimene/features/onboading/presentation/another_onboading.dart';
import 'package:christiandimene/features/onboading/presentation/onbording_screen.dart';

import 'package:christiandimene/features/auth/presentation/login_screen.dart';
import 'package:christiandimene/features/auth/presentation/signup_screen.dart';

import 'package:flutter/cupertino.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  static const String logInScreen = '/logIn';
  static const String signUpScreen = '/signUp';
  static const String home = '/home';
  static const String search = '/search';

  ///AZAD ADDED-->
  static const String onboading = '/onboading_screen';
  static const String anotherOnboading = '/another_onboading_screen';
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
