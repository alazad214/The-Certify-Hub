import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void deleteButtonDialog(
  BuildContext context,
  VoidCallback deleteOntap,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 12,
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
                'Are you sure you want to delete your account?',
                style: TextFontStyle.headline18w500c222222StyleGTWalsheim
                    .copyWith(fontWeight: FontWeight.w700),
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
                      name: 'Delete',
                      height: 46.h,
                      onCallBack: deleteOntap,
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
