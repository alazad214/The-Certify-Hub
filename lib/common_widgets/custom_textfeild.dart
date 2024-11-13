import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      this.hintText,
      this.validation,
      this.obscuretext,
      this.onchanged,
      this.controller,
      this.suffixIcon,
      this.suffixIconOntap,
      this.fillColor,
      this.maxLines,
      this.borderRadius,
      this.keyboardType,
      this.isPrefix = true,
      this.isSuffix = true,
      this.contentVerticalPadding,
      this.fillColors,
      this.borderColor,
      this.prefixIcon,
      this.prefixIconOntap,
      this.readOnly,
      this.ontap,
      this.fontSize,
      this.onSubmitted});

  final hintText;
  final validation;
  final obscuretext;
  final onchanged;
  final controller;
  final suffixIcon;
  final prefixIcon;
  final suffixIconOntap;
  final prefixIconOntap;
  final fillColor;
  final maxLines;
  final double? borderRadius;
  final keyboardType;
  final bool isPrefix;
  final bool isSuffix;
  final double? contentVerticalPadding;
  final Color? fillColors;
  final Color? borderColor;
  final readOnly;
  final ontap;
  final fontSize;
  final onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [AppColors.c999999, AppColors.cFFFFFF], // Gradient colors
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          //color: AppColors.cBBCBC4,
          ),
      child: TextFormField(
        onChanged: onchanged,
        validator: validation,
        controller: controller,
        onTap: ontap,
        obscureText: obscuretext ?? false,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        readOnly: readOnly ?? false,
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.c999999), // Text color
          contentPadding: EdgeInsets.symmetric(
              horizontal: 4.w, vertical: contentVerticalPadding ?? 17.h),
          suffixIcon: isSuffix == true
              ? IconButton(onPressed: suffixIconOntap, icon: Icon(suffixIcon))
              : SizedBox(),
          prefixIcon: isPrefix == true
              ? IconButton(onPressed: prefixIconOntap, icon: Icon(prefixIcon))
              : SizedBox(),
          filled: true,
          fillColor: fillColors ?? fillColor,

          //enable-->
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
            borderSide: BorderSide(
                color: borderColor ?? Colors.transparent, width: 1.w),
          ),
          //focus-->
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1.5.w,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          ),
          //focus-->
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.cBBCBC4,
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          ),
        ),
        style: TextStyle(color: AppColors.c999999), // Input text color
      ),
    );
  }
}
