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
    padding,
    TextStyle? textStyle,
    required BuildContext context,
    Color? borderColor,
    elevation}) {
  return GestureDetector(
    onTap: onCallBack,
    child: Container(
      height: height ?? 62.h,
      width: minWidth ?? double.infinity,
      padding: padding??EdgeInsets.all(0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color ?? AppColors.cFDB338,
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          border: Border.all(
            color: borderColor ?? AppColors.cFDB338,
          )),
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: textStyle ?? TextFontStyle.headline18w500c222222StyleGTWalsheim,
      ),
    ),
  );
}

// import 'package:christiandimene/constants/text_font_style.dart';
// import 'package:christiandimene/gen/colors.gen.dart';
// import 'package:christiandimene/helpers/ui_helpers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';

// import '../gen/assets.gen.dart';

// Widget customButton(
//     {required String name,
//     required VoidCallback onCallBack,
//     double? height,
//     double? minWidth,
//     double? borderRadius,
//     Color? color,
//     TextStyle? textStyle,
//     required BuildContext context,
//     Color? borderColor,
//     String? svgImage,
//     bool? isTrue,
//     elevation}) {
//   return GestureDetector(
//     onTap: onCallBack,
//     child: Container(
//       height: height ?? 62.h,
//       width: minWidth ?? double.infinity,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//           color: color ?? AppColors.cFDB338,
//           borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
//           border: Border.all(
//             color: borderColor ?? AppColors.cFDB338,
//           )),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           isTrue == true
//               ? SvgPicture.asset(
//                   svgImage ?? '',
//                   height: 24.h,
//                   width: 24.w,
//                 )
//               : SizedBox(),
//           UIHelper.horizontalSpace(10.w),
//           Text(
//             name,
//             overflow: TextOverflow.ellipsis,
//             style:
//                 textStyle ?? TextFontStyle.headline18w500c222222StyleGTWalsheim,
//           ),
//         ],
//       ),
//     ),
//   );
// }
