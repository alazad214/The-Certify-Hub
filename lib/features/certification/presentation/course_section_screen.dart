import 'dart:developer';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/certification/model/course_details_response.dart';
import 'package:christiandimene/features/certification/presentation/payment_screen.dart';
import 'package:christiandimene/features/certification/widgets/custom_appbar2.dart';
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
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../constants/app_constants.dart';
import '../../../helpers/di.dart';
import '../model/lesson_model_response.dart';

class CourseSectionScreen extends StatefulWidget {
  CourseModule? courseModule;
  CourseDetailsData? aiData;
  List<Purchase>? purchaseCourse;

  CourseSectionScreen(
      {this.aiData, this.courseModule, this.purchaseCourse, super.key});

  @override
  State<CourseSectionScreen> createState() => _CertificationMainScreenState();
}

class _CertificationMainScreenState extends State<CourseSectionScreen> {
  String? _selectedType;
  RxInt totalViewed = 0.obs;
  bool userHasViewedCourse = false;

  @override
  void initState() {
    super.initState();
    _selectedType = 'lesson';
    getLessonsRxObj.getLessonsData(widget.courseModule!.id!);
    getPdfRxObj.getPdfFile(widget.courseModule!.id!);
  }

  void checkIfUserViewed() {
    if (widget.purchaseCourse!.isNotEmpty &&
        widget.purchaseCourse![0].userId.toString() ==
            appData.read(userId).toString()) {
      userHasViewedCourse = false;
    } else {
      userHasViewedCourse = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    int coursePersentage = widget.courseModule!.completionRate!.toInt();
    int coursePrice = widget.aiData!.coursePrice!.toInt();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(21.h),
              Obx(
                () => CustomAppbar2(
                  title: widget.courseModule!.courseModuleName,
                  subtitle: _selectedType == 'lesson'
                      ? '${totalViewed.value == 0 ? '0' : totalViewed.value}/${widget.courseModule!.lessonCount} Done | '
                      : '',
                  subtitle2: "${coursePersentage}% completed",
                  ontap: () {
                    NavigationService.goBack;
                  },
                ),
              ),
              if (_selectedType == 'lesson') UIHelper.verticalSpace(21.h),
              if (_selectedType == 'lesson')
                CustomAskMeCard(
                  aiText: widget.aiData!.aiName,
                  aiDescription: widget.aiData!.aiDescription,
                  aiImage: widget.aiData!.aiPicture,
                  onTap: () async {
                    if (widget.purchaseCourse!.isEmpty) {
                      Get.snackbar(
                        backgroundColor: Colors.red,
                        'Something went wrong!',
                        'Enroll in this course to get started',
                      );
                    } else {
                      final Uri uri = Uri.parse(widget.aiData!.aiUrl ?? '');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch ${widget.aiData!.aiUrl}';
                      }
                    }
                  },
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
      ),
      bottomSheet: widget.purchaseCourse!.isEmpty
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              height: 95.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${coursePrice} \$',
                    style: TextFontStyle.headline24w700c245741StyleGTWalsheim,
                  ),
                  customButton(
                    minWidth: 170.w,
                    height: 48.h,
                    name: 'Buy Now',
                    onCallBack: () async {
                      try {
                        var paymentResponse = await paymentRxObj.paymentData(
                            courseId: {"course_id": widget.aiData!.id});

                        if (paymentResponse.containsKey("payment_url")) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewScreen(
                                  link: paymentResponse["payment_url"]),
                            ),
                          );
                        } else {
                          Get.snackbar(
                            backgroundColor: Colors.red,
                            'Error',
                            'Something went wrong!',
                          );
                        }
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    context: context,
                  )
                ],
              ),
            )
          : SizedBox.shrink(),
    );
  }

  Widget _buildPDFItem() {
    return StreamBuilder<LessonsModelResponse>(
      stream: getLessonsRxObj.dataFetcher,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            LessonsModelResponse? lessonData = snapshot.data;

            if (lessonData?.data?.contents == null ||
                lessonData?.data?.contents?.isEmpty == true) {
              return Center(child: Text('No content available'));
            } else {
              return ListView.builder(
                itemCount: lessonData?.data?.contents?.length ?? 0,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (_, contentIndex) {
                  CourseContent content =
                      lessonData!.data!.contents![contentIndex];

                  return ListView.builder(
                    itemCount: content.contentFiles!.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, pdfIndex) {
                      ContentFile pdf = content.contentFiles![pdfIndex];

                      return InkWell(
                        onTap: () {
                          if (content.isPurchased == false) {
                            if (content.beforePurchase == 1) {
                              NavigationService.navigateToWithArgs(
                                Routes.pdfViewerScreen,
                                {'pdf': pdf},
                              );
                            } else {
                              Get.snackbar(
                                backgroundColor: Colors.red,
                                'Something went wrong!',
                                'Enroll in this course to get started',
                              );
                            }
                          } else {
                            NavigationService.navigateToWithArgs(
                              Routes.pdfViewerScreen,
                              {'pdf': pdf},
                            );
                          }
                        },
                        child: Container(
                          height: 84.h,
                          padding: EdgeInsets.all(8.sp),
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.images.pdf.path,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 12.h),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pdf.fileUrl!
                                          .split('/')
                                          .last
                                          .split('.')
                                          .first,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextFontStyle
                                          .textStyle16w400c999999StyleGTWalsheim
                                          .copyWith(color: Colors.black),
                                    ),
                                    UIHelper.verticalSpace(5.h),
                                    Row(
                                      children: [
                                        Text(
                                          'PDF',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextFontStyle
                                              .textStyle14w400c9AB2A8StyleGTWalsheim
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              (content.isPurchased == true)
                                  ? Image.asset(
                                      Assets.icons.group1.path,
                                      height: 30.h,
                                      width: 30.w,
                                    )
                                  : content.beforePurchase == 1
                                      ? Image.asset(
                                          Assets.icons.group1.path,
                                          height: 40.h,
                                          width: 30.w,
                                        )
                                      : SvgPicture.asset(
                                          Assets.icons.lockSvg,
                                          height: 30.h,
                                          width: 30.w,
                                        )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
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
              WidgetsBinding.instance.addPostFrameCallback((_) {
                totalViewed.value = lessonData!.data!.contents!
                    .where((content) => content.viewed == true)
                    .length;
              });

              if (lessonData!.data == null ||
                  lessonData.data!.contents!.isEmpty) {
                return Center(child: Text('No Lessons available'));
              } else {
                return ListView.builder(
                    itemCount: lessonData.data!.contents!.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, index) {
                      CourseContent? data;
                      data = lessonData.data!.contents![index];

                      return InkWell(
                        onTap: () {
                          if (data!.isPurchased == false) {
                            if (data.beforePurchase == 1) {
                              NavigationService.navigateToWithArgs(
                                Routes.videoPlayerScreen,
                                {
                                  'data': data,
                                  'lessonData': lessonData,
                                  'module': widget.courseModule
                                },
                              );
                            } else {
                              Get.snackbar(
                                backgroundColor: Colors.red,
                                'Something went wrong!',
                                'Enroll in this course to get started',
                              );
                            }
                          } else {
                            NavigationService.navigateToWithArgs(
                              Routes.videoPlayerScreen,
                              {
                                'data': data,
                                'lessonData': lessonData,
                                'module': widget.courseModule
                              },
                            );
                          }
                        },
                        child: Container(
                          height: 115.h,
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
                                  Assets.images.contentCard.path,
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
                                            data.contentTitle ?? '',
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
                                            data.contentLength!,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextFontStyle
                                                .textStyle14w400c9AB2A8StyleGTWalsheim
                                                .copyWith(
                                              color: AppColors.c8C8C8C,
                                            ),
                                          ),
                                        ),
                                        data.viewed == true
                                            ? Container(
                                                width: 1.w,
                                                height: 12.h,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 8.w),
                                                color: AppColors.c8C8C8C,
                                              )
                                            : SizedBox.shrink(),
                                        Flexible(
                                          child: Text(
                                            data.viewed == true ? "Viewed" : "",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextFontStyle
                                                .textStyle14w400c9AB2A8StyleGTWalsheim
                                                .copyWith(color: Colors.green),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              (data.isPurchased == true)
                                  ? SvgPicture.asset(
                                      Assets.icons.playButtonContainer,
                                      height: 30.h,
                                      width: 30.w,
                                    )
                                  : data.beforePurchase == 1
                                      ? SvgPicture.asset(
                                          Assets.icons.playButtonContainer,
                                          height: 30.h,
                                          width: 30.w,
                                        )
                                      : SvgPicture.asset(
                                          Assets.icons.lockSvg,
                                          height: 30.h,
                                          width: 30.w,
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
                  color: _selectedType == 'lesson'
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
