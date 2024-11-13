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
    required this.onCallBack,
    this.leadingIconUnVisible = false,
  });

  final String title;
  final VoidCallback onCallBack;
  final bool leadingIconUnVisible;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Visibility(
          visible: !leadingIconUnVisible,
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: InkWell(
              onTap: () {
                NavigationService.goBack;
              },
              child: SvgPicture.asset(
                Assets.icons.backButton,
                height: 32.h,
                width: 32.w,
              ),
            ),
          )),
      backgroundColor: Colors.white,
      titleSpacing: 2.w,
      title: Text(
        title,
        style: TextFontStyle.headline18w500cFFFFFFStyleGTWalsheim
            .copyWith(color: AppColors.c222222),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
