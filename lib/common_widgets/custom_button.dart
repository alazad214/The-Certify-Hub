import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton(
    {required String name,
    required VoidCallback onCallBack,
    double? height,
    double? minWidth,
    double? borderRadius,
    Color? color,
    TextStyle? textStyle,
    required BuildContext context,
    Color? borderColor,
    elevation}) {
  return GestureDetector(
    onTap: onCallBack,
    child: Container(
      height: height ?? 62.h,
      width: minWidth ?? double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color ?? AppColors.cFDB338,
          borderRadius: BorderRadius.circular(borderRadius ?? 33.r),
          border: Border.all(
            color: borderColor ?? AppColors.cFDB338,
          )),
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: textStyle ?? TextFontStyle.headline18w500cFFFFFFStyleGTWalsheim,
      ),
    ),
  );
}
