import 'package:christiandimene/common_widgets/custom_textfeild.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_button.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.0, vertical: 55.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UIHelper.verticalSpace(32.0),
                  Text(
                    'Forget Password!'.tr,
                    style: TextFontStyle.headline32w700cFFFFFFStyleGTWalsheim
                        .copyWith(color: AppColors.c000000),
                    textAlign: TextAlign.center,
                  ),
                  UIHelper.verticalSpace(8.0),
                  Text(
                    "Sign up to continue".tr,
                    style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                        .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              UIHelper.verticalSpace(55.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      "No worries! Enter your email address below and we will send you a code to reset password. "
                          .tr,
                      style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                          .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  UIHelper.verticalSpace(16.0),
                  CustomTextfield(
                    hintText: 'Enter your email',
                    borderRadius: 10.0,
                    controller: null,
                    style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim,
                  ),
                  UIHelper.verticalSpace(201.0),
                  customButton(
                    name: 'Send',
                    borderRadius: 12.r,
                    onCallBack: () {
                      NavigationService.navigateTo(Routes.otpVerification);
                    },
                    context: context,
                    textStyle: TextFontStyle
                        .headline18w500c222222StyleGTWalsheim
                        .copyWith(color: AppColors.cFFFFFF),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
