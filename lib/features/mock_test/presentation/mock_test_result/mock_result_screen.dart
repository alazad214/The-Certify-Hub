import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_button.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';

class MockTestResult extends StatefulWidget {
  const MockTestResult({super.key});

  @override
  State<MockTestResult> createState() => _MockTestResultState();
}

class _MockTestResultState extends State<MockTestResult> {
  int _selectedOption = -1;
  final List<String> options = [
    "To provide a platform for applications to run",
    "To manage hardware and software resources",
    "To provide a platform for applications to run",
    "To provide a platform for applications to run",
  ];

  final List<int> questions = List.generate(13, (index) => index + 1);

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
                height: 56.h,
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
              // Padding(
              //   padding: const EdgeInsets.all(24.0),
              //   child: Container(
              //     width: double.infinity,
              //     height: 380.h,
              //     decoration: BoxDecoration(
              //       color: AppColors.cFFFFFF,
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Column(
              //         children: [
              //           Text(
              //             'What is the purpose of an operating system?'.tr,
              //             style: TextFontStyle
              //                 .textStyle16w400c999999StyleGTWalsheim
              //                 .copyWith(color: AppColors.c000000),
              //           ),
              //           UIHelper.verticalSpace(16.h),
              //           _questionItem(),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.cFFFFFF,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Question 1",
                            style: TextFontStyle
                                .textStyle12w400c9AB2A8StyleGTWalsheim,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'What is the primary function of the operating system in a computer?',
                            style: TextFontStyle
                                .headline18w500c222222StyleGTWalsheim,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: _questionItem(),
                          ),
                          UIHelper.verticalSpace(16.h),
                          Text.rich(
                            TextSpan(
                              text: "Description: ",
                              children: [
                                TextSpan(
                                  text:
                                      "The operating system (OS) is essential for managing the computer's hardware and software. It acts as an intermediary between users and the computer hardware, ensuring that applications have the resources they need to function properly.",
                                  style: TextFontStyle
                                      .textStyle12w400c9AB2A8StyleGTWalsheim,
                                ),
                              ],
                              style: TextFontStyle
                                  .textStyle12w400c9AB2A8StyleGTWalsheim
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.c000000),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.cFFFFFF,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Question 1",
                            style: TextFontStyle
                                .textStyle12w400c9AB2A8StyleGTWalsheim,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'What is the primary function of the operating system in a computer?',
                            style: TextFontStyle
                                .headline18w500c222222StyleGTWalsheim,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: _questionItem(),
                          ),
                          UIHelper.verticalSpace(16.h),
                          Text.rich(
                            TextSpan(
                              text: "Description: ",
                              children: [
                                TextSpan(
                                  text:
                                      "The operating system (OS) is essential for managing the computer's hardware and software. It acts as an intermediary between users and the computer hardware, ensuring that applications have the resources they need to function properly.",
                                  style: TextFontStyle
                                      .textStyle12w400c9AB2A8StyleGTWalsheim,
                                ),
                              ],
                              style: TextFontStyle
                                  .textStyle12w400c9AB2A8StyleGTWalsheim
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.c000000),
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width, // Full width of the screen
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        height: 95.h,
        color: Colors.white, // Optional: Set a background color if needed
        child: Center(
          child: customButton(
            minWidth:
                double.infinity, // Set the button to take full width if needed
            height: 48.h,
            name: 'Buy Now',
            onCallBack: () {},
            context: context,
          ),
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
              color: AppColors.cE9EEEC,
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
}
