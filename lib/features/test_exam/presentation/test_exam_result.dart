import 'package:christiandimene/features/test_exam/model/test_result_response.dart';
import 'package:christiandimene/gen/colors.gen.dart';
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
import '../../../helpers/all_routes.dart';

class TestExamResult extends StatefulWidget {
  final Map? quiz;
  TestExamResult({this.quiz, super.key});
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => NavigationService.goBack(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                (widget.quiz!["result"]["percentage"] >= 70)
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
                (widget.quiz!["result"]["percentage"] >= 70)
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
                (widget.quiz!["result"]["percentage"] >= 70)
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
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
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
        height: 95.h,
        color: Colors.white,
        child: Center(
          child: customButton(
            context: context,
            minWidth: double.infinity,
            height: 48.h,
            name: 'Restart Quiz',
            onCallBack: () {
              NavigationService.navigateToUntilReplacement(
                  Routes.bottomNavBarScreen);
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
            ? (isCorrect ? Colors.green : Colors.red)
            : Colors.transparent;

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
              Icon(Icons.circle_outlined),
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
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
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
                        "${widget.quiz?["result"]["percentage"].toString()} %"),
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
