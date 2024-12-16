import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'About Us',
        onCallBack: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("About Us",
                style: TextFontStyle.headline24w400c222222StyleGTWalsheim),
            UIHelper.verticalSpace(10.h),
            Text(
              "Effective Date: January 2025",
              style: TextFontStyle.textStyle14w500c6B6B6BtyleGTWalsheim,
            ),
            UIHelper.verticalSpace(24.h),
            Text(
              "1. Who We Are",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              "CertifyHub is an innovative platform designed to enhance the learning experience by providing quality courses and mock tests. Our mission is to make education accessible and effective for everyone, regardless of location.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "2. Our Mission",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(10.h),
            Text(
              "Our mission is to provide a user-friendly platform that helps learners achieve their educational goals. We aim to provide high-quality content and tools for a personalized learning experience.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "3. What We Offer",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              "• High-quality educational courses on various topics.\n"
              "• Mock tests designed to help students prepare for exams.\n"
              "• Personalized learning experience to cater to individual needs.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "4. Our Vision",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              "To become a leading platform for online education, known for delivering comprehensive and effective learning experiences to students worldwide.",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              "5. Contact Us",
              style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(8.h),
            Text(
                "For more information or inquiries, feel free to contact us at:",
                style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim),
            Text(
              "Email: support@certifyhub.com\n"
              "Phone: +1 123-456-7890\n"
              "Address: 1234 Learning Ave, Education City, 56789",
              style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim
                  .copyWith(color: AppColors.allPrimaryColor),
            ),
            UIHelper.verticalSpace(32.h),
          ],
        ),
      ),
    );
  }
}
