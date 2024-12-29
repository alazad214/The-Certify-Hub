import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

void quizRestartPopupPopup(BuildContext context, VoidCallback restart) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          padding: EdgeInsets.all(14.sp),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(Assets.icons.close),
                ),
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                "Are you sure you want to restart this quiz?",
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle14w500c6B6B6BtyleGTWalsheim,
              ),
              UIHelper.verticalSpace(24.h),
              Row(
                children: [
                  Expanded(
                    child: customButton(
                        name: 'Cancel',
                        onCallBack: () {
                          NavigationService.navigateToUntilReplacement(
                            Routes.bottomNavBarScreen,
                          );
                        },
                        height: 42.h,
                        context: context,
                        color: Colors.transparent,
                        textStyle: TextFontStyle
                            .headline18w500c222222StyleGTWalsheim
                            .copyWith(color: AppColors.c6B6B6B)),
                  ),
                  UIHelper.horizontalSpace(16.w),
                  Expanded(
                    child: customButton(
                      name: 'Restart',
                      height: 42.h,
                      onCallBack: restart,
                      context: context,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
