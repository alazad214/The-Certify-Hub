import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAskMeCard extends StatelessWidget {
  const CustomAskMeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.c245741,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //image..
          Container(
            height: 77.h,
            width: 74.w,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              Assets.images.askme.path,
              fit: BoxFit.cover,
            ),
          ),

          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CMRP XpertAI',
                  overflow: TextOverflow.ellipsis,
                  style: TextFontStyle.headline20w500c222222StyleGTWalsheim
                      .copyWith(color: AppColors.cFFFFFF),
                ),
                Text(
                  'Professional CMRP Exam Prep Al assistant.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextFontStyle.textStyle12w400c9AB2A8StyleGTWalsheim
                      .copyWith(color: AppColors.cBBCBC4),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 31.h,
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.cFDB338,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      'Ask me a question',
                      overflow: TextOverflow.ellipsis,
                      style: TextFontStyle.textStyle14w500c6B6B6BtyleGTWalsheim
                          .copyWith(
                        color: AppColors.c222222,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          Image.asset(
            Assets.images.askMe2.path,
            height: 100.h,
            width: 100.w,
          )
        ],
      ),
    );
  }
}
