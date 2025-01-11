import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppbar2 extends StatelessWidget {
  const CustomAppbar2({super.key, this.title, this.subtitle, this.ontap, this.subtitle2});
  final title;
  final subtitle;
  final subtitle2;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: ontap ??
                () {
                  NavigationService.goBack;
                },
            child: SvgPicture.asset(
              Assets.icons.backButton,
              height: 27.h,
              width: 27.w,
            ),
          ),
          UIHelper.horizontalSpace(16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextFontStyle.headline18w500c222222StyleGTWalsheim
                    .copyWith(color: AppColors.c222222),
              ),
              Row(
                children: [
                  Text(
                    subtitle,
                    style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                        .copyWith(color: Colors.black54),
                  ),
                  Text(
                    subtitle2,
                    style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                        .copyWith(color: Colors.green),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
