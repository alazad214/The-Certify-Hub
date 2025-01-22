import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/features/home/model/course_response.dart';
import 'package:christiandimene/features/test_exam/model/test_result_response.dart';
import 'package:christiandimene/features/widgets/quiz_restart_popup.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/ui_helpers.dart';
import '../../certification/model/mock_test_response.dart';

class TestExamResult extends StatefulWidget {
  final Map? quiz;
  QuizData? quizdata;

  Course? data;
  TestExamResult({this.data, this.quiz, this.quizdata, super.key});
  @override
  State<TestExamResult> createState() => _TestExamResultState();
}

class _TestExamResultState extends State<TestExamResult> {
  @override
  void initState() {
    super.initState();
    getTestQuizResultRxObj.testQuizResult(widget.quiz!["result"]["id"]);
  }

  @override
  Widget build(BuildContext context) {
    int passMark = int.parse(widget.quizdata!.passMark.toString());

    return Scaffold(
      appBar: CustomAppbar(title: 'Quiz Result'),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                (widget.quiz!["result"]["percentage"] >= passMark)
                    ? Center(
                        child: Image.asset(
                          Assets.images.characterPass.path,
                          height: 149.h,
                          width: 138.w,
                        ),
                      )
                    : Center(
                        child: Image.asset(
                          Assets.images.characterOops.path,
                          height: 149.h,
                          width: 138.w,
                        ),
                      ),
                (widget.quiz!["result"]["percentage"] >= passMark)
                    ? Text(
                        'You have passed the quiz!',
                        style: TextFontStyle
                            .textStyle16w400c999999StyleGTWalsheim
                            .copyWith(
                          color: AppColors.c000000,
                        ),
                      )
                    : Text(
                        'You have Not passed the quiz!',
                        style: TextFontStyle
                            .textStyle16w400c999999StyleGTWalsheim
                            .copyWith(
                          color: AppColors.c000000,
                        ),
                      ),
                (widget.quiz!["result"]["percentage"] >= passMark)
                    ? SizedBox.shrink()
                    : Text(
                        'Try Again'.tr,
                        style: TextFontStyle
                            .textStyle16w400c999999StyleGTWalsheim
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.c000000),
                      ),
                UIHelper.verticalSpace(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimeAndWidget(),
                  ],
                ),
                UIHelper.verticalSpace(30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: StreamBuilder(
                      stream: getTestQuizResultRxObj.dataFetcher,
                      builder: (_, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          List<QuestionResult>? result =
                              snapshot.data!.questions;

                          if (snapshot.hasError) {
                            return Center(
                                child: Text("Error: ${snapshot.error}"));
                          } else if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: result!.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final questionData = result[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("Question ${index + 1}"),
                                          SizedBox(height: 8),
                                          Text(
                                            questionData.questionText ?? "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 16),
                                          _buildOptions(
                                            questionData.options,
                                            questionData.correctOption,
                                            questionData.explanation,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
                UIHelper.verticalSpace(100.h),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        height: 80.h,
        color: Colors.transparent,
        child: Center(
          child: customButton(
            context: context,
            minWidth: double.infinity,
            height: 44.h,
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
          ),
        ),
      ),
    );
  }

  Widget _buildOptions(
      List<Option>? options, String? correctOption, String? explanation) {
    return Column(
      children: List.generate(options?.length ?? 0, (index) {
        final option = options![index];
        final isCorrect = option.text == correctOption;
        final outlineColor = option.isSelected == true
            ? (isCorrect ? Colors.greenAccent : Colors.red)
            : option.isCorrect == 1
                ? Colors.green
                : Colors.transparent;

        int selectedIndex = option.isSelected == true ? index : -1;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: outlineColor, width: 2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    groupValue: selectedIndex,
                    onChanged: null,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  option.text ?? "",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(width: 10),
              Icon(
                isCorrect
                    ? Icons.check_circle
                    : (option.isSelected == true
                        ? Icons.cancel
                        : Icons.circle_outlined),
                color: isCorrect
                    ? Colors.green
                    : (option.isSelected == true
                        ? Colors.red
                        : Colors.transparent),
              ),
            ],
          ),
        );
      }),
    );
  }

  Container _buildTimeAndWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.0.h),
        child: Row(
          children: [
            SvgPicture.asset(Assets.icons.question),
            UIHelper.horizontalSpace(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Quiz'),
                Text(widget.quiz!['result']['total_questions'].toString()),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              height: 54.h,
              width: 1.w,
              color: Colors.grey,
            ),
            Row(
              children: [
                SvgPicture.asset(Assets.icons.marks),
                UIHelper.horizontalSpace(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Score'),
                    Text(
                        "${widget.quiz!["result"]["percentage"].toDouble().toInt()}%"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
