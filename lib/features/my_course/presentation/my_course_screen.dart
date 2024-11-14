import 'package:christiandimene/common_widgets/custom_textfeild.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = 'Ongoing';
  }

  final List<Map<String, dynamic>> onGoingCourses = [
    {"progress": 0.2},
    {"progress": 0.0},
    {"progress": 0.0},
  ];

  final List<Map<String, dynamic>> completeCourses = [
    {"progress": 1.0},
    {"progress": 1.0},
    {"progress": 1.0},
  ];

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Courses',
                style: TextFontStyle.headline18w500c222222StyleGTWalsheim,
              ),
              UIHelper.verticalSpace(16.h),

              ///SEARCH TEXTFIELD...
              CustomTextfield(
                hintText: 'Search a certification',
                fillColor: AppColors.white,
                borderRadius: 16.r,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 13),
                  child: SvgPicture.asset(
                    Assets.icons.search,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),

              UIHelper.verticalSpace(24.h),

              ///ONGOING AND COMPLETED BUTTON...
              _buildOngoingAndCompletedButton(),

              ///ONGOING COURSE...
              if (_selectedType == 'Ongoing') _buildOngoingCourseCard(),

              ///ONGOING COURSE...
              if (_selectedType == 'complete') _buildCompletedCourseCard(),
            ],
          ),
        ),
      ),
    );
  }

  ///ONGOING AND COMPLETED BUTTON...
  Widget _buildOngoingAndCompletedButton() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _selectedType = 'Ongoing';
            });
          },
          child: Container(
            height: 39.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            margin: EdgeInsets.only(bottom: 10).h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: _selectedType == 'Ongoing'
                    ? AppColors.c245741
                    : AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: _selectedType == 'Ongoing'
                      ? AppColors.c245741
                      : AppColors.c8C8C8C,
                )),
            child: Text(
              'Ongoing',
              overflow: TextOverflow.ellipsis,
              style:
                  TextFontStyle.textStyle14w500c6B6B6BtyleGTWalsheim.copyWith(
                color: _selectedType == 'Ongoing'
                    ? AppColors.cFFFFFF
                    : AppColors.c8C8C8C,
              ),
            ),
          ),
        ),
        UIHelper.horizontalSpace(8.w),
        InkWell(
          onTap: () {
            setState(() {
              _selectedType = 'complete';
            });
          },
          child: Flexible(
            child: Container(
              height: 39.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              margin: EdgeInsets.only(bottom: 10.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: _selectedType == 'complete'
                      ? AppColors.c245741
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: _selectedType == 'complete'
                        ? AppColors.c245741
                        : AppColors.c8C8C8C,
                  )),
              child: Text(
                'Completed',
                overflow: TextOverflow.ellipsis,
                style:
                    TextFontStyle.textStyle14w500c6B6B6BtyleGTWalsheim.copyWith(
                  color: _selectedType == 'complete'
                      ? AppColors.cFFFFFF
                      : AppColors.c8C8C8C,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///ONGOING COURSE...
  Widget _buildOngoingCourseCard() {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: onGoingCourses.length,
        itemBuilder: (_, index) {
          final course = onGoingCourses[index];
          return Container(
            height: 132.h,
            padding: EdgeInsets.all(8.sp),
            margin: EdgeInsets.only(top: 16.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 130.w,
                  height: 120.h,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                  child: Image.asset(
                    Assets.images.homeCardImage.path,
                    fit: BoxFit.cover,
                  ),
                ),
                UIHelper.horizontalSpace(12.w),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Weekend lessons for children',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style:
                            TextFontStyle.headline20w500c222222StyleGTWalsheim,
                      ),
                      Row(
                        children: [
                          Text("${(course['progress'] * 100).toInt()}%",
                              style: TextFontStyle
                                  .textStyle14w500c6B6B6BtyleGTWalsheim),
                          UIHelper.horizontalSpace(4.w),
                          Expanded(
                            child: LinearProgressIndicator(
                              minHeight: 8.h,
                              value: course['progress'],
                              borderRadius: BorderRadius.circular(10.r),
                              backgroundColor: Colors.grey[300],
                              color: AppColors.c245741,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  ///ONGOING COURSE...
  Widget _buildCompletedCourseCard() {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: completeCourses.length,
        itemBuilder: (_, index) {
          final course = completeCourses[index];
          return Container(
            height: 132.h,
            padding: EdgeInsets.all(8.sp),
            margin: EdgeInsets.only(top: 16.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 130.w,
                  height: 120.h,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                  child: Image.asset(
                    Assets.images.homeCardImage.path,
                    fit: BoxFit.cover,
                  ),
                ),
                UIHelper.horizontalSpace(12.w),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Weekend lessons for children',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style:
                            TextFontStyle.headline20w500c222222StyleGTWalsheim,
                      ),
                      Row(
                        children: [
                          Text("${(course['progress'] * 100).toInt()}%",
                              style: TextFontStyle
                                  .textStyle14w500c6B6B6BtyleGTWalsheim),
                          UIHelper.horizontalSpace(4.w),
                          Expanded(
                            child: LinearProgressIndicator(
                              minHeight: 8.h,
                              value: course['progress'],
                              borderRadius: BorderRadius.circular(10.r),
                              backgroundColor: Colors.grey[300],
                              color: AppColors.c245741,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
