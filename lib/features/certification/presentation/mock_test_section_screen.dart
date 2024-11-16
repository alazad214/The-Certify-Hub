import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/certification/widgets/custom_appbar2.dart';
import 'package:christiandimene/features/mock_test/widgets/mock_test_popup.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/all_routes.dart';

class MockTestSectionScreen extends StatefulWidget {
  const MockTestSectionScreen({super.key});

  @override
  State<MockTestSectionScreen> createState() => _CertificationMainScreenState();
}

class _CertificationMainScreenState extends State<MockTestSectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(21.h),
              CustomAppbar2(
                title: 'Managing Your Time Wisely',
                subtitle: '0/5 lesson(s) completed',
              ),
              UIHelper.verticalSpace(26.h),

              ///build pdf item......
              _buildPDFItem()
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        height: 95.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '50.00 ${'\$'}',
              style: TextFontStyle.headline24w700c245741StyleGTWalsheim,
            ),
            customButton(
                minWidth: 170.w,
                height: 48.h,
                name: 'Buy Now',
                onCallBack: () {},
                context: context)
          ],
        ),
      ),
    );
  }

  ///build pdf item......
  Widget _buildPDFItem() {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            mockTestPopup(
              context,
              () {},
              () {},
            );
          },
          child: Container(
            height: 84.h,
            padding: EdgeInsets.all(8.sp),
            margin: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Container(
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(
                    Assets.images.quiz.path,
                    fit: BoxFit.contain,
                  ),
                ),
                UIHelper.horizontalSpace(12.w),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekend lessons for children',
                        overflow: TextOverflow.ellipsis,
                        style: TextFontStyle
                            .textStyle16w400c999999StyleGTWalsheim
                            .copyWith(color: AppColors.c222222),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Pdf',
                              overflow: TextOverflow.ellipsis,
                              style: TextFontStyle
                                  .textStyle14w400c9AB2A8StyleGTWalsheim
                                  .copyWith(color: AppColors.c8C8C8C),
                            ),
                          ),
                          Container(
                            width: 2.w,
                            height: 12.h,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            color: AppColors.c8C8C8C,
                          ),
                          Flexible(
                            child: Text(
                              '2 pages',
                              overflow: TextOverflow.ellipsis,
                              style: TextFontStyle
                                  .textStyle14w400c9AB2A8StyleGTWalsheim
                                  .copyWith(color: AppColors.c8C8C8C),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
