import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnotherOnboading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF234E38), // Dark green background
      body: Column(
        children: [
          Spacer(
            flex: 3,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  "Let's Get Certified!",
                  style: TextFontStyle.headline32w700cFFFFFFStyleGTWalsheim,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  "Log in or create an account to start your\ncertification journey.",
                  style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Spacer(),
          ClipPath(
            clipper: TopRoundedClipper(),
            child: Container(
                color: Colors.white,
                height: 360.h,
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UIHelper.verticalSpace(30.h),
                    customButton(
                      name: 'Log in',
                      onCallBack: () {},
                      context: context,
                    ),
                    UIHelper.verticalSpace(12.h),
                    Text(
                      'or',
                      style: TextFontStyle.headline18w500c222222StyleGTWalsheim
                          .copyWith(
                              color: AppColors.c999999,
                              fontWeight: FontWeight.w700),
                    ),
                    UIHelper.verticalSpace(12.h),
                    customButton(
                      name: 'Sign Up',
                      color: Colors.transparent,
                      onCallBack: () {},
                      textStyle: TextFontStyle
                          .headline18w500c222222StyleGTWalsheim
                          .copyWith(color: AppColors.cFDB338),
                      context: context,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class TopRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.25.h);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height * 0.25.h);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
