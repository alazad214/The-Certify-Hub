import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      NavigationService.navigateToReplacement(Routes.onboading);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c245741,
      body: Center(
        child: SingleChildScrollView(
          child: Image.asset(
            Assets.images.appLogo.path,
            height: 250.h,
            width: 250.w,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
