import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/certification/model/course_details_response.dart';
import 'package:christiandimene/features/certification/model/pdf_model_response.dart';
import 'package:christiandimene/features/widgets/custom_ask_me_card.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../model/lesson_model_response.dart';

class CourseSectionScreen extends StatefulWidget {
  CourseModule? data;
  CourseDetailsData? aiData;
  CourseSectionScreen({this.aiData, this.data, super.key});

  @override
  State<CourseSectionScreen> createState() => _CertificationMainScreenState();
}

class _CertificationMainScreenState extends State<CourseSectionScreen> {
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = 'lesson';
    getLessonsRxObj.getLessonsData(widget.data!.id!);
    getPdfRxObj.getPdfFile(widget.data!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: widget.data!.courseModuleName!,
        onCallBack: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // UIHelper.verticalSpace(21.h),
            // CustomAppbar2(
            //   title: 'Managing Your Time Wisely',
            //   subtitle:
            //       _selectedType == 'lesson' ? '0/5 lesson(s) completed' : '',
            //   ontap: () {
            //     // NavigationService.navigateToReplacement(
            //     //     Routes.certificationScreen);
            //     NavigationService.goBack;
            //   },
            // ),

            if (_selectedType == 'lesson') UIHelper.verticalSpace(21.h),
            if (_selectedType == 'lesson')
              CustomAskMeCard(
                aiText: widget.aiData!.aiName,
                aiDescription: widget.aiData!.aiDescription,
                aiImage: widget.aiData!.aiPicture,
                aiUrl: widget.aiData!.aiUrl,
              ),

            UIHelper.verticalSpace(25.h),

            _buildCourseAndTestButton(),

            UIHelper.verticalSpace(16.h),

            if (_selectedType == 'lesson') _buildLessonItem(),

            if (_selectedType == 'pdf') _buildPDFItem(),
            UIHelper.verticalSpace(120.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPDFItem() {
    return StreamBuilder(
        stream: getPdfRxObj.getPdfData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              PdfModelResponse? pdfData = snapshot.data;

              if (pdfData!.data!.files == null ||
                  pdfData.data!.files!.isEmpty) {
                return Center(child: Text('No pdf available'));
              } else {
                return ListView.builder(
                    itemCount: pdfData.data!.files!.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, index) {
                      FileElement? pdf;
                      pdf = pdfData.data!.files![index];

                      return InkWell(
                        onTap: () {
                          NavigationService.navigateToWithArgs(
                              Routes.pdfViewerScreen, {'data': pdf});
                        },
                        child: Container(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Document- ${index + 1}",
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
                                                .copyWith(
                                                    color: AppColors.c8C8C8C),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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

  Widget _buildLessonItem() {
    return StreamBuilder(
        stream: getLessonsRxObj.dataFetcher,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              LessonsModelResponse? lessonData = snapshot.data;
              ;

              if (lessonData!.data == null ||
                  lessonData.data!.courseContents.isEmpty) {
                return Center(child: Text('No Lessons available'));
              } else {
                return ListView.builder(
                    itemCount: lessonData.data!.courseContents.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, index) {
                      CourseContent? data;
                      data = lessonData.data!.courseContents[index];

                      return InkWell(
                        onTap: () {
                          NavigationService.navigateToWithArgs(
                              Routes.videoPlayerScreen, {'data': data});
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
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: Image.asset(
                                  Assets.images.homeCardImage.path,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              UIHelper.horizontalSpace(12.w),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data.contentTitle,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextFontStyle
                                                .headline20w500c222222StyleGTWalsheim,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Video',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextFontStyle
                                                .textStyle14w400c9AB2A8StyleGTWalsheim
                                                .copyWith(
                                              color: AppColors.c8C8C8C,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 1.w,
                                          height: 12.h,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          color: AppColors.c8C8C8C,
                                        ),
                                        Flexible(
                                          child: Text(
                                            data.contentLength,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextFontStyle
                                                .textStyle14w400c9AB2A8StyleGTWalsheim
                                                .copyWith(
                                                    color: AppColors.c8C8C8C),
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

                                  // Container(
                                      //   width: 2.w,
                                      //   height: 12.h,
                                      //   margin: EdgeInsets.symmetric(
                                      //       horizontal: 8.w),
                                      //   color: AppColors.c8C8C8C,
                                      // ),
                                      // Flexible(
                                      //   child: Text(
                                      //     '2 pages',
                                      //     overflow: TextOverflow.ellipsis,
                                      //     style: TextFontStyle
                                      //         .textStyle14w400c9AB2A8StyleGTWalsheim
                                      //         .copyWith(
                                      //             color: AppColors.c8C8C8C),
                                      //   ),
                                      // ),
