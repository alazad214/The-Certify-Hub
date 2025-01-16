import 'dart:developer';
import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/app_constants.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/certification/model/mock_test_response.dart';
import 'package:christiandimene/features/certification/widgets/build_header_card.dart';
import 'package:christiandimene/features/home/model/course_response.dart';
import 'package:christiandimene/features/widgets/custom_ask_me_card.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/di.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:christiandimene/networks/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/mock_test_popup.dart';
import '../model/course_details_response.dart';

class CertificationMainScreen extends StatefulWidget {
  Course? data;

  CertificationMainScreen({required this.data, super.key});

  @override
  State<CertificationMainScreen> createState() =>
      _CertificationMainScreenState();
}

class _CertificationMainScreenState extends State<CertificationMainScreen> {
  String? _selectedType;
  List<Purchase> purchaseCourse = [];
  bool userHasViewedCourse = false;
  CourseDetailsData? data;
  bool _isCouponApplied = false;
  String _couponCode = '';
  double _discountAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _selectedType = 'data';

    getCourseDetailsRxObj.getCourseDetailsdata(widget.data!.id);
    getMockTestRxObj.getMockTest(widget.data!.id);
    // getTrackContentRxObj.gettrackContent(appData.read(userId), coursedata!.id!);
    purchaseCourse;
    checkIfUserViewed();
  }

  void checkIfUserViewed() {
    if (purchaseCourse.isNotEmpty &&
        purchaseCourse[0].userId.toString() ==
            appData.read(userId).toString()) {
      userHasViewedCourse = false;
    } else {
      userHasViewedCourse = true;
    }
  }

  @override
  void dispose() {
    getCourseDetailsRxObj.getCourseDetailsdata(widget.data!.id);
    getMockTestRxObj.getMockTest(widget.data!.id);
    // getTrackContentRxObj.gettrackContent(appData.read(userId), coursedata!.id!);
    purchaseCourse;
    checkIfUserViewed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: widget.data!.courseTitle,
        onCallBack: () {
          NavigationService.navigateToUntilReplacement(
              Routes.bottomNavBarScreen);
        },
      ),
      body: StreamBuilder(
          stream: getCourseDetailsRxObj.dataFetcher,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (snapshot.hasData) {
                data = snapshot.data!.data;
                return SingleChildScrollView(
                  padding: EdgeInsets.all(24.sp),
                  child: Column(
                    children: [
                      ///COURSE DETAILS HEADER=====>>>
                      BuildHeaderCard(
                        image: baseUrl + data!.courseFeatureImage!,
                        courseTitle: data!.courseTitle!,
                        duration: data!.duration!,
                      ),
                      UIHelper.verticalSpace(24.h),
                      CustomAskMeCard(
                        aiText: data!.aiName,
                        aiDescription: data!.aiDescription,
                        aiImage: data!.aiPicture,
                        onTap: () async {
                          if (purchaseCourse.isEmpty) {
                            Get.snackbar(
                              backgroundColor: Colors.red,
                              'Something went wrong!',
                              'Enroll in this course to get started',
                            );
                          } else {
                            final Uri uri = Uri.parse(data!.aiUrl ?? '');
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              throw 'Could not launch ${data!.aiUrl}';
                            }
                          }
                        },
                      ),
                      UIHelper.verticalSpace(25.h),
                      _buildCourseAndTestButton(),
                      UIHelper.verticalSpace(16.h),
                      if (_selectedType == 'data') _buildCourseItem(),
                      if (_selectedType == 'test') _buildMockTestItem(),
                      UIHelper.verticalSpace(100.h),
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
          }),
      bottomSheet: userHasViewedCourse && purchaseCourse.isEmpty
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              height: 95.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.data!.coursePrice} \$',
                    style: TextFontStyle.headline24w700c245741StyleGTWalsheim,
                  ),
                  customButton(
                    minWidth: 170.w,
                    height: 48.h,
                    name: 'Buy Now',
                    onCallBack: () async {
                      try {
                        var paymentResponse = await paymentRxObj.paymentData(
                            courseId: {"course_id": widget.data!.id});
                        await stripePaymentSheet(
                            orderId: widget.data!.id,
                            paymentIntentClientSecret:
                                paymentResponse["client_secret"]);
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

  Future<void> stripePaymentSheet(
      {required String paymentIntentClientSecret,
      required dynamic orderId}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClientSecret,
      merchantDisplayName: 'Service Booking',
    ));

    await Stripe.instance.presentPaymentSheet().then((value) async {
      if (value == null) {
        NavigationService.navigateToUntilReplacement(Routes.bottomNavBarScreen);

        Get.snackbar(
            backgroundColor: Colors.green, 'Successfull', 'Payment Success');
      }
    }).catchError((e) {
      log(e.toString());
      Get.snackbar(
          backgroundColor: Colors.red,
          'Something went Wrong',
          'Payment Failed');
    });
  }

  ///COURSE AND MOCK TEST--->>
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

  ///BUILD MOCK TEST ITEM--->
  Widget _buildMockTestItem() {
    return StreamBuilder(
        stream: getMockTestRxObj.getMockTestData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) {
              DioException errorRes = snapshot.error as DioException;
              return Center(
                  child: Text("Error: ${errorRes.response!.statusMessage}"));
            } else if (snapshot.hasData) {
              MockTestResponse mockTest = snapshot.data;

              if (mockTest.data == null || mockTest.data!.quizzes!.isEmpty) {
                return Center(child: Text('No mock test available'));
              } else {
                return ListView.builder(
                    itemCount: mockTest.data!.quizzes!.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, index) {
                      QuizData? quiz;
                      quiz = mockTest.data!.quizzes![index];
                      return InkWell(
                        onTap: () {
                          if (purchaseCourse.isEmpty) {
                            Get.snackbar(
                              backgroundColor: Colors.red,
                              'Something went wrong!',
                              'Enroll in this course to get started',
                            );
                          } else {
                            if (purchaseCourse[0].courseId.toString() ==
                                widget.data!.id.toString()) {
                              if (purchaseCourse[0].userId.toString() ==
                                  appData.read(userId).toString()) {
                                mockTestPopup(
                                  context,
                                  () {
                                    NavigationService.navigateToWithArgs(
                                        Routes.practiceExamInstruction, {
                                      'data': quiz,
                                      'courseId': widget.data
                                    });
                                  },
                                  () {
                                    NavigationService.navigateToWithArgs(
                                        Routes.testExamInstructionScreen, {
                                      'data': quiz,
                                      'courseId': widget.data
                                    });
                                  },
                                );
                              } else {
                                Get.snackbar(
                                    backgroundColor: Colors.red,
                                    'Something went wrong!',
                                    'No Course Found');
                              }
                            } else {
                              Get.snackbar(
                                  backgroundColor: Colors.red,
                                  'Something went wrong!',
                                  'No Course Found');
                            }
                          }
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
                                    "${index + 1}",
                                    style: TextFontStyle
                                        .headline24w400c222222StyleGTWalsheim
                                        .copyWith(color: AppColors.c245741),
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
                                        "${quiz.title}",
                                        style: TextFontStyle
                                            .headline18w500c222222StyleGTWalsheim,
                                      ),
                                      UIHelper.verticalSpace(8.h),
                                      Row(
                                        children: [
                                          Text(
                                            "${quiz.totalTime} Min",
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

  Widget _buildCourseItem() {
    return StreamBuilder(
        stream: getCourseDetailsRxObj.getCourseDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              CourseDetailsResponse courseData = snapshot.data;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  purchaseCourse = courseData.data!.purchases!;
                });
              });

              if (courseData.data == null ||
                  courseData.data!.courseModules!.isEmpty) {
                return Center(child: Text('No courses available'));
              } else {
                return ListView.builder(
                    itemCount: courseData.data!.courseModules!.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, index) {
                      CourseModule? coursedata =
                          courseData.data!.courseModules![index];

                      int coursePersentage = coursedata.completionRate!.toInt();
                      return InkWell(
                        onTap: () {
                          // if (courseData.data!.purchases!.isEmpty) {

                          // } else {
                          //   if (purchaseCourse[0].courseId.toString() ==
                          //       widget.data!.id.toString()) {
                          //     if (purchaseCourse[0].userId.toString() ==
                          //         appData.read(userId).toString()) {
                          //       NavigationService.navigateToWithArgs(
                          //           Routes.certificationSectionScreen,
                          //           {'data': coursedata, 'aidata': data});
                          //     } else {
                          //       Get.snackbar(
                          //         backgroundColor: Colors.red,
                          //         'Something went wrong!',
                          //         'No Course Found',
                          //       );
                          //     }
                          //   } else {
                          //     Get.snackbar(
                          //       backgroundColor: Colors.red,
                          //       'Something went wrong!',
                          //       'No Course Found',
                          //     );
                          //   }
                          // }
                          NavigationService.navigateToWithArgs(
                              Routes.certificationSectionScreen, {
                            'data': coursedata,
                            'aidata': data,
                            'userHasViewedCourse': userHasViewedCourse,
                            'purchaseCourse': purchaseCourse
                          });
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 84.h,
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: AppColors.white,
                            ),
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
                                    "${index + 1}",
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
                                        coursedata.courseModuleName.toString(),
                                        style: TextFontStyle
                                            .headline18w500c222222StyleGTWalsheim,
                                      ),
                                      UIHelper.verticalSpace(8.h),
                                      Row(
                                        children: [
                                          Text(
                                            "Lessons: ${coursedata.lessonCount}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextFontStyle
                                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                                .copyWith(
                                              color: AppColors.c8C8C8C,
                                            ),
                                          ),
                                          Container(
                                            width: 1.w,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            height: 10.h,
                                            color: AppColors.c8C8C8C,
                                          ),
                                          Text(
                                            " ${coursePersentage}% Completed",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextFontStyle
                                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                                .copyWith(
                                              color: Colors.green,
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
