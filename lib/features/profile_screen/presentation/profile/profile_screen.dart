import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/profile_screen/widget/logout_button_dialog.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../helpers/all_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.0.w, vertical: 25.0.h),
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Profile',
                    style: TextFontStyle.headline18w500c222222StyleGTWalsheim,
                  ),
                ),
                ProfileSection(),
                UIHelper.verticalSpace(16.h),
                Text(
                  'Daniel Hamilton',
                  style: TextFontStyle.headline20w700c222222StyleGTWalsheim,
                ),
                Text(
                  'danielhamilton@gmail.com',
                  style: TextFontStyle.textStyle14w500c6B6B6BtyleGTWalsheim,
                ),
                UIHelper.verticalSpace(40.h),
                profileItem(
                  title: 'Edit Profile',
                  svg: SvgPicture.asset(Assets.icons.profile),
                  onPressed: () {
                    NavigationService.navigateTo(Routes.editProfile);
                  },
                ),
                Divider(
                  color: AppColors.cBBCBC4,
                  thickness: 0.5,
                ),
                profileItem(
                  title: 'Notification',
                  svg: SvgPicture.asset(Assets.icons.notification),
                  onPressed: () {
                    NavigationService.navigateTo(Routes.notification);
                  },
                ),
                Divider(
                  color: AppColors.cBBCBC4,
                  thickness: 0.5,
                ),
                profileItem(
                  title: 'Privacy Policy',
                  svg: SvgPicture.asset(Assets.icons.shieldTick),
                  onPressed: () {},
                ),
                Divider(
                  color: AppColors.cBBCBC4,
                  thickness: 0.5,
                ),
                profileItem(
                  title: 'Terms & Conditions',
                  svg: SvgPicture.asset(Assets.icons.check),
                  onPressed: () {},
                ),
                Divider(
                  color: AppColors.cBBCBC4,
                  thickness: 0.5,
                ),
                profileItem(
                  title: 'About Us',
                  svg: SvgPicture.asset(Assets.icons.help),
                  onPressed: () {},
                ),
                UIHelper.verticalSpace(24.h),

                ///logout button....
                _buildLogoutButton(),
                UIHelper.verticalSpace(30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildLogoutButton() {
    return GestureDetector(
      onTap: () {
        logOutButtonDialog(context, () {
          NavigationService.navigateToReplacement(Routes.anotherOnboading);
        });
      },
      child: Container(
        height: 62.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.cFDB338,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.cFDB338,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.icons.logout,
              height: 24.h,
              width: 24.w,
              // ignore: deprecated_member_use
              color: AppColors.c222222,
            ),
            UIHelper.horizontalSpace(10.w),
            Text(
              'Logout',
              overflow: TextOverflow.ellipsis,
              style: TextFontStyle.headline18w500c222222StyleGTWalsheim,
            ),
          ],
        ),
      ),
    );
  }
}

class profileItem extends StatelessWidget {
  profileItem({
    super.key,
    required this.title,
    required this.svg,
    required this.onPressed,
  });

  final String title;
  final Widget svg;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 12.0.h),
        child: Row(
          children: [
            svg,
            UIHelper.horizontalSpace(8.w),
            Expanded(
              child: Text(
                title,
                style: TextFontStyle.textStyle16w400c999999StyleGTWalsheim
                    .copyWith(color: AppColors.c000000),
              ),
            ),
            SvgPicture.asset(
              Assets.icons.arrowBlacks,
              height: 24.h,
              width: 24.w,
              // ignore: deprecated_member_use
              color: AppColors.c222222,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Background Circle
              Container(
                height: 137.0.h,
                width: 137.0.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cBBCBC4,
                ),
              ),
              Container(
                height: 110.0.h,
                width: 110.0.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(Assets.images.profileImage.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
