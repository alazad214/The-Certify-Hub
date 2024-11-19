import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/all_routes.dart';

class PracticeExmaResult extends StatefulWidget {
  const PracticeExmaResult({super.key});

  @override
  State<PracticeExmaResult> createState() => _MockTestResultState();
}

class _MockTestResultState extends State<PracticeExmaResult> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is the primary function of an operating system?",
      "options": [
        "To provide a platform for applications to run",
        "To manage hardware and software resources",
        "To secure the computer from viruses",
        "To increase processing speed"
      ],
      "correctIndex": 1,
      "userSelectedIndex": 1,
    },
    {
      "question": "Which language is primarily used for Android development?",
      "options": ["Python", "Java", "Swift", "Kotlin"],
      "correctIndex": 3,
      "userSelectedIndex": 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'practice: Managing Your Time Wisely',
        onCallBack: () {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  Assets.images.characterOops.path,
                  height: 149.h,
                  width: 138.w,
                ),
              ),
              Text(
                'You have not passed the quiz!'.tr,
                style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim,
              ),
              Text(
                'Try Again'.tr,
                style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                    .copyWith(
                        fontWeight: FontWeight.bold, color: AppColors.c000000),
              ),
              UIHelper.verticalSpace(16.h),
              Container(
                //height: 56.h,
                width: 140.w,
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
                  child: Row(
                    children: [
                      SvgPicture.asset(Assets.icons.question),
                      UIHelper.horizontalSpace(8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Questions'.tr,
                            style: TextFontStyle
                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                .copyWith(color: AppColors.c000000),
                          ),
                          Text(
                            '10%'.tr,
                            style: TextFontStyle
                                .textStyle16w500c222222StyleGTWalsheim
                                .copyWith(color: AppColors.c000000),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(16.h),
              ListView.builder(
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Disable internal scrolling
                padding: EdgeInsets.only(
                    bottom: 100.h), // Disable internal scrolling
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final questionData = questions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Question ${index + 1}",
                              style: TextFontStyle
                                  .textStyle12w400c9AB2A8StyleGTWalsheim,
                            ),
                            SizedBox(height: 8),
                            Text(
                              questionData["question"],
                              style: TextFontStyle
                                  .headline18w500c222222StyleGTWalsheim,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            _buildOptions(
                              questionData["options"],
                              questionData["correctIndex"],
                              questionData["userSelectedIndex"],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              UIHelper.verticalSpace(100.h),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        height: 95.h,
        color: Colors.white,
        child: Center(
          child: customButton(
            minWidth: double.infinity,
            height: 48.h,
            name: 'Restart Quiz',
            onCallBack: () {
              NavigationService.navigateTo(Routes.mockTestSectionScreen);
            },
            context: context,
          ),
        ),
      ),
    );
  }

  Widget _buildOptions(
      List<String> options, int correctIndex, int userSelectedIndex) {
    return Column(
      children: List.generate(options.length, (index) {
        final isCorrect = index == correctIndex;
        final isSelected = index == userSelectedIndex;

        final outlineColor = isCorrect
            ? Colors.green
            : (isSelected && !isCorrect ? Colors.red : Colors.transparent);

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: outlineColor,
              width: 2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle_outlined,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  options[index],
                  style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                      .copyWith(color: Colors.grey),
                ),
              ),
              SizedBox(width: 10),
              Icon(
                isCorrect
                    ? Icons.check_circle
                    : (isSelected ? Icons.cancel : Icons.circle_outlined),
                color: isCorrect
                    ? Colors.green
                    : (isSelected ? Colors.red : Colors.transparent),
              ),
            ],
          ),
        );
      }),
    );
  }
}
