// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/certification/model/mock_test_response.dart';
import 'package:christiandimene/features/home/model/course_response.dart';
import 'package:christiandimene/features/practice_exam/model/practice_quiz_response.dart';
import 'package:christiandimene/features/widgets/exam_finish_popup.dart';
import 'package:christiandimene/features/widgets/quiz_dismiss_popup.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../gen/assets.gen.dart';

class PracticeQuestionScreen extends StatefulWidget {
  QuizData? quiz;

  Course? data;
  PracticeQuestionScreen({this.data, this.quiz, super.key});
  @override
  _PracticeQuestionScreenState createState() => _PracticeQuestionScreenState();
}

class _PracticeQuestionScreenState extends State<PracticeQuestionScreen> {
  int _selectedQuestionIndex = 0;
  int _previousSelectedIndex = -1;
  Map<int, int> selectedOptions = {};
  Map<int, bool> completedQuestionsStatus = {};
  Set<int> flaggedQuestions = {};
  PracticeQuiz? quizData;
  int selectedQuestionIndex = 0;
  Set<int> attemped = {};
  late int unttempted;
  Map<String, int> result = {};

  @override
  void initState() {
    super.initState();
    getPracticeQuizRxObj.practiceQuiz(widget.quiz!.id!);
  }

  @override
  Widget build(BuildContext context) {
    unttempted = widget.quiz!.totalQuestions! - attemped.length;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        quizDismissPopup(context);
      },
      child: Scaffold(
        appBar: CustomAppbar(
          title: widget.quiz!.title!,
          onCallBack: () {
            quizDismissPopup(context);
          },
          actions: [
            _buildFlagButton(),
          ],
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: StreamBuilder(
                stream: getPracticeQuizRxObj.dataFetcher,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (snapshot.hasData) {
                      quizData = snapshot.data!.quiz;

                      if (quizData == null || quizData!.questions!.isEmpty) {
                        return Center(child: Text('No Quiz Available'));
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Question ${selectedQuestionIndex + 1}",
                              style: TextFontStyle
                                  .textStyle14w500c6B6B6BtyleGTWalsheim,
                              textAlign: TextAlign.center,
                            ),
                            UIHelper.verticalSpace(15.h),
                            Text(
                              quizData!.questions![selectedQuestionIndex].text!,
                              style: TextFontStyle
                                  .headline18w500c222222StyleGTWalsheim,
                              textAlign: TextAlign.center,
                            ),
                            UIHelper.verticalSpace(25.h),

                            //QUESTION OPTION...
                            buildQuestion(),
                            UIHelper.verticalSpace(30.h),

                            //QUESTION ITEM LIST...
                            buildQuizItem(),
                            UIHelper.verticalSpace(40.h),

                            //NAVIGATION BUTTONS...
                            navigationButtons(),
                          ],
                        );
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
                }),
          ),
        ),
      ),
    );
  }

  Widget buildQuizItem() {
    return SizedBox(
      height: 50.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: quizData!.questions!.length,
          itemBuilder: (context, index) {
            bool isSelected = selectedQuestionIndex == index;
            bool? isCompleted = completedQuestionsStatus[index];
            bool isFlagged = flaggedQuestions.contains(index);
            Color backgroundColor;

            if (isSelected) {
              backgroundColor = AppColors.c245741;
            } else if (isCompleted == true) {
              backgroundColor = AppColors.c36AD2F;
            } else {
              backgroundColor = Colors.transparent;
            }

            return InkWell(
              onTap: () {
                setState(() {
                  selectedQuestionIndex;
                  selectedQuestionIndex = index;
                });
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 15.w),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.c245741
                            : AppColors.c31CD63.withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      "${index + 1}",
                      style: TextFontStyle.textStyle14w500c6B6B6BtyleGTWalsheim
                          .copyWith(
                        color:
                            isSelected ? AppColors.cFFFFFF : AppColors.c000000,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (isFlagged)
                    Positioned(
                        top: -8,
                        right: 10.w,
                        child: SvgPicture.asset(
                          Assets.icons.flagBorder,
                          height: 18.h,
                          width: 18.w,
                        ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFlagButton() {
    bool isFlagged = flaggedQuestions.contains(selectedQuestionIndex);
    return InkWell(
      onTap: () {
        setState(() {
          if (isFlagged) {
            flaggedQuestions.remove(selectedQuestionIndex);
          } else {
            flaggedQuestions.add(selectedQuestionIndex);
          }
        });
      },
      child: Container(
        height: 32.h,
        width: 32.w,
        padding: EdgeInsets.all(5.sp),
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
        child: SvgPicture.asset(
          isFlagged ? Assets.icons.flag : Assets.icons.flatOutline,
        ),
      ),
    );
  }

  Widget buildQuestion() {
    final options = quizData!.questions![selectedQuestionIndex].options!
        .map((e) => e)
        .toList();

    final selectedOption = selectedOptions[selectedQuestionIndex] ?? -1;
    final correctOptionId =
        quizData!.questions![selectedQuestionIndex].correctOption!;

    bool isCorrectAns = false;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: options.length,
      itemBuilder: (context, index) {
        final isSelected = selectedOption == index;

        return InkWell(
          onTap: () {
            if (selectedOption == -1) {
              attemped.add(selectedQuestionIndex);
              setState(() {
                selectedOptions[selectedQuestionIndex] = index;
                log('practic result: ${quizData!.questions![selectedQuestionIndex].id.toString()}');
                result.addAll({
                  quizData!.questions![selectedQuestionIndex].id.toString():
                      options[index].id!
                });
                if (options[index].id == correctOptionId) {
                  isCorrectAns = true;
                } else {
                  isCorrectAns = false;
                }
              });
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 16.h),
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isSelected
                    ? ((options[index].isCorrect == 1)
                        ? AppColors.allPrimaryColor
                        : Colors.red)
                    : (options[index].id == correctOptionId &&
                            selectedOption != -1)
                        ? AppColors.allPrimaryColor
                        : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
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
                      groupValue: selectedOption,
                      onChanged: null,
                    ),
                  ),
                ),
                UIHelper.horizontalSpace(6.h),
                Expanded(
                  child: Text(
                    options[index].text!,
                    style: TextFontStyle.textStyle14w400c9AB2A8.copyWith(
                      color: isSelected
                          ? AppColors.black
                          : (selectedOption != -1
                              ? AppColors.black
                              : AppColors.c6B6B6B),
                    ),
                  ),
                ),
                if (isSelected)
                  SvgPicture.asset(
                    Assets.icons.tickCircle,
                    color: (options[index].isCorrect == 1)
                        ? AppColors.allPrimaryColor
                        : Colors.red,
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget navigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            if (selectedQuestionIndex > 0) {
              setState(() {
                selectedQuestionIndex;
                selectedQuestionIndex--;
              });
            }
          },
          child: Container(
            height: 46.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: AppColors.cFDB338,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                Assets.icons.arrowLeft,
                height: 24,
                width: 24,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            examFinishPopup(
                context,
                'Quiz paused',
                () {
                  NavigationService.navigateToWithArgs(
                      Routes.practiceExamResult, {
                    'quiz': quizData,
                    'attempted': attemped,
                    'selectedOptions': result,
                    'course': widget.data
                  });
                },
                () {
                  //    NavigationService.navigateToWithArgs(
                  //     Routes.certificationScreen, {
                  //   "data": widget.data,
                  // });
                  Navigator.pop(context);
                },
                attemped.length.toString(),
                unttempted.toString(),
                true,
                'Finish',
                'Continue',
                () {
                  return Future.value(false);
                });
          },
          child: Container(
            width: 176.w,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.cFDB338,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "Pause/Finish",
                style: TextFontStyle.textStyle16w700c222222StyleGTWalsheim
                    .copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (selectedQuestionIndex < quizData!.questions!.length - 1) {
              setState(() {
                selectedQuestionIndex;
                selectedQuestionIndex++;
              });
            }
          },
          child: Container(
            height: 46.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: AppColors.cFDB338,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                Assets.icons.arrowRightSvg,
                height: 24,
                width: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
