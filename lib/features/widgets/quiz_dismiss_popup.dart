import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void quizDismissPopup(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          padding: EdgeInsets.all(20.sp),
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.cE9EEEC,
              borderRadius: BorderRadius.circular(16.r)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Are you sure you want to exit this quiz?',
                textAlign: TextAlign.center,
                style:
                    TextFontStyle.headline18w500c222222StyleGTWalsheim.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  color: AppColors.c222222,
                ),
              ),
              UIHelper.verticalSpace(16.h),
              customButton(
                name: 'Yes, Exit.',
                height: 46.h,
                onCallBack: () {
                  NavigationService.navigateToUntilReplacement(
                      Routes.bottomNavBarScreen);
                },
                context: context,
              ),
            ],
          ),
        ),
      );
    },
  );
}
