import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/common_widgets/custom_textfeild.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../helpers/all_routes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var isVisibility = false;

  togglePassword() {
    setState(() {
      isVisibility = !isVisibility;
    });
  }

  @override
  void initState() {
    togglePassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UIHelper.verticalSpace(32.h),
                Text(
                  'Create Your Account',
                  style: TextFontStyle.headline32w700cFFFFFFStyleGTWalsheim
                      .copyWith(color: AppColors.c000000),
                ),
                UIHelper.verticalSpace(8.h),
                Text(
                  "Sign up to access world-class certifications preparation courses, questions bank and mock exams, and more.",
                  style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                      .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                  textAlign: TextAlign.center,
                ),
                UIHelper.verticalSpace(32.h),
                CustomTextfield(
                  hintText: 'Name',
                  borderRadius: 10.r,
                  controller: null,
                ),
                UIHelper.verticalSpace(24.h),
                CustomTextfield(
                  hintText: 'Email',
                  borderRadius: 10.r,
                  controller: null,
                ),
                UIHelper.verticalSpace(24.h),
                CustomTextfield(
                  hintText: 'Password',
                  borderRadius: 10.r,
                  controller: null,
                  isObsecure: isVisibility,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        togglePassword();
                      });
                    },
                    icon: isVisibility == false
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                ),
                UIHelper.verticalSpace(24.h),
                CustomTextfield(
                  hintText: 'Confirm Password',
                  borderRadius: 10.r,
                  controller: null,
                  isObsecure: isVisibility,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        togglePassword();
                      });
                    },
                    icon: isVisibility == false
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                ),
                UIHelper.verticalSpace(40.h),
                customButton(
                  name: 'Sign Up',
                  onCallBack: () {
                    NavigationService.navigateTo(Routes.otpVerification);
                  },
                  context: context,
                  borderRadius: 12.r,
                  textStyle: TextFontStyle.headline18w500c222222StyleGTWalsheim
                      .copyWith(color: AppColors.c000000),
                ),
                UIHelper.verticalSpace(41.5.h),
                Text(
                  'Or continue with'.tr,
                  style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                      .copyWith(color: AppColors.c6B6B6B),
                ),
                UIHelper.verticalSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.images.facebook.path,
                        width: 56.w, height: 42.h),
                    UIHelper.horizontalSpace(16.w),
                    Image.asset(Assets.images.google.path,
                        width: 56.w, height: 42.h),
                    UIHelper.horizontalSpace(16.w),
                    Image.asset(Assets.images.apple.path,
                        width: 56.w, height: 42.h),
                  ],
                ),
                UIHelper.verticalSpace(42.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account?'.tr,
                      style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                          .copyWith(color: AppColors.c6B6B6B),
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(Routes.logInScreen);
                      },
                      child: Text(
                        ' Log In here'.tr,
                        style: TextFontStyle
                            .textStyle14w400c9AB2A8StyleGTWalsheim
                            .copyWith(color: AppColors.c245741),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
