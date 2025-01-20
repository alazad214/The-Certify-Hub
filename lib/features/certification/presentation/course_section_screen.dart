import 'dart:developer';

import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/certification/model/course_details_response.dart';
import 'package:christiandimene/features/certification/model/pdf_model_response.dart';
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
                          // Open WebView with payment URL

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
                          // Use Stripe Payment Sheet
                          // await stripePaymentSheet(
                          //     orderId: widget.data!.id,
                          //     paymentIntentClientSecret:
                          //         paymentResponse["client_secret"]);
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

  // Future<void> stripePaymentSheet(
  //     {required String paymentIntentClientSecret,
  //     required dynamic orderId}) async {
  //   await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //     paymentIntentClientSecret: paymentIntentClientSecret,
  //     merchantDisplayName: 'Service Booking',
  //   ));

  //   await Stripe.instance.presentPaymentSheet().then((value) async {
  //     if (value == null) {
  //       NavigationService.navigateToUntilReplacement(Routes.bottomNavBarScreen);

  //       Get.snackbar(
  //           backgroundColor: Colors.green, 'Successfull', 'Payment Success');
  //     }
  //   }).catchError((e) {
  //     log(e.toString());
  //     Get.snackbar(
  //         backgroundColor: Colors.red,
  //         'Something went Wrong',
  //         'Payment Failed');
  //   });
  // }

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
                      log(pdf.filePath.toString());

                      return InkWell(
                        onTap: () {
                          if (widget.purchaseCourse!.isEmpty) {
                            Get.snackbar(
                              backgroundColor: Colors.red,
                              'Something went wrong!',
                              'Enroll in this course to get started',
                            );
                          } else {
                            NavigationService.navigateToWithArgs(
                                Routes.pdfViewerScreen, {'data': pdf});
                          }
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
                                      pdf.filePath!.split('/').last,
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
                          if (data!.status == '1') {
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
