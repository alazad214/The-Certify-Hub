import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Privacy Policy',
        onCallBack: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Privacy Policy",
                style: TextFontStyle.headline24w400c222222StyleGTWalsheim),
            UIHelper.verticalSpace(10.h),
            Text(
              "Effective Date: January 2025",
              style: TextFontStyle.textStyle14w500c6B6B6BtyleGTWalsheim,
            ),
            UIHelper.verticalSpace(24.h),
            Text(
              "1. Introduction",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              "Welcome to our CertifyHub app! Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our app.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "2. Information We Collect",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(10.h),
            Text(
              "We collect the following information:\n"
              "• Personal information (e.g., name, email) for user accounts.\n"
              "• Course progress and mock test performance data.\n"
              "• Device information for app analytics and improvements.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "3. How We Use Information",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "We use your information to:\n"
              "• Provide and improve our educational content.\n"
              "• Track course progress and mock test results.\n"
              "• Ensure a smooth and personalized user experience.\n"
              "• Communicate updates and offers related to the app.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "4. Data Protection",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "We take appropriate security measures to protect your personal data. However, no method of transmission over the internet is 100% secure.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "5. Third-Party Services",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "We may use trusted third-party services (e.g., Google Analytics) for improving the app. These services comply with their respective privacy policies.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "6. Your Rights",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              "You have the right to access, update, or delete your personal data. Please contact us if you need any assistance regarding your data.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
          ],
        ),
      ),
    );
  }
}
