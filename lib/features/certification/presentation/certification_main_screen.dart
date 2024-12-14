import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/home/model/course_response.dart';
import 'package:christiandimene/features/widgets/custom_ask_me_card.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/course_details_response.dart';

class CertificationMainScreen extends StatefulWidget {
  Course? data;

  CertificationMainScreen({required this.data, super.key});

  @override
  State<CertificationMainScreen> createState() =>
      _CertificationMainScreenState();
}

class _CertificationMainScreenState extends State<CertificationMainScreen> {
  String url = "https://christiandimene.reigeeky.com/";

  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = 'data';
    getCourseDetailsRxObj.getCourseDetailsdata(widget.data!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Certification Details',
        onCallBack: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          children: [
            ///build header card...
            _buildHeaderCard(),
            UIHelper.verticalSpace(24.h),

            ///custom ask me card...
            CustomAskMeCard(),
            UIHelper.verticalSpace(25.h),

            ///toggle data and mock tests button....
            _buildCourseAndTestButton(),

            UIHelper.verticalSpace(16.h),

            ///build data item....
            if (_selectedType == 'data') _buildCourseItem(),

            ///build mock tests item....
            if (_selectedType == 'test') _buildMockTestItem(),

            UIHelper.verticalSpace(100.h),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        height: 95.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '50.00 ${'\$'}',
              style: TextFontStyle.headline24w700c245741StyleGTWalsheim,
            ),
            customButton(
                minWidth: 170.w,
                height: 48.h,
                name: 'Buy Now',
                onCallBack: () {},
                context: context)
          ],
        ),
      ),
    );
  }

  ///toggle data and mock tests button....
  Widget _buildCourseAndTestButton() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedType = 'data';
              });
            },
            child: Container(
              height: 48.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: _selectedType == 'data'
                      ? AppColors.c245741
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: _selectedType == 'data'
                        ? AppColors.c245741
                        : AppColors.c8C8C8C,
                  )),
              child: Text(
                'Course',
                overflow: TextOverflow.ellipsis,
                style:
                    TextFontStyle.headline18w500c222222StyleGTWalsheim.copyWith(
                  color: _selectedType == 'data'
                      ? AppColors.cFFFFFF
                      : AppColors.c8C8C8C,
                ),
              ),
            ),
          ),
        ),
        UIHelper.horizontalSpace(12.w),
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedType = 'test';
              });
            },
            child: Container(
              height: 48.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: _selectedType == 'test'
                      ? AppColors.c245741
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: _selectedType == 'test'
                        ? AppColors.c245741
                        : AppColors.c8C8C8C,
                  )),
              child: Text(
                'Mock Tests',
                overflow: TextOverflow.ellipsis,
                style:
                    TextFontStyle.headline18w500c222222StyleGTWalsheim.copyWith(
                  color: _selectedType == 'test'
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

  ///build mock tests item....
  Widget _buildMockTestItem() {
    return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              NavigationService.navigateTo(Routes.mockTestSectionScreen);
            },
            child: Container(
                alignment: Alignment.center,
                height: 84.h,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.white),
                child: Row(
                  children: [
                    Container(
                      height: 52.h,
                      width: 52.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.cFAFBFC,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2.sp,
                            blurRadius: 8.sp,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '01',
                        style: TextFontStyle
                            .headline24w400c222222StyleGTWalsheim
                            .copyWith(color: AppColors.c245741),
                      ),
                    ),
                    UIHelper.horizontalSpace(8.w),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            'Managing Your Time WiselyManaging Your Time Wisel',
                            style: TextFontStyle
                                .headline18w500c222222StyleGTWalsheim,
                          ),
                          UIHelper.verticalSpace(8.h),
                          Row(
                            children: [
                              Text(
                                '79 tests',
                                overflow: TextOverflow.ellipsis,
                                style: TextFontStyle
                                    .textStyle12w400c9AB2A8StyleGTWalsheim
                                    .copyWith(
                                  color: AppColors.c8C8C8C,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          );
        });
  }

  ///build data item....

  Widget _buildCourseItem() {
    return StreamBuilder(
        stream: getCourseDetailsRxObj.getCourseDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              CourseDetailsResponse courseData = snapshot.data;

              if (courseData.data == null ||
                  courseData.data!.courseModules.isEmpty) {
                return Center(child: Text('No courses available'));
              } else {
                return ListView.builder(
                    itemCount: courseData.data!.courseModules.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, index) {
                      final CourseModule? data;
                      data = courseData.data!.courseModules[index];
                      log(data.id.toString());
                      log("========================certification main screen pass id============================");

                      return InkWell(
                        onTap: () {
                          NavigationService.navigateToWithArgs(
                              Routes.certificationSectionScreen,
                              {'data': data});
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 84.h,
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: AppColors.white),
                            child: Row(
                              children: [
                                Container(
                                  height: 52.h,
                                  width: 52.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.cFAFBFC,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 2.sp,
                                        blurRadius: 8.sp,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    data.lessonCount.toString(),
                                    style: TextFontStyle
                                        .headline24w400c222222StyleGTWalsheim
                                        .copyWith(
                                      color: AppColors.c245741,
                                    ),
                                  ),
                                ),
                                UIHelper.horizontalSpace(8.w),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        data.courseModuleName,
                                        style: TextFontStyle
                                            .headline18w500c222222StyleGTWalsheim,
                                      ),
                                      UIHelper.verticalSpace(8.h),
                                      Row(
                                        children: [
                                          Text(
                                            '79 Lessons',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextFontStyle
                                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                                .copyWith(
                                              color: AppColors.c8C8C8C,
                                            ),
                                          ),
                                          Container(
                                            width: 2.w,
                                            height: 12.h,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            color: AppColors.c8C8C8C,
                                          ),
                                          Text(
                                            '3 Pdf',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextFontStyle
                                                .textStyle14w400c9AB2A8StyleGTWalsheim
                                                .copyWith(
                                                    color: AppColors.c8C8C8C),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      );
                    });
              }
            } else {
              return const SizedBox.shrink();
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  ///build header card....
  Widget _buildHeaderCard() {
    return StreamBuilder(
        stream: getCourseDetailsRxObj.dataFetcher,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              CourseDetailsData? data = snapshot.data!.data;
              return Container(
                height: 132.h,
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 130.w,
                      height: 120.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r)),
                      child: CachedNetworkImage(
                        imageUrl: url + data!.courseFeatureImage,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                    UIHelper.horizontalSpace(12.w),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.courseTitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextFontStyle
                                .headline20w500c222222StyleGTWalsheim,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '79 Lessons',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextFontStyle
                                      .textStyle14w400c9AB2A8StyleGTWalsheim
                                      .copyWith(color: AppColors.c8C8C8C),
                                ),
                              ),
                              Container(
                                width: 2.w,
                                height: 12.h,
                                margin: EdgeInsets.symmetric(horizontal: 5.w),
                                color: AppColors.c8C8C8C,
                              ),
                              Expanded(
                                child: Text(
                                  '8,289 Students',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextFontStyle
                                      .textStyle14w400c9AB2A8StyleGTWalsheim
                                      .copyWith(color: AppColors.c8C8C8C),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}



/*
 
  */