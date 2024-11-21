import 'package:christiandimene/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'gen/assets.gen.dart';

final class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
