import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextFontStyle.headline32w700cFFFFFFStyleGTWalsheim,
              ),
              UIHelper.verticalSpace(10.h),
              Text(
                maxLines: 3,
                description,
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim,
              ),
            ],
          ),
          UIHelper.verticalSpace(44.h),
          Image.asset(
            image,
            height: 350.h,
            width: 280.w,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
