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
  String title,
  VoidCallback finishOntap,
  restartOntap,
  String attempted,
  String unattempted,
  bool barrierDismissible,
  firstButtonName,
  secondButtonName,
  Future<bool> Function()?  ontap,
) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: ontap,
        child: Dialog(
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
                UIHelper.verticalSpace(8.h),
                Text(
                  textAlign: TextAlign.center,
                  title,
                  style: TextFontStyle.headline18w500c222222StyleGTWalsheim
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                UIHelper.verticalSpace(16.h),
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
                UIHelper.verticalSpace(16.h),
                Row(
                  children: [
                    Expanded(
                      child: customButton(
                        name: firstButtonName,
                        height: 42.h,
                        color: AppColors.white,
                        borderColor: AppColors.black.withOpacity(0.3),
                        onCallBack: finishOntap,
                        context: context,
                      ),
                    ),
                    UIHelper.horizontalSpace(10.w),
                    Expanded(
                      child: customButton(
                        name: secondButtonName,
                        height: 42.h,
                        onCallBack: restartOntap,
                        context: context,
                      ),
                    )
                  ],
                ),
                UIHelper.verticalSpace(10.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}
