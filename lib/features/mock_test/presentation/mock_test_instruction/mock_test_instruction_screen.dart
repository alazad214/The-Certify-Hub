import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/all_routes.dart';

class MockTestInstructions extends StatefulWidget {
  const MockTestInstructions({super.key});

  @override
  State<MockTestInstructions> createState() => _MockTestInstructionsState();
}

class _MockTestInstructionsState extends State<MockTestInstructions> {
  final List<String> instructionTitles = [
    'Passing Score : 70%',
    'There is no time limit, so feel free to take your time with each question.',
    'After each answer, you’ll immediately see whether you got it correct, along with a detailed explanation.',
    'You can skip questions or answer them in any order. Tap on any question to revisit it at any time.',
    'Mark any question for review if you\'d like to come back to it later.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'practice: Managing Your Time Wisely',
        onCallBack: () {
          NavigationService.goBack();
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
                          .copyWith(color: AppColors.c222222),
                    )
                  ],
                ),
                UIHelper.verticalSpace(8.h),
                Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: instructionTitles
                          .length, // Use the length of the instruction list
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Column(
                            children: [
                              InstructionItem(
                                title: instructionTitles[
                                    index], // Pass each sentence by index
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
                          NavigationService.navigateTo(Routes.question_screen);
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
        height: 76.h,
        width: 280.w,
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 10.0.h),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.icons.question),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0.h, horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Questions'.tr,
                            style: TextFontStyle
                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                .copyWith(color: AppColors.c000000),
                          ),
                          Text(
                            '15'.tr,
                            style: TextFontStyle
                                .textStyle16w500c222222StyleGTWalsheim,
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Questions'.tr,
                            style: TextFontStyle
                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                .copyWith(color: AppColors.c000000),
                          ),
                          Text(
                            '15'.tr,
                            style: TextFontStyle
                                .textStyle16w500c222222StyleGTWalsheim
                                .copyWith(color: AppColors.c000000),
                          ),
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
