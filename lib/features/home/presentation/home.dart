import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          children: [
            ///home header.....
            _buildHomeHeader(),

            GridView.builder(
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Container();
                })
          ],
        ),
      ),
    ));
  }

  Row _buildHomeHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey, Fatema 👋',
                style: TextFontStyle.headline24w400c222222StyleGTWalsheim,
              ),
              UIHelper.verticalSpace(10.h),
              Text(
                'Pick a certification to get started!',
                style: TextFontStyle.headline18w400cFFFFFFStyleGTWalsheim,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: 44.h,
            width: 44.w,
            padding: EdgeInsets.all(7.sp),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              Assets.icons.notification,
              height: 24.h,
              width: 24.w,
            ),
          ),
        )
      ],
    );
  }
}
