import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/all_routes.dart';

class TestExamInstructionScreen extends StatefulWidget {
  const TestExamInstructionScreen({super.key});

  @override
  State<TestExamInstructionScreen> createState() =>
      _PracticeExamInstructionScreenState();
}

class _PracticeExamInstructionScreenState
    extends State<TestExamInstructionScreen> {
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
        title: 'Test: Managing Your Time Wisely',
        onCallBack: () {},
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
                      'Key Instructions'.tr,
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
                      itemCount: instructionTitles.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Column(
                            children: [
                              InstructionItem(
                                title: instructionTitles[index],
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
                          NavigationService.navigateTo(
                              Routes.testExamQuestionScreen);
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
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.question,
                      height: 40.h,
                      width: 40.w,
                    ),
                    UIHelper.horizontalSpace(5.w),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Questions',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextFontStyle
                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                .copyWith(color: AppColors.c000000),
                          ),
                          Text(
                            '15'.tr,
                            overflow: TextOverflow.ellipsis,
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
              margin: EdgeInsets.symmetric(vertical: 5.h),
              height: 76.h,
              width: 1.w,
              color: AppColors.cB5B5B5,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.icons.testTime),
                    UIHelper.horizontalSpace(5.w),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Duration'.tr,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextFontStyle
                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                .copyWith(color: AppColors.c000000),
                          ),
                          Text(
                            '15'.tr,
                            overflow: TextOverflow.ellipsis,
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              height: 76.h,
              width: 1.w,
              color: AppColors.cB5B5B5,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.icons.marks),
                    UIHelper.horizontalSpace(8.w),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Passing Score',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextFontStyle
                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                .copyWith(color: AppColors.c000000),
                          ),
                          Text(
                            '70%'.tr,
                            overflow: TextOverflow.ellipsis,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          Assets.icons.filledCheck,
          height: 24.h,
          width: 24.w,
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            title.tr,
            style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                .copyWith(color: AppColors.c222222),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
