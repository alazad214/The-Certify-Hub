import 'dart:async';

import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/widgets/exam_finish_popup.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';
import '../../../helpers/all_routes.dart';

class TestExamQuestionScreen extends StatefulWidget {
  @override
  _PracticeQuestionScreenState createState() => _PracticeQuestionScreenState();
}

class _PracticeQuestionScreenState extends State<TestExamQuestionScreen> {
  ///time
  final int durationMinutes = 15;
  late int remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remainingSeconds = durationMinutes * 60;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds <= 0) {
        _timer?.cancel();
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  int _selectedQuestionIndex = 0;
  int _previousSelectedIndex = -1;

  Map<int, int> selectedOptions = {};

  Map<int, bool> completedQuestionsStatus = {};

  final List<Map<String, dynamic>> questionData = [
    {
      "question":
          "What Is The Primary Function Of The Operating System In A Computer?",
      "options": [
        "To provide a platform for applications to run",
        "To manage hardware and software resources",
        "To manage user data",
        "To improve hardware speed",
      ],
      "correctIndex": 1,
    },
    {
      "question": "Which is not a programming language?",
      "options": [
        "Python",
        "Java",
        "HTML",
        "C++",
      ],
      "correctIndex": 2,
    },
    {
      "question": "Which of these is a web browser?",
      "options": [
        "Windows",
        "Linux",
        "Chrome",
        "Python",
      ],
      "correctIndex": 2,
    },
    {
      "question": "What does CPU stand for?",
      "options": [
        "Central Processing Unit",
        "Computer Processing Unit",
        "Central Programming Unit",
        "Core Processing Utility",
      ],
      "correctIndex": 0,
    },
    {
      "question": "What does CPU stand for?",
      "options": [
        "Central Processing Unit",
        "Computer Processing Unit",
        "Central Programming Unit",
        "Core Processing Utility",
      ],
      "correctIndex": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Test: Managing Your Time Wisely',
        onCallBack: () {
          examFinishPopup(
            context,
            () {
              NavigationService.navigateToReplacement(Routes.testExamResult);
            },
            '08:11',
            '08',
            '08',
          );
        },
        actions: [
          //build flag button..
          _buildFlagButton(),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //BUILD TIME WIDGET...
              _buildTimewidget(),
              UIHelper.verticalSpace(24.h),

              //QUESTION NO...
              Text(
                "Question ${_selectedQuestionIndex + 1}",
                style: TextFontStyle.textStyle12w400c9AB2A8StyleGTWalsheim,
                textAlign: TextAlign.center,
              ),
              //QUESTION NAME...
              Text(
                questionData[_selectedQuestionIndex]['question'],
                style: TextFontStyle.headline18w500c222222StyleGTWalsheim,
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(40.h),

              //QUESTION OPTION...

              _buildQuestionOption(),
              UIHelper.verticalSpace(40.h),

              //QUESTION ITEM LIST...
              _questionList(),
              UIHelper.verticalSpace(40.h),

              //NAVIGATION BUTTONS...
              _navigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimewidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          width: 95.w,
          height: 45.h,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.icons.time),
              UIHelper.horizontalSpace(5.w),
              Text(
                formatTime(remainingSeconds),
                style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                    .copyWith(color: AppColors.c222222),
              )
            ],
          )),
    );
  }

  InkWell _buildFlagButton() {
    return InkWell(
      onTap: () {},
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
          Assets.icons.flag,
        ),
      ),
    );
  }

  Widget _navigationButtons() {
    // Check if all questions are completed
    bool allQuestionsAnswered =
        completedQuestionsStatus.length == questionData.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            if (_selectedQuestionIndex > 0) {
              setState(() {
                _previousSelectedIndex = _selectedQuestionIndex;
                _selectedQuestionIndex--;
              });
            }
          },
          child: Container(
            height: 46.h,
            width: 40.w,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFF727272)),
                borderRadius: BorderRadius.circular(8),
              ),
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
        // Always show the Finish button with dynamic color
        GestureDetector(
          onTap: () {
            if (allQuestionsAnswered) {
              examFinishPopup(
                context,
                () {
                  NavigationService.navigateToReplacement(
                      Routes.testExamResult);
                },
                '08:11',
                '08',
                '08',
              );
            }
          },
          child: Container(
            width: 176.w,
            height: 46,
            decoration: BoxDecoration(
              color: allQuestionsAnswered
                  ? AppColors.cFDB338
                  : Colors.transparent, // Dynamic color
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: allQuestionsAnswered
                    ? AppColors.cFDB338
                    : AppColors.c6B6B6B,
              ),
            ),
            child: Center(
              child: Text(
                "Finish",
                style: TextFontStyle.headline18w500c222222StyleGTWalsheim
                    .copyWith(
                        color: allQuestionsAnswered
                            ? AppColors.cFFFFFF
                            : AppColors.c6B6B6B),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (_selectedQuestionIndex < questionData.length - 1) {
              setState(() {
                _previousSelectedIndex = _selectedQuestionIndex;
                _selectedQuestionIndex++;
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
                Assets.icons.arrowBlacks,
                height: 24,
                width: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _questionList() {
    return Wrap(
      spacing: 8,
      runSpacing: 16,
      children: List.generate(questionData.length, (index) {
        bool isSelected = _selectedQuestionIndex == index;
        bool isPrevious = _previousSelectedIndex == index;

        bool? isCorrect = completedQuestionsStatus[index];
        Color backgroundColor;
        if (isCorrect == true) {
          backgroundColor = AppColors.c31CD63.withOpacity(0.5);
        } else if (isCorrect == false) {
          backgroundColor = AppColors.cFF402F.withOpacity(0.5);
        } else {
          backgroundColor = Colors.transparent;
        }

        return GestureDetector(
          onTap: () {
            setState(() {
              _previousSelectedIndex = _selectedQuestionIndex;
              _selectedQuestionIndex = index;
            });
          },
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.c245741 : backgroundColor,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: isSelected || isPrevious
                    ? AppColors.c31CD63.withOpacity(0.5)
                    : AppColors.c31CD63.withOpacity(0.5),
              ),
            ),
            child: Text(
              "${index + 1}",
              style:
                  TextFontStyle.textStyle14w500c6B6B6BtyleGTWalsheim.copyWith(
                color: isSelected ? AppColors.cFFFFFF : AppColors.c000000,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildQuestionOption() {
    final options = questionData[_selectedQuestionIndex]['options'];
    final correctIndex = questionData[_selectedQuestionIndex]['correctIndex'];

    final selectedOption = selectedOptions[_selectedQuestionIndex] ?? -1;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final isSelected = selectedOption == index;
        final isCorrect = index == correctIndex;

        return GestureDetector(
          onTap: () {
            if (selectedOption == -1) {
              setState(() {
                selectedOptions[_selectedQuestionIndex] = index;

                completedQuestionsStatus[_selectedQuestionIndex] =
                    index == correctIndex;
              });
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isSelected
                    ? (isCorrect ? AppColors.c31CD63 : AppColors.cFF402F)
                    : (selectedOption != -1 && index == correctIndex
                        ? AppColors.c31CD63
                        : Colors.transparent),
              ),
            ),
            child: Row(
              children: [
                // Circle Radio Button
                Container(
                  height: 20.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? (isCorrect ? AppColors.c6B6B6B : AppColors.c6B6B6B)
                          : AppColors.c6B6B6B,
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
                    options[index],
                    style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                        .copyWith(
                      color: isSelected
                          ? (isCorrect ? AppColors.c6B6B6B : AppColors.c6B6B6B)
                          : (selectedOption != -1 && index == correctIndex
                              ? AppColors.c6B6B6B
                              : AppColors.c6B6B6B),
                    ),
                  ),
                ),
                if (isSelected ||
                    (selectedOption != -1 && index == correctIndex))
                  SvgPicture.asset(
                    index == correctIndex
                        ? Assets.icons.correct
                        : Assets.icons.closeCircle,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
