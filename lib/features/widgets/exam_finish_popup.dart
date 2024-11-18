import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

void examFinishPopup(
  BuildContext context,
  VoidCallback finishOntap,
  String timeLeft,
  String attempted,
  String unattempted,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
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
              UIHelper.verticalSpace(24.h),
              Text(
                textAlign: TextAlign.center,
                'Are you sure you want to Finish this?',
                style: TextFontStyle.headline18w500c222222StyleGTWalsheim
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              UIHelper.verticalSpace(40.h),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.icons.clock,
                    height: 24.h,
                    width: 24.w,
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Text(
                    'Time left',
                    style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                        .copyWith(color: AppColors.c222222),
                  ),
                  Spacer(),
                  Text(
                    timeLeft,
                    style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                        .copyWith(color: AppColors.c222222),
                  )
                ],
              ),
              UIHelper.verticalSpace(12.h),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.icons.tickCircle,
                    height: 24.h,
                    width: 24.w,
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Text(
                    'Attempted',
                    style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                        .copyWith(color: AppColors.c222222),
                  ),
                  Spacer(),
                  Text(
                    attempted,
                    style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                        .copyWith(color: AppColors.c222222),
                  )
                ],
              ),
              UIHelper.verticalSpace(12.h),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.icons.warning2,
                    height: 24.h,
                    width: 24.w,
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Text(
                    'Unattempted',
                    style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                        .copyWith(color: AppColors.c222222),
                  ),
                  Spacer(),
                  Text(
                    unattempted,
                    style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                        .copyWith(color: AppColors.c222222),
                  )
                ],
              ),
              UIHelper.verticalSpace(40.h),
              Row(
                children: [
                  Expanded(
                    child: customButton(
                        name: 'Cencel',
                        onCallBack: () {
                          Navigator.pop(context);
                        },
                        height: 46.h,
                        context: context,
                        borderColor: AppColors.c6B6B6B,
                        color: Colors.transparent,
                        textStyle: TextFontStyle
                            .headline18w500c222222StyleGTWalsheim
                            .copyWith(color: AppColors.c6B6B6B)),
                  ),
                  UIHelper.horizontalSpace(16.h),
                  Expanded(
                    child: customButton(
                      name: 'Finish',
                      height: 46.h,
                      onCallBack: finishOntap,
                      context: context,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(32.h),
            ],
          ),
        ),
      );
    },
  );
}
