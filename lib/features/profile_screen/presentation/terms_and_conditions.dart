import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Terms & Conditions',
        onCallBack: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Terms & Conditions",
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
              "Welcome to CertifyHub! By using our app, you agree to comply with these Terms & Conditions. Please read them carefully before using the app.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "2. User Responsibilities",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(10.h),
            Text(
              "As a user, you agree to:\n"
              "• Use the app for educational purposes only.\n"
              "• Provide accurate and up-to-date information for your account.\n"
              "• Respect intellectual property rights and not copy or share content without permission.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "3. Prohibited Activities",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              "You must not:\n"
              "• Use the app for illegal purposes.\n"
              "• Attempt to harm or disrupt app functionality.\n"
              "• Share your account details with others or misuse login credentials.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "4. Content Ownership",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              "All content in the app, including courses and mock tests, is the property of CertifyHub. Unauthorized use, copying, or distribution of the content is prohibited.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "5. Termination of Use",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              "We reserve the right to terminate your access to the app if you violate these Terms & Conditions.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(32.h),
          ],
        ),
      ),
    );
  }
}
