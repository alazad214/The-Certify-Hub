import 'package:cached_network_image/cached_network_image.dart';
import 'package:christiandimene/common_widgets/custom_textfeild.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/my_course/model/purchase_course_response.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../networks/api_acess.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  String? _selectedType;
  PurchaseCourseData? data;

  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedType = 'Ongoing';
    getPurchaseCourseRxObj.GetCourseData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

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

              // SEARCH TEXTFIELD...
              CustomTextfield(
                controller: _searchController,
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

              // ONGOING AND COMPLETED BUTTON...
              _buildOngoingAndCompletedButton(),

              /// ONGOING COURSE...
              if (_selectedType == 'Ongoing')
                StreamBuilder(
                  stream: getPurchaseCourseRxObj.getCourse,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        PurchasedCourseResponse courseData = snapshot.data;

                        if (courseData.data == null ||
                            courseData.data!.isEmpty) {
                          return Center(child: Text('No courses available'));
                        } else {
                          List<PurchaseCourseData> coursesToShow = courseData
                              .data!
                              .where((course) =>
                                  course.progressRate! < 100 &&
                                  (course.courseTitle!
                                      .toLowerCase()
                                      .contains(_searchQuery)))
                              .toList();
                          return ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: coursesToShow.length,
                              itemBuilder: (_, index) {
                                data = coursesToShow[index];
                                return InkWell(
                                  onTap: () {
                                    // NavigationService.navigateToWithArgs(
                                    //     Routes.certificationScreen,
                                    //     {'data': data});
                                  },
                                  child: Container(
                                    height: 100.h,
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
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: baseUrl +
                                                data!.courseFeatureImage
                                                    .toString(),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        UIHelper.horizontalSpace(12.w),
                                        Flexible(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data!.courseTitle.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextFontStyle
                                                    .headline20w500c222222StyleGTWalsheim,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${data!.progressRate.toString()}%',
                                                    style: TextFontStyle
                                                        .textStyle14w500c6B6B6BtyleGTWalsheim,
                                                  ),
                                                  UIHelper.horizontalSpace(4.w),
                                                  Expanded(
                                                    child:
                                                        LinearProgressIndicator(
                                                      minHeight: 8.h,
                                                      value:
                                                          data!.progressRate! /
                                                              100.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                      backgroundColor:
                                                          Colors.grey[300],
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
                                  ),
                                );
                              });
                        }
                      } else {
                        return const SizedBox.shrink();
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),

              // COMPLETED COURSE...
              if (_selectedType == 'complete')
                StreamBuilder(
                  stream: getPurchaseCourseRxObj.getCourse,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        PurchasedCourseResponse courseData = snapshot.data;

                        if (courseData.data == null ||
                            courseData.data!.isEmpty) {
                          return Center(child: Text('No courses available'));
                        } else {
                          List<PurchaseCourseData> coursesToShow = courseData
                              .data!
                              .where((course) =>
                                  course.progressRate! == 100 &&
                                  (course.courseTitle!
                                      .toLowerCase()
                                      .contains(_searchQuery)))
                              .toList();
                          return ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: coursesToShow.length,
                              itemBuilder: (_, index) {
                                data = coursesToShow[index];
                                return InkWell(
                                  onTap: () {
                                    // NavigationService.navigateToWithArgs(
                                    //     Routes.certificationScreen,
                                    //     {'data': data});
                                  },
                                  child: Container(
                                    height: 100.h,
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
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: baseUrl +
                                                data!.courseFeatureImage
                                                    .toString(),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        UIHelper.horizontalSpace(12.w),
                                        Flexible(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data!.courseTitle.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextFontStyle
                                                    .headline20w500c222222StyleGTWalsheim,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${data!.progressRate.toString()}%',
                                                    style: TextFontStyle
                                                        .textStyle14w500c6B6B6BtyleGTWalsheim,
                                                  ),
                                                  UIHelper.horizontalSpace(4.w),
                                                  Expanded(
                                                    child:
                                                        LinearProgressIndicator(
                                                      minHeight: 8.h,
                                                      value:
                                                          data!.progressRate! /
                                                              100.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                      backgroundColor:
                                                          Colors.grey[300],
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
                                  ),
                                );
                              });
                        }
                      } else {
                        return const SizedBox.shrink();
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),

              UIHelper.verticalSpace(26.h),
            ],
          ),
        ),
      ),
    );
  }

  // ONGOING AND COMPLETED BUTTON...
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
      ],
    );
  }
}
