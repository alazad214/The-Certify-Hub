import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/onboading/widgets/custom_indicator_widget.dart';
import 'package:christiandimene/features/onboading/widgets/onboarding_page.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/all_routes.dart';

class OnBoardingWidget extends StatefulWidget {
  final Function() onDone;
  const OnBoardingWidget({super.key, required this.onDone});

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardingWidgetState createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends State<OnBoardingWidget> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentIndex = _controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c245741,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 600.h,
            child: Stack(
              children: [
                PageView(
                  controller: _controller,
                  children: [
                    OnboardingPage(
                      title: "Explore a Variety of Certifications",
                      description:
                          "Discover certification preparation courses you need to reach your goals, and anticipate the great feeling of success.",
                      image: Assets.images.onboading.path,
                    ),
                    OnboardingPage(
                      title: "Prepare with Realistic Mock Exams",
                      description:
                          "Test yourself in learning or exam mode, with instant feedback and detailed results.",
                      image: Assets.images.onboading2.path,
                    ),
                    OnboardingPage(
                      title: "Empowered by Al",
                      description:
                          "Learn differently with Generative Al agents specifically trained for the certification your are aspiring for. A real game changer.",
                      image: Assets.images.onboading3.path,
                    ),
                  ],
                ),
                CustomIndicatorWidget(currentIndex: _currentIndex),
              ],
            ),
          ),
          UIHelper.verticalSpace(40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: customButton(
              name: 'Next',
              textStyle:
                  TextFontStyle.headline18w500c222222StyleGTWalsheim.copyWith(
                color: AppColors.c222222,
              ),
              onCallBack: () {
                if (_currentIndex == 2) {
                  widget.onDone();
                } else {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                }
              },
              context: context,
            ),
          ),
          UIHelper.verticalSpace(15.h),
        ],
      ),
    );
  }
}
