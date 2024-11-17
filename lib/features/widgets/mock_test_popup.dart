import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

void mockTestPopup(
    BuildContext context, VoidCallback practiceOntap, VoidCallback testOntap) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 12,
        child: Container(
          padding: EdgeInsets.all(20.sp),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(Assets.icons.close))),
              UIHelper.verticalSpace(24.h),
              Text(
                'Pick your mode and let’s go!',
                style: TextFontStyle.headline18w500c222222StyleGTWalsheim,
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                "How would you like to proceed with this topic? Select 'Practice' to learn at your own pace or 'Test' to simulate real exam conditions.",
                style: TextFontStyle.textStyle12w400c9AB2A8StyleGTWalsheim,
              ),
              UIHelper.verticalSpace(24.h),
              customButton(
                  name: 'Practice',
                  onCallBack: practiceOntap,
                  height: 48.h,
                  context: context,
                  color: Colors.transparent,
                  textStyle: TextFontStyle.headline18w500c222222StyleGTWalsheim
                      .copyWith(color: AppColors.c6B6B6B)),
              UIHelper.verticalSpace(16.h),
              customButton(
                name: 'Test',
                height: 48.h,
                onCallBack: testOntap,
                context: context,
              ),
              UIHelper.verticalSpace(32.h),
            ],
          ),
        ),
      );
    },
  );
}
