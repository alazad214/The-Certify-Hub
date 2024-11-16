import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final TextEditingController _otpTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 55.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UIHelper.verticalSpace(32.h),
                  Text(
                    'Verify Account!'.tr,
                    style: TextFontStyle.headline32w700cFFFFFFStyleGTWalsheim
                        .copyWith(color: AppColors.c000000),
                    textAlign: TextAlign.center,
                  ),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    "Sign up to continue.".tr,
                    style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                        .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              UIHelper.verticalSpace(55.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      "Enter 4 digit code.".tr,
                      style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                          .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),
                  PinCodeTextField(
                    length: 4,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12.r),
                        fieldHeight: 52.h,
                        fieldWidth: 70.w,
                        inactiveFillColor: AppColors.cE8E8E8,
                        inactiveColor: AppColors.cE8E8E8,
                        selectedColor: Colors.transparent,
                        selectedBorderWidth: 2,
                        activeFillColor: AppColors.cE8E8E8,
                        activeColor: AppColors.cE8E8E8,
                        selectedFillColor: AppColors.cE8E8E8),
                    cursorColor: AppColors.c245741,
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: _otpTEController,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                    appContext: context,
                  ),
                  UIHelper.verticalSpace(16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Didn’t Receive Code?'.tr,
                        style: TextFontStyle
                            .textStyle14w400c9AB2A8StyleGTWalsheim
                            .copyWith(color: AppColors.c6B6B6B),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          ' Resend Code'.tr,
                          style: TextFontStyle
                              .textStyle14w400c9AB2A8StyleGTWalsheim
                              .copyWith(color: AppColors.c245741),
                        ),
                      )
                    ],
                  ),
                  UIHelper.verticalSpace(8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Resend code in'.tr,
                        style: TextFontStyle
                            .textStyle14w400c9AB2A8StyleGTWalsheim
                            .copyWith(color: AppColors.c6B6B6B),
                      ),
                      Text(
                        ' 00:59'.tr,
                        style: TextFontStyle
                            .textStyle14w400c9AB2A8StyleGTWalsheim
                            .copyWith(color: AppColors.c245741),
                      )
                    ],
                  ),
                  UIHelper.verticalSpace(180.h),
                  customButton(
                    name: 'Verify',
                    borderRadius: 12.r,
                    onCallBack: () {
                      NavigationService.navigateTo(Routes.createNewPassword);
                    },
                    context: context,
                    textStyle: TextFontStyle
                        .headline18w500c222222StyleGTWalsheim
                        .copyWith(color: AppColors.c000000),
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
