import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/widgets/practice_exam_finish.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/all_routes.dart';

class PracticeQuestionScreen extends StatefulWidget {
  @override
  _PracticeQuestionScreenState createState() => _PracticeQuestionScreenState();
}

class _PracticeQuestionScreenState extends State<PracticeQuestionScreen> {
  int _selectedQuestionIndex = 0;
  int _previousSelectedIndex = -1;

  Map<int, int> selectedOptions = {};

  Map<int, bool> completedQuestionsStatus = {};
  Set<int> flaggedQuestions = {};

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
      "question": "Which protocol is used to send emails?",
      "options": [
        "SMTP",
        "HTTP",
        "FTP",
        "IMAP",
      ],
      "correctIndex": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Practice: Managing Your Time Wisely',
        onCallBack: () {
          practiceExamFinish(context, () {
            NavigationService.navigateToReplacement(Routes.bottomNavBarScreen);
          });
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
              //QUESTION NO...
              Text(
                "Question ${_selectedQuestionIndex + 1}",
                style: TextFontStyle.textStyle12w400c9AB2A8StyleGTWalsheim,
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(6.h),

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

  InkWell _buildFlagButton() {
    bool isFlagged = flaggedQuestions.contains(_selectedQuestionIndex);
    return InkWell(
      onTap: () {
        setState(() {
          if (isFlagged) {
            flaggedQuestions.remove(_selectedQuestionIndex);
          } else {
            flaggedQuestions.add(_selectedQuestionIndex);
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

  Widget _buildQuestionOption() {
    var options = questionData[_selectedQuestionIndex]['options'];
    var correctIndex = questionData[_selectedQuestionIndex]['correctIndex'];

    var selectedOption = selectedOptions[_selectedQuestionIndex] ?? -1;

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

  Widget _questionList() {
    return Wrap(
      spacing: 8.sp,
      runSpacing: 16.sp,
      children: List.generate(questionData.length, (index) {
        bool isSelected = _selectedQuestionIndex == index;
        bool isPrevious = _previousSelectedIndex == index;
        bool isFlagged = flaggedQuestions.contains(index);

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
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.c245741 : backgroundColor,
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                      color: isSelected || isPrevious
                          ? AppColors.c245741
                          : AppColors.c31CD63.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    "${index + 1}",
                    style: TextFontStyle.textStyle14w500c6B6B6BtyleGTWalsheim
                        .copyWith(
                      color: isSelected ? AppColors.cFFFFFF : AppColors.c000000,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isFlagged)
                  Positioned(
                      top: -5,
                      right: -5,
                      child: SvgPicture.asset(
                        Assets.icons.flagBorder,
                        height: 18.h,
                        width: 18.w,
                      ))
              ],
            ));
      }),
    );
  }

  Widget _navigationButtons() {
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
                side: BorderSide(
                  width: 1.sp,
                  color: Color(0xFF727272),
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: SvgPicture.asset(
                Assets.icons.arrowLeft,
                height: 24.h,
                width: 24.w,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (allQuestionsAnswered) {
              // examFinishPopup(
              //   context,
              //   () {
              //     NavigationService.navigateToReplacement(
              //         Routes.practiceExamResult);
              //   },
              //   '08:11',
              //   '08',
              //   '08',
              // );
            }
          },
          child: Container(
            width: 176.w,
            height: 46,
            decoration: BoxDecoration(
              color:
                  allQuestionsAnswered ? AppColors.cFDB338 : Colors.transparent,
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
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: SvgPicture.asset(
                Assets.icons.arrowBlacks,
                height: 24.h,
                width: 24.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
