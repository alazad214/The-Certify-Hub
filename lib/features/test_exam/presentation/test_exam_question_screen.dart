import 'dart:async';
import 'dart:developer';
import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/certification/model/mock_test_response.dart';
import 'package:christiandimene/features/home/model/course_response.dart';
import 'package:christiandimene/features/widgets/exam_finish_popup.dart';
import 'package:christiandimene/features/widgets/quiz_dismiss_popup.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/all_routes.dart';
import '../model/test_quiz_response.dart';

class TestExamQuiz extends StatefulWidget {
  QuizData? quiz;
  Course? data;

  TestExamQuiz({this.data, this.quiz, super.key});

  @override
  _TestExamQuizState createState() => _TestExamQuizState();
}

class _TestExamQuizState extends State<TestExamQuiz> {
  TestQuizResponse? quizData;
  late int duration = 0;
  late int remainingSeconds;
  Timer? timer;
  bool isTimerRunning = false;
  int selectedQuestionIndex = 0;

  final box = GetStorage();
  Map<int, int> selectedOptions = {};
  Map<int, bool> completedQuestionsStatus = {};
  Set<int> flagged = {};
  Set<int> attemped = {};
  late int unttempted;

  Map<String, int> result = {};

  @override
  Widget build(BuildContext context) {
    unttempted = widget.quiz!.totalQuestions! - attemped.length;

    log('=====Course Id ${widget.data!.id}=====');
    return Scaffold(
      appBar: CustomAppbar(
        title: "${widget.quiz!.title}",
        onCallBack: () {
          quizDismissPopup(context);
        },
        actions: [
          _buildFlagButton(),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: StreamBuilder(
            stream: getTestQuizRxObj.getData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  quizData = snapshot.data;

                  if (quizData!.quiz == null ||
                      quizData!.quiz!.questions!.isEmpty) {
                    return Center(child: Text('No Quiz Available'));
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        UIHelper.verticalSpace(12.h),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [

                        //     // Text(
                        //     //   "Total- ${widget.quiz!.totalQuestions}",
                        //     //   style: TextFontStyle
                        //     //       .headline20w500c222222StyleGTWalsheim,
                        //     // )
                        //   ],
                        // ),
                        _buildTimeWidget(),
                        Text(
                          "Question ${selectedQuestionIndex + 1}",
                          style: TextFontStyle
                              .textStyle12w400c9AB2A8StyleGTWalsheim,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          quizData!
                              .quiz!.questions![selectedQuestionIndex].text!,
                          style: TextFontStyle
                              .headline18w500c222222StyleGTWalsheim,
                          textAlign: TextAlign.center,
                        ),
                        UIHelper.verticalSpace(24.h),
                        buildQuestion(),
                        UIHelper.verticalSpace(24.h),

                        ///BUILD QUIZ ITEM...
                        buildQuizItem(),
                        UIHelper.verticalSpace(24.h),

                        ///NAVIGATION BUTTONS...
                        navigationButtons(),
                      ],
                    );
                  }
                } else {
                  return const SizedBox.shrink();
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Widget buildQuestion() {
    final options = quizData!.quiz!.questions![selectedQuestionIndex].options!
        .map((e) => e)
        .toList();

    final selectedOption = selectedOptions[selectedQuestionIndex] ?? -1;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: options.length,
      itemBuilder: (context, index) {
        final isSelected = selectedOption == index;

        return InkWell(
          onTap: () {
            setState(() {
              selectedOptions[selectedQuestionIndex] = index;
              log('selectedOptions[selectedQuestionIndex] ${selectedOptions[selectedQuestionIndex].toString()}');
              log('selectedQuestionIndex $selectedQuestionIndex');
              log('quiz id : ${quizData!.quiz!.questions![selectedQuestionIndex].id}');
              log('answer id : ${options[index].id}');
              log('answer text : ${options[index].text}');

              result.addAll({
                quizData!.quiz!.questions![selectedQuestionIndex].id.toString():
                    options[index].id!
              });

              attemped.add(selectedQuestionIndex);
            });

            log(result.toString());
          },
          child: Container(
            margin: EdgeInsets.only(top: 16.h),
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                width: 2.w,
                color: isSelected ? Colors.grey : Colors.transparent,
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
                      color: isSelected ? Colors.grey : AppColors.c6B6B6B,
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
                  SvgPicture.asset(Assets.icons.tickCircle, color: Colors.grey)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildQuizItem() {
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: quizData!.quiz!.questions!.length,
          itemBuilder: (context, index) {
            bool isSelected = selectedQuestionIndex == index;
            bool? isCompleted = completedQuestionsStatus[index];
            bool isFlagged = flagged.contains(index);
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
                        top: -5,
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

  Widget _buildTimeWidget() {
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
            ),
          ],
        ),
      ),
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
            pauseTime();
            examFinishPopup(
              context,
              'Are you sure finish this quiz.',
              () {
                Map<String, dynamic> answer = {
                  "quiz_id": widget.quiz!.id!,
                  "answers": result
                };

                if (result.isEmpty) {
                  Get.snackbar('Contribute a minimum of 1 quiz.',
                      'please continue and Contribute to the minimum of 1 quiz.',
                      backgroundColor: AppColors.cFDB338);
                } else {
                  timer?.cancel();
                  postCalculateQuizRxObj.calculateResult(answers: answer).then(
                    (value) {
                      NavigationService.navigateToWithArgs(
                        Routes.testExamResult,
                        {
                          'data': value,
                          "courseId": widget.data,
                        },
                      );
                    },
                  );
                }
              },
              () {
                Navigator.pop(context);
                resumeTime();
              },
              attemped.length.toString(),
              unttempted.toString(),
              false,
              'Finish',
              'Continue',
            );
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
                "Pause",
                style:
                    TextFontStyle.headline18w500c222222StyleGTWalsheim.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (selectedQuestionIndex < quizData!.quiz!.questions!.length - 1) {
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

  Widget _buildFlagButton() {
    bool isFlagged = flagged.contains(selectedQuestionIndex);
    return InkWell(
      onTap: () {
        setState(() {
          if (isFlagged) {
            flagged.remove(selectedQuestionIndex);
          } else {
            flagged.add(selectedQuestionIndex);
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

  void startTime() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        endQuiz();
      }
    });
  }

  void endQuiz() {
    timer?.cancel();

    examFinishPopup(
      context,
      'Time is up, see your results now?',
      () {
        NavigationService.navigateToWithArgs(Routes.certificationScreen, {
          "data": widget.data,
        });
      },
      () {
        Map<String, dynamic> answer = {
          "quiz_id": widget.quiz!.id!,
          "answers": result
        };

        if (result.isEmpty) {
          Get.snackbar(
              'Contribute a minimum of 1 quiz.', 'Please Restart the Quiz.',
              backgroundColor: AppColors.cFDB338);
        } else {
          postCalculateQuizRxObj.calculateResult(answers: answer).then((value) {
            NavigationService.navigateToWithArgs(Routes.testExamResult, {
              'data': widget.quiz,
              "courseId": widget.data,
            });
          });
        }
      },
      '08:11',
      attemped.length.toString(),
      false,
      'Restart',
      'Results',
    );
  }

  // Pause the timer
  void pauseTime() {
    if (timer != null) {
      timer?.cancel();
    }

    setState(() {
      isTimerRunning = false;
    });
  }

  // Resume the timer
  void resumeTime() {
    startTime();
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    duration = widget.quiz?.totalTime ?? 0;

    remainingSeconds = duration * 60;
    startTime();
    getTestQuizRxObj.testQuiz(widget.quiz!.id!.toInt());
  }

  @override
  void dispose() {
    timer?.cancel();
    getTestQuizRxObj.testQuiz(widget.quiz!.id!.toInt());
    super.dispose();
  }
}
