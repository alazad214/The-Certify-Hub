import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/certification/widgets/custom_appbar2.dart';
import 'package:christiandimene/features/widgets/custom_ask_me_card.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CourseSectionScreen extends StatefulWidget {
  const CourseSectionScreen({super.key});

  @override
  State<CourseSectionScreen> createState() => _CertificationMainScreenState();
}

class _CertificationMainScreenState extends State<CourseSectionScreen> {
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = 'lesson';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(21.h),
              CustomAppbar2(
                title: 'Managing Your Time Wisely',
                subtitle:
                    _selectedType == 'lesson' ? '0/5 lesson(s) completed' : '',
                ontap: () {
                  NavigationService.navigateToReplacement(
                      Routes.certificationScreen);
                },
              ),

              if (_selectedType == 'lesson') UIHelper.verticalSpace(21.h),
              if (_selectedType == 'lesson') CustomAskMeCard(),

              UIHelper.verticalSpace(25.h),

              ///toggle button....
              _buildCourseAndTestButton(),

              UIHelper.verticalSpace(16.h),

              ///build lesson item....
              if (_selectedType == 'lesson') _buildLessonItem(),

              ///build pdf item....
              if (_selectedType == 'pdf') _buildPDFItem(),
              UIHelper.verticalSpace(120.h),
            ],
          ),
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

  ListView _buildPDFItem() {
    return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (_, index) {
          return Container(
            height: 84.h,
            padding: EdgeInsets.all(8.sp),
            margin: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Image.asset(
                  Assets.images.pdf.path,
                  fit: BoxFit.cover,
                ),
                UIHelper.horizontalSpace(12.w),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekend lessons for children',
                        overflow: TextOverflow.ellipsis,
                        style: TextFontStyle
                            .textStyle16w400c999999StyleGTWalsheim
                            .copyWith(color: AppColors.c222222),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'PDFs',
                              overflow: TextOverflow.ellipsis,
                              style: TextFontStyle
                                  .textStyle14w400c9AB2A8StyleGTWalsheim
                                  .copyWith(color: AppColors.c8C8C8C),
                            ),
                          ),
                          Container(
                            width: 2.w,
                            height: 12.h,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            color: AppColors.c8C8C8C,
                          ),
                          Flexible(
                            child: Text(
                              '2 pages',
                              overflow: TextOverflow.ellipsis,
                              style: TextFontStyle
                                  .textStyle14w400c9AB2A8StyleGTWalsheim
                                  .copyWith(color: AppColors.c8C8C8C),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildLessonItem() {
    return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              NavigationService.navigateTo(Routes.videoPlayerScreen);
            },
            child: Container(
              height: 93.h,
              padding: EdgeInsets.all(8.sp),
              margin: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 103.w,
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
                          style: TextFontStyle
                              .headline20w500c222222StyleGTWalsheim,
                        ),
                        Row(
                          children: [
                            Flexible(
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
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              color: AppColors.c8C8C8C,
                            ),
                            Flexible(
                              child: Text(
                                '8,289 Students',
                                overflow: TextOverflow.ellipsis,
                                style: TextFontStyle
                                    .textStyle14w400c9AB2A8StyleGTWalsheim
                                    .copyWith(color: AppColors.c8C8C8C),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    Assets.icons.playButtonContainer,
                    height: 30.h,
                    width: 30.w,
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///toggle course and mock tests button....
  Widget _buildCourseAndTestButton() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedType = 'lesson';
              });
            },
            child: Container(
              height: 48.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: _selectedType == 'lesson'
                      ? AppColors.c245741
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: _selectedType == 'lesson'
                        ? AppColors.c245741
                        : AppColors.c8C8C8C,
                  )),
              child: Text(
                'Lessons',
                overflow: TextOverflow.ellipsis,
                style:
                    TextFontStyle.headline18w500c222222StyleGTWalsheim.copyWith(
                  color: _selectedType == 'lesson        '
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
                _selectedType = 'pdf';
              });
            },
            child: Container(
              height: 48.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: _selectedType == 'pdf'
                      ? AppColors.c245741
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: _selectedType == 'pdf'
                        ? AppColors.c245741
                        : AppColors.c8C8C8C,
                  )),
              child: Text(
                'PDFs',
                overflow: TextOverflow.ellipsis,
                style:
                    TextFontStyle.headline18w500c222222StyleGTWalsheim.copyWith(
                  color: _selectedType == 'pdf'
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
}
