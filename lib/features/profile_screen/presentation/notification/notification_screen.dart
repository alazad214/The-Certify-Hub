import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Notification'.tr,
        onCallBack: () {
                 NavigationService.goBack;
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 29.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Today'.tr,
                      style:
                          TextFontStyle.textStyle16w700c222222StyleGTWalsheim,
                    ),
                  ],
                ),
                UIHelper.verticalSpace(24.h),
                TodayNotificationList(
                  title: 'New Course Available'.tr,
                  subTitle: 'New course available for you'.tr,
                  svg: SvgPicture.asset(
                    Assets.icons.notificationOne,
                    height: 20,
                    width: 20,
                  ),
                ),
                UIHelper.verticalSpace(16.h),
                TodayNotificationList(
                  title: 'New Course Available'.tr,
                  subTitle: 'New course available for you'.tr,
                  svg: SvgPicture.asset(
                    Assets.icons.notificationTwo,
                    height: 20,
                    width: 20,
                  ),
                ),
                UIHelper.verticalSpace(16.h),
                TodayNotificationList(
                  title: 'Today’s Special Offers'.tr,
                  subTitle: 'You Have made a Coure Payment.'.tr,
                  svg: SvgPicture.asset(
                    Assets.icons.notificationThree,
                    height: 20,
                    width: 20,
                  ),
                ),
                UIHelper.verticalSpace(24.h),
                Row(
                  children: [
                    Text(
                      'Yesterday'.tr,
                      style:
                          TextFontStyle.textStyle16w700c222222StyleGTWalsheim,
                    ),
                  ],
                ),
                UIHelper.verticalSpace(24.h),
                TodayNotificationList(
                  title: 'New Course Available'.tr,
                  subTitle: 'New course available for you'.tr,
                  svg: SvgPicture.asset(
                    Assets.icons.notificationTwo,
                    height: 20,
                    width: 20,
                  ),
                ),
                UIHelper.verticalSpace(24.h),
                Row(
                  children: [
                    Text(
                      'Oct 23, 2024'.tr,
                      style:
                          TextFontStyle.textStyle16w700c222222StyleGTWalsheim,
                    ),
                  ],
                ),
                UIHelper.verticalSpace(24.h),
                TodayNotificationList(
                  title: 'Account Setup Successful.!'.tr,
                  subTitle: 'Your Account has been Created.'.tr,
                  svg: SvgPicture.asset(
                    Assets.icons.notificationProfile,
                    height: 20,
                    width: 20,
                  ),
                ),
                UIHelper.verticalSpace(16.h),
                TodayNotificationList(
                  title: 'Email Confirmation'.tr,
                  subTitle: 'Your Account has been Un Verified.'.tr,
                  svg: SvgPicture.asset(
                    Assets.icons.notificationTwo,
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TodayNotificationList extends StatelessWidget {
  const TodayNotificationList({
    super.key,
    required this.title,
    required this.subTitle,
    required this.svg,
  });

  final String title;
  final String subTitle;
  final Widget svg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.c999999.withOpacity(0.1), // Shadow color
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 4), // Shadow position (0,4) for a downward shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: AppColors.cFFFFFF,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: svg,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.tr,
                style: TextFontStyle.headline18w500c222222StyleGTWalsheim,
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                subTitle.tr,
                style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
