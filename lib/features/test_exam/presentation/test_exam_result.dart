import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../common_widgets/custom_button.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/ui_helpers.dart';

class TestExamResult extends StatefulWidget {
  @override
  State<TestExamResult> createState() => _TestExamResultState();
}

class _TestExamResultState extends State<TestExamResult> {
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
      appBar: CustomAppbar(title: 'Test: Managing Your Time Wisely'),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                  style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                      .copyWith(
                    color: AppColors.c000000,
                  ),
                ),
                Text(
                  'Try Again'.tr,
                  style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
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
              ],
            ),
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

  Container _buildTimeAndWidget() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
          child: Row(
            children: [
              Row(
                children: [
                  SvgPicture.asset(Assets.icons.clockColor),
                  UIHelper.horizontalSpace(8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Time Taken'.tr,
                        style: TextFontStyle
                            .textStyle12w400c9AB2A8StyleGTWalsheim
                            .copyWith(color: AppColors.c000000),
                      ),
                      Text(
                        '15 Mins'.tr,
                        style: TextFontStyle
                            .textStyle16w500c222222StyleGTWalsheim
                            .copyWith(color: AppColors.c000000),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                height: 54.h,
                width: 1.w,
                color: AppColors.cB5B5B5,
              ),
              Row(
                children: [
                  SvgPicture.asset(Assets.icons.marks),
                  UIHelper.horizontalSpace(8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your Score'.tr,
                        style: TextFontStyle
                            .textStyle12w400c9AB2A8StyleGTWalsheim
                            .copyWith(color: AppColors.c000000),
                      ),
                      Text(
                        '30%'.tr,
                        style: TextFontStyle
                            .textStyle16w500c222222StyleGTWalsheim
                            .copyWith(color: AppColors.c000000),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}



//################################################################################

// import 'package:christiandimene/common_widgets/custom_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../constants/text_font_style.dart';
// import '../../../gen/assets.gen.dart';
// import '../../../gen/colors.gen.dart';
// import '../../../helpers/ui_helpers.dart';

// class TestExamResult extends StatefulWidget {
//   @override
//   State<TestExamResult> createState() => _TestExamResultState();
// }

// class _TestExamResultState extends State<TestExamResult> {
//   final List<Map<String, dynamic>> questions = [
//     {
//       "question": "What is the primary function of an operating system?",
//       "options": [
//         "To provide a platform for applications to run",
//         "To manage hardware and software resources",
//         "To secure the computer from viruses",
//         "To increase processing speed"
//       ],
//       "correctIndex": 1,
//       "userSelectedIndex": 1,
//     },
//     {
//       "question": "Which language is primarily used for Android development?",
//       "options": ["Python", "Java", "Swift", "Kotlin"],
//       "correctIndex": 3,
//       "userSelectedIndex": 2,
//     },
//     {
//       "question": "Which language is primarily used for Android development?",
//       "options": ["Python", "Java", "Swift", "Kotlin"],
//       "correctIndex": 0,
//       "userSelectedIndex": 1,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(title: 'Test: Managing Your Time Wisely'),
//       body: SafeArea(
//         child: ListView.builder(
//           itemCount: questions.length,
//           padding: const EdgeInsets.all(16),
//           itemBuilder: (context, index) {
//             final questionData = questions[index];
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Question ${index + 1}",
//                         style:
//                             TextFontStyle.textStyle12w400c9AB2A8StyleGTWalsheim,
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         questionData["question"],
//                         style:
//                             TextFontStyle.headline18w500c222222StyleGTWalsheim,
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 16),
//                       _buildOptions(
//                         questionData["options"],
//                         questionData["correctIndex"],
//                         questionData["userSelectedIndex"],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildOptions(
//       List<String> options, int correctIndex, int userSelectedIndex) {
//     return Column(
//       children: List.generate(options.length, (index) {
//         final isCorrect = index == correctIndex;
//         final isSelected = index == userSelectedIndex;

//         // Outline color logic: green for correct, red for user's wrong selection
//         final outlineColor = isCorrect
//             ? Colors.green
//             : (isSelected && !isCorrect ? Colors.red : Colors.transparent);

//         return Container(
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(
//               color: outlineColor,
//               width: 2,
//             ),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.circle_outlined,
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   options[index],
//                   style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
//                       .copyWith(color: Colors.grey),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Icon(
//                 isCorrect
//                     ? Icons.check_circle
//                     : (isSelected ? Icons.cancel : Icons.circle_outlined),
//                 color: isCorrect
//                     ? Colors.green
//                     : (isSelected ? Colors.red : Colors.transparent),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

// #############################################################################
// #                              previous code Code                                     #
// #############################################################################

// import 'package:christiandimene/common_widgets/custom_appbar.dart';
// import 'package:christiandimene/constants/text_font_style.dart';
// import 'package:christiandimene/gen/colors.gen.dart';
// import 'package:christiandimene/helpers/navigation_service.dart';
// import 'package:christiandimene/helpers/ui_helpers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import '../../../common_widgets/custom_button.dart';
// import '../../../gen/assets.gen.dart';
// import '../../../helpers/all_routes.dart';

// class TestExamResult extends StatefulWidget {
//   const TestExamResult({super.key});

//   @override
//   State<TestExamResult> createState() => _MockTestResultState();
// }

// class _MockTestResultState extends State<TestExamResult> {
//   int _selectedOption = -1;
//   final List<String> options = [
//     "To provide a platform for applications to run",
//     "To manage hardware and software resources",
//     "To provide a platform for applications to run",
//     "To provide a platform for applications to run",
//   ];

//   final List<int> questions = List.generate(13, (index) => index + 1);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(
//         title: 'Test: Managing Your Time Wisely',
//         onCallBack: () {},
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               Center(
//                 child: Image.asset(
//                   Assets.images.characterOops.path,
//                   height: 149.h,
//                   width: 138.w,
//                 ),
//               ),
//               Text(
//                 'You have not passed the quiz!'.tr,
//                 style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim,
//               ),
//               Text(
//                 'Try Again'.tr,
//                 style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
//                     .copyWith(
//                         fontWeight: FontWeight.bold, color: AppColors.c000000),
//               ),
//               UIHelper.verticalSpace(16.h),

//               //TIME AND SCORE...
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildTimeAndWidget(),
//                 ],
//               ),
//               UIHelper.verticalSpace(16.h),

//               //QUESTION RESULT LIST...
//               _questionResultList(),
//               UIHelper.verticalSpace(100.h),
//             ],
//           ),
//         ),
//       ),
//       bottomSheet: Container(
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.symmetric(horizontal: 24.w),
//         height: 95.h,
//         color: Colors.white,
//         child: Center(
//           child: customButton(
//             minWidth: double.infinity,
//             height: 48.h,
//             name: 'Restart Quiz',
//             onCallBack: () {
//               NavigationService.navigateTo(Routes.mockTestSectionScreen);
//             },
//             context: context,
//           ),
//         ),
//       ),
//     );
//   }

//   //QUESTION RESULT LIST...
//   ListView _questionResultList() {
//     return ListView.builder(
//         shrinkWrap: true,
//         primary: false,
//         itemCount: 2,
//         itemBuilder: (_, index) {
//           return Padding(
//             padding: EdgeInsets.all(24.0),
//             child: Container(
//                 decoration: BoxDecoration(
//                   color: AppColors.cFFFFFF,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Question ${index + 1}",
//                         style:
//                             TextFontStyle.textStyle12w400c9AB2A8StyleGTWalsheim,
//                         textAlign: TextAlign.center,
//                       ),
//                       Text(
//                         'What is the primary function of the operating system in a computer?',
//                         style:
//                             TextFontStyle.headline18w500c222222StyleGTWalsheim,
//                         textAlign: TextAlign.center,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: _questionItem(),
//                       ),
//                       UIHelper.verticalSpace(16.h),
//                       Text.rich(
//                         TextSpan(
//                           text: "Description: ",
//                           children: [
//                             TextSpan(
//                               text:
//                                   "The operating system (OS) is essential for managing the computer's hardware and software. It acts as an intermediary between users and the computer hardware, ensuring that applications have the resources they need to function properly.",
//                               style: TextFontStyle
//                                   .textStyle12w400c9AB2A8StyleGTWalsheim,
//                             ),
//                           ],
//                           style: TextFontStyle
//                               .textStyle12w400c9AB2A8StyleGTWalsheim
//                               .copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   color: AppColors.c000000),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//           );
//         });
//   }

//   //TIME AND SCORE...
//   Container _buildTimeAndWidget() {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.cFFFFFF,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
//           child: Row(
//             children: [
//               Row(
//                 children: [
//                   SvgPicture.asset(Assets.icons.question),
//                   UIHelper.horizontalSpace(8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Questions'.tr,
//                         style: TextFontStyle
//                             .textStyle12w400c9AB2A8StyleGTWalsheim
//                             .copyWith(color: AppColors.c000000),
//                       ),
//                       Text(
//                         '10%'.tr,
//                         style: TextFontStyle
//                             .textStyle16w500c222222StyleGTWalsheim
//                             .copyWith(color: AppColors.c000000),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
//                 height: 54.h,
//                 width: 1.w,
//                 color: AppColors.cB5B5B5,
//               ),
//               Row(
//                 children: [
//                   SvgPicture.asset(Assets.icons.question),
//                   UIHelper.horizontalSpace(8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Questions'.tr,
//                         style: TextFontStyle
//                             .textStyle12w400c9AB2A8StyleGTWalsheim
//                             .copyWith(color: AppColors.c000000),
//                       ),
//                       Text(
//                         '10%'.tr,
//                         style: TextFontStyle
//                             .textStyle16w500c222222StyleGTWalsheim
//                             .copyWith(color: AppColors.c000000),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           )),
//     );
//   }

//   Widget _questionItem() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: options.length,
//       itemBuilder: (context, index) {
//         final isSelected = _selectedOption == index;
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               _selectedOption = index;
//             });
//           },
//           child: Container(
//             margin: EdgeInsets.symmetric(vertical: 8),
//             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//             decoration: BoxDecoration(
//               color: AppColors.cE9EEEC,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(
//                 color: isSelected ? AppColors.c31CD63 : Colors.transparent,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   height: 20,
//                   width: 20,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: isSelected ? AppColors.c6B6B6B : Colors.grey,
//                     ),
//                   ),
//                   child: Center(
//                     child: Radio<int>(
//                       value: index,
//                       groupValue: _selectedOption,
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedOption = value!;
//                         });
//                       },
//                       activeColor: AppColors.c6B6B6B,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Text(
//                     options[index],
//                     style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
//                         .copyWith(color: AppColors.c6B6B6B),
//                   ),
//                 ),
//                 if (isSelected) SvgPicture.asset(Assets.icons.correct)
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// #############################################################################
// #                              New Code                                     #
// #############################################################################
