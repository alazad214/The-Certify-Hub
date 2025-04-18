import 'dart:developer';

import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/certification/model/mock_test_response.dart';
import 'package:christiandimene/features/home/model/course_response.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/all_routes.dart';

class PracticeExamInstructionScreen extends StatefulWidget {
  QuizData? quiz;
  Course? data;

  PracticeExamInstructionScreen({this.data, this.quiz, super.key});

  @override
  State<PracticeExamInstructionScreen> createState() =>
      _PracticeExamInstructionScreenState();
}

class _PracticeExamInstructionScreenState
    extends State<PracticeExamInstructionScreen> {
  final List<String> instructionTitles = [
    'There is no time limit, so feel free to take your time with each question.',
    'After each answer, you’ll immediately see whether you got it correct, along with a detailed explanation.',
    'You can skip questions or answer them in any order. Tap on any question to revisit it at any time.',
    'Mark any question for review if you\'d like to come back to it later.',
  ];

  @override
  Widget build(BuildContext context) {
    log('=====Course Id ${widget.data!.id}=====');

    return Scaffold(
      appBar: CustomAppbar(
        title: widget.quiz!.title.toString(),
        onCallBack: () {
          NavigationService.goBack;
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                UIHelper.verticalSpace(33.h),
                _questionBoard(),
                UIHelper.verticalSpace(34.h),
                Row(
                  children: [
                    Text(
                      'Key Features'.tr,
                      style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                          .copyWith(
                        color: AppColors.c222222,
                      ),
                    )
                  ],
                ),
                UIHelper.verticalSpace(8.h),
                Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: instructionTitles.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Column(
                            children: [
                              InstructionItem(
                                title: instructionTitles[index],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    UIHelper.verticalSpace(40.h),
                    customButton(
                        name: 'Start Now',
                        onCallBack: () {
                          NavigationService.navigateToWithArgs(
                              Routes.practiceQuestionScreen,
                              {'data': widget.quiz, 'course': widget.data});
                        },
                        context: context)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // question board
  Widget _questionBoard() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.0.h),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.icons.question),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0.h, horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.quiz!.totalQuestions.toString(),
                                style: TextFontStyle
                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                .copyWith(color: AppColors.c000000),
                          ),
                          Text(
                            'Questions'.tr,
                            overflow: TextOverflow.ellipsis,
                            style: TextFontStyle
                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                .copyWith(color: AppColors.c000000),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0.h),
              height: 76.h,
              width: 1.w,
              color: AppColors.c000000,
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 10.0.h),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.icons.marks),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.quiz!.passMark}%",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          style: TextFontStyle
                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                .copyWith(color: AppColors.c000000),
                          ),
                          Text(
                            'passing score',
                          style: TextFontStyle
                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                .copyWith(color: AppColors.c000000),
                          ),

                          //widget.quiz!.totalTime.toString(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InstructionItem extends StatelessWidget {
  const InstructionItem({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns items at the top
      children: [
        SvgPicture.asset(
          Assets.icons.filledCheck,
          height: 24.h,
          width: 24.w,
        ),
        SizedBox(width: 5.w), // Space between icon and text
        Expanded(
          // Ensures text wraps within available space
          child: Text(
            title.tr,
            style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                .copyWith(color: AppColors.c222222),
            softWrap: true, // Enables text to wrap to the next line
            overflow: TextOverflow.visible, // Ensures no text is clipped
          ),
        ),
      ],
    );
  }
}
