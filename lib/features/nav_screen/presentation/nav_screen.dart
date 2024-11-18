import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/home/presentation/home.dart';
import 'package:christiandimene/features/my_course/presentation/my_course_screen.dart';
import 'package:christiandimene/features/profile_screen/presentation/profile/profile_screen.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  State<BottomNavBarScreen> createState() => _CustomNotchedBottomBarState();
}

class _CustomNotchedBottomBarState extends State<BottomNavBarScreen> {
  int _selectedIndex = 2;
  final List<Widget> _pages = [
    MyCourseScreen(),
    ProfileScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        height: 65.sp,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.sp,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.course,
                        height: 24.h,
                        width: 24.w,
                        color: _selectedIndex == 0
                            ? AppColors.c245741
                            : AppColors.c999999),
                    UIHelper.verticalSpace(6.h),
                    Text(
                      "My Course",
                      style: TextFontStyle.textStyle12w400c9AB2A8StyleGTWalsheim
                          .copyWith(
                              color: _selectedIndex == 0
                                  ? AppColors.c245741
                                  : AppColors.c999999),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 50),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.profile,
                        height: 24.h,
                        width: 24.w,
                        color: _selectedIndex == 1
                            ? AppColors.c245741
                            : AppColors.c999999),
                    UIHelper.verticalSpace(6.h),
                    Text(
                      "Profile",
                      style: TextFontStyle.textStyle12w400c9AB2A8StyleGTWalsheim
                          .copyWith(
                        color: _selectedIndex == 1
                            ? AppColors.c245741
                            : AppColors.c999999,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.cFDB338,
        child: SvgPicture.asset(Assets.icons.home),
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
