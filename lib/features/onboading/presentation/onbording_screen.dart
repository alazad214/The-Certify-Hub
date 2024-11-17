import 'package:christiandimene/constants/app_constants.dart';
import 'package:christiandimene/features/onboading/widgets/onboarding_widget.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/di.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    appData.write(kKeyfirstTime, false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c245741,
        title: Row(
          children: [
            const Spacer(),
            GestureDetector(
              onTap: () {
                NavigationService.navigateToReplacement(
                    Routes.anotherOnboading);
              },
              child: Text(
                "Skip",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ],
        ),
      ),
      body: OnBoardingWidget(
        onDone: () => NavigationService.navigateToReplacement(
          Routes.anotherOnboading,
        ),
      ),
    );
  }
}
