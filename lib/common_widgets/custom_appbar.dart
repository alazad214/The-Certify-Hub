import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
     this.onCallBack,
    this.leadingIconUnVisible = false,
    this.actions,
  });

  final String title;
  final  onCallBack;
  final bool leadingIconUnVisible;
  final actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Visibility(
          visible: !leadingIconUnVisible,
          child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: InkWell(
                onTap: onCallBack??  () {
                  NavigationService.goBack();
                },
                child: SvgPicture.asset(
                  Assets.icons.backButton,
                  height: 32.h,
                  width: 32.w,
                ),
              ))),
      backgroundColor: AppColors.cE9EEEC,
      titleSpacing: 2.w,
      title: Text(
        title,
        style: TextFontStyle.headline18w500c222222StyleGTWalsheim
            .copyWith(color: AppColors.c222222),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//