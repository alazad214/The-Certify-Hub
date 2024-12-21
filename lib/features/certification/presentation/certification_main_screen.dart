import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/app_constants.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/certification/model/mock_test_response.dart';
import 'package:christiandimene/features/home/model/course_response.dart';
import 'package:christiandimene/features/widgets/custom_ask_me_card.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/di.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:christiandimene/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();
    _selectedType = 'data';

    getCourseDetailsRxObj.getCourseDetailsdata(widget.data!.id);
    getMockTestRxObj.getMockTest(widget.data!.id);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: widget.data!.courseTitle,
        onCallBack: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          children: [
            _buildHeaderCard(),
            UIHelper.verticalSpace(24.h),
            CustomAskMeCard(),
            UIHelper.verticalSpace(25.h),
            _buildCourseAndTestButton(),
            UIHelper.verticalSpace(16.h),
            if (_selectedType == 'data') _buildCourseItem(),
            if (_selectedType == 'test') _buildMockTestItem(),
            UIHelper.verticalSpace(100.h),
          ],
        ),
      ),
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

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Payment Success'.toUpperCase(),
                  style: TextStyle(fontSize: 18.sp, color: Colors.green))),
        );
      }
    }).catchError((e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Payment Failed',
                style: TextStyle(fontSize: 18.sp, color: Colors.red))),
      );
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
              return Center(child: Text("Error: ${snapshot.error}"));
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
                            Get.snackbar('Something wrong',
                                'Enroll in this course then start');
                          } else {
                            if (purchaseCourse[0].courseId.toString() ==
                                widget.data!.id.toString()) {
                              if (purchaseCourse[0].userId.toString() ==
                                  appData.read(userId).toString()) {
                                mockTestPopup(
                                  context,
                                  () {},
                                  () {
                                    
                                  },
                                );
                              } else {
                                Get.snackbar(
                                    'Something wrong', 'No Course Found');
                              }
                            } else {
                              Get.snackbar(
                                  'Something wrong', 'No Course Found');
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
                      final CourseModule? data =
                          courseData.data!.courseModules![index];
                      return InkWell(
                        onTap: () {
                          if (purchaseCourse.isEmpty) {
                            Get.snackbar('Something wrong',
                                'Enroll in this course then start');
                          } else {
                            if (purchaseCourse[0].courseId.toString() ==
                                widget.data!.id.toString()) {
                              if (purchaseCourse[0].userId.toString() ==
                                  appData.read(userId).toString()) {
                                NavigationService.navigateToWithArgs(
                                    Routes.certificationSectionScreen,
                                    {'data': data});
                              } else {
                                Get.snackbar(
                                    'Something wrong', 'No Course Found');
                              }
                            } else {
                              Get.snackbar(
                                  'Something wrong', 'No Course Found');
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
                                        data!.courseModuleName.toString(),
                                        style: TextFontStyle
                                            .headline18w500c222222StyleGTWalsheim,
                                      ),
                                      UIHelper.verticalSpace(8.h),
                                      Row(
                                        children: [
                                          Text(
                                            "Lessons: ${data.lessonCount}",
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
                        imageUrl: baseUrl + data!.courseFeatureImage!,
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
                            data.courseTitle!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextFontStyle
                                .headline20w500c222222StyleGTWalsheim,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Duration: ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextFontStyle
                                      .textStyle16w400c999999StyleGTWalsheim
                                      .copyWith(color: AppColors.c8C8C8C),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  data.duration!,
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
