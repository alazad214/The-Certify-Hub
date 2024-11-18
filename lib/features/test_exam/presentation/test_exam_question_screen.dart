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
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<TestExamQuestionScreen> {
  //timer...
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

  int _selectedOption = -1;

  int _selectedQuestionIndex = -1;
  int _previousSelectedIndex = -1;

  final List<int> questions = List.generate(13, (index) => index + 1);

  final List<String> options = [
    "To provide a platform for applications to run",
    "To manage hardware and software resources",
    "To provide a platform for applications to run",
    "To provide a platform for applications to run",
  ];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //build time widget...
              _buildTimewidget(),
              UIHelper.verticalSpace(24.h),

              //question....
              Text(
                "Question 1",
                style: TextFontStyle.textStyle12w400c9AB2A8StyleGTWalsheim,
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(5.h),
              Text(
                "What Is The Primary Function Of The Operating System In A Computer?",
                style: TextFontStyle.headline18w500c222222StyleGTWalsheim,
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(40.h),

              //question option...
              _questionItem(),
              UIHelper.verticalSpace(40.h),
              Text.rich(
                TextSpan(
                  text: "Description: ",
                  children: [
                    TextSpan(
                      text:
                          "The operating system (OS) is essential for managing the computer's hardware and software. It acts as an intermediary between users and the computer hardware, ensuring that applications have the resources they need to function properly.",
                      style:
                          TextFontStyle.textStyle12w400c9AB2A8StyleGTWalsheim,
                    ),
                  ],
                  style: TextFontStyle.textStyle12w400c9AB2A8StyleGTWalsheim
                      .copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.c000000),
                ),
              ),
              UIHelper.verticalSpace(40.h),
              _questionList(),
            ],
          ),
        ),
      ),
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

  Widget _questionItem() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final isSelected = _selectedOption == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedOption = index;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? AppColors.c31CD63 : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.c6B6B6B : Colors.grey,
                    ),
                  ),
                  child: Center(
                    child: Radio<int>(
                      value: index,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                      activeColor: AppColors.c6B6B6B,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    options[index],
                    style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                        .copyWith(color: AppColors.c6B6B6B),
                  ),
                ),
                if (isSelected) SvgPicture.asset(Assets.icons.correct)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _questionList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: List.generate(questions.length, (index) {
            bool isSelected = _selectedQuestionIndex == index;
            bool isPrevious = _previousSelectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _previousSelectedIndex = _selectedQuestionIndex;
                  _selectedQuestionIndex = index;
                });
              },
              child: Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.c245741
                          : isPrevious
                              ? AppColors.c31CD63.withOpacity(0.5)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        color: AppColors.c6C8E80,
                      ),
                    ),
                    child: Text(
                      "${questions[index]}",
                      style: TextFontStyle.textStyle14w500c6B6B6BtyleGTWalsheim
                          .copyWith(
                        color: isSelected || isPrevious
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        UIHelper.verticalSpace(20.h),
        Row(
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
            GestureDetector(
              onTap: () {
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
              },
              child: Container(
                width: 176.w,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "Finish",
                    style: TextFontStyle.headline18w500c222222StyleGTWalsheim,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_selectedQuestionIndex < questions.length - 1) {
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
        ),
      ],
    );
  }

  Widget _buildTimewidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          width: 95.w,
          height: 34.h,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
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
}
