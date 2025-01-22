import 'dart:developer';

import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/features/home/model/course_response.dart';
import 'package:christiandimene/features/widgets/quiz_restart_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../gen/assets.gen.dart';
import 'package:christiandimene/features/practice_exam/model/practice_quiz_response.dart';

class PracticeExamResult extends StatefulWidget {
  final PracticeQuiz? quiz;
  final Set<int>? attempted;
  final Map<String, int>? selectedOptions;
  Course? data;

  PracticeExamResult(
      {Key? key, this.data, this.quiz, this.attempted, this.selectedOptions})
      : super(key: key);

  @override
  State<PracticeExamResult> createState() => _PracticeExamResultState();
}

class _PracticeExamResultState extends State<PracticeExamResult> {
  @override
  Widget build(BuildContext context) {
    log('result map ${widget.selectedOptions}');
    return Scaffold(
      appBar: CustomAppbar(title: widget.quiz!.title ?? 'No Title'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  Assets.images.characterPass.path,
                  height: 149.h,
                  width: 138.w,
                ),
              ),
              UIHelper.verticalSpace(15.h),
              Text(
                'Try Again'.tr,
                style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                    .copyWith(
                        fontWeight: FontWeight.bold, color: AppColors.c000000),
              ),
              UIHelper.verticalSpace(16.h),
              _buildSummaryCard(widget.quiz!.questions!.length),
              UIHelper.verticalSpace(16.h),

              ///QUESTION AND ANSWER...
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 100.h),
                itemCount: widget.quiz!.questions!.length,
                itemBuilder: (context, index) {
                  final questionData = widget.quiz!.questions![index];
                  return _buildQuestionCard(index, questionData);
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: _buildBottomSheet(context),
    );
  }

  Widget _buildSummaryCard(int totalQuestions) {
    return Container(
      width: 140.w,
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            SvgPicture.asset(Assets.icons.question),
            UIHelper.horizontalSpace(8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Questions'.tr,
                  style: TextFontStyle.textStyle12w400c9AB2A8StyleGTWalsheim
                      .copyWith(
                    color: AppColors.c000000,
                  ),
                ),
                Text(
                  ' $totalQuestions',
                  style: TextFontStyle.textStyle16w500c222222StyleGTWalsheim
                      .copyWith(
                    color: AppColors.c000000,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(int index, Question questionData) {
    // log('quize data : ${questionData.correctOption}');
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Question ${index + 1}",
            style: TextFontStyle.textStyle16w700c222222StyleGTWalsheim,
          ),
          UIHelper.verticalSpace(8.h),
          Text(
            questionData.text ?? 'No Question Text',
            style: TextFontStyle.headline18w500c222222StyleGTWalsheim,
            textAlign: TextAlign.center,
          ),
          UIHelper.verticalSpace(16.h),
          _buildOptions(
            questionData.options!,
            questionData.correctOption!,
            widget.selectedOptions?[questionData.id!.toString()] ?? -1,
          ),
        ],
      ),
    );
  }

  Widget _buildOptions(
      List<Option> options, int correctAnsID, int userSelectedQuestionId) {
    return Column(
      children: options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        // log('index : $index');
        // log('value : $option');
        final isCorrect = userSelectedQuestionId == option.id;
        final isSelected = index == userSelectedQuestionId;
        log('$index currect ans : $correctAnsID');
        log('$index userSelectedQuestionId ans : $userSelectedQuestionId');
        log('$index isCorrect: $isCorrect');
        log(' $index isSeleted: $isSelected');
        log('>>>>>>>>>>>>>>>>>>>');

        int selectedIndex = isCorrect ? index : -1;

        Color borderColor = option.isCorrect == 1
            ? Colors.green
            : (isCorrect ? Colors.red : Colors.transparent);

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: borderColor,
              width: 2.w,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon(Icons.circle_outlined),
              Container(
                height: 20.h,
                width: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.c6B6B6B,
                  ),
                ),
                child: Center(
                  child: Radio(
                    value: index,
                    groupValue: selectedIndex,
                    onChanged: null,
                  ),
                ),
              ),
              UIHelper.horizontalSpace(6.w),
              Expanded(
                child: Text(
                  option.text ?? 'No Option Text',
                  style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                      .copyWith(color: Colors.grey),
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Icon(
                option.isCorrect == 1
                    ? Icons.check_circle
                    : (isCorrect ? Icons.cancel : Icons.circle_outlined),
                color: option.isCorrect == 1
                    ? Colors.green
                    : (isCorrect ? Colors.red : Colors.transparent),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 60.w),
      height: 65.h,
      child: Center(
        child: customButton(
          minWidth: double.infinity,
          height: 48.h,
          name: 'Return to course',
          onCallBack: () {
            quizRestartPopupPopup(
              context,
              () {
                NavigationService.navigateToWithArgs(
                    Routes.certificationScreen, {
                  "data": widget.data,
                });
              },
            );
          },
          context: context,
        ),
      ),
    );
  }
}
