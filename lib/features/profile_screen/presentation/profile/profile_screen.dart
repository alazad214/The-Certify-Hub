import 'dart:developer';

import 'package:christiandimene/constants/app_constants.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/profile_screen/model/get_profile_response.dart';
import 'package:christiandimene/features/profile_screen/presentation/about_us.dart';
import 'package:christiandimene/features/profile_screen/presentation/privacy_policy.dart';
import 'package:christiandimene/features/profile_screen/presentation/terms_and_conditions.dart';
import 'package:christiandimene/features/profile_screen/widget/logout_button_dialog.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/di.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:christiandimene/networks/dio/dio.dart';
import 'package:christiandimene/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../helpers/all_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? profileData;
  @override
  void initState() {
    getProfileDataRxObj.getprofileData();
    super.initState();
  }

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

                StreamBuilder(
                  stream: getProfileDataRxObj.getProfileCreateData,
                  builder: (context, snapshot) {
                    profileData = snapshot.data?.data?.user;

                    log('==================USER ID============================');

                    // appData.write("UserId", profileData!.id.toString());
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          //PROFILE IMAGE...
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Background Circle..
                                  Container(
                                    height: 110.0.h,
                                    width: 110.0.w,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.amber,
                                    ),
                                    child: profileData?.avatar != ""
                                        ? Image.network(
                                            baseUrl + profileData!.avatar!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            Assets.images.profileAvatar.path,
                                            fit: BoxFit.cover,
                                          ),
                                  ),

                                  // Container(
                                  //   height: 110.0.h,
                                  //   width: 110.0.w,
                                  //   decoration: BoxDecoration(
                                  //     shape: BoxShape.circle,
                                  //   ),
                                  //   child: profileData?.avatar != null
                                  //       ? Image.network(
                                  //           "${/profileData?.avatar}",
                                  //           fit: BoxFit.cover,
                                  //         )
                                  //       : Image.asset(
                                  //           Assets.images.profileImage.path),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(16.h),

                          //USER NAME...
                          Text(
                            profileData?.name ?? ' ',
                            style: TextFontStyle
                                .headline20w700c222222StyleGTWalsheim,
                          ),
                          UIHelper.verticalSpace(8.h),

                          // // USER Phone...
                          // profileData!.phoneNumber != null
                          //     ? Text(
                          //         profileData?.phoneNumber ?? ' ',
                          //         style: TextFontStyle
                          //             .textStyle14w500c6B6B6BtyleGTWalsheim,
                          //       )
                          //     :SizedBox(
                          //         height: 0.1.h,
                          //       ),
                          // if (profileData!.phoneNumber != null)
                          //   UIHelper.verticalSpace(8.h),

                          ///USER EMAIL...
                          profileData!.phoneNumber != null
                              ? Text(
                                  profileData?.email ?? ' ',
                                  style: TextFontStyle
                                      .textStyle14w500c6B6B6BtyleGTWalsheim,
                                )
                              : SizedBox.shrink(),
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),

                UIHelper.verticalSpace(40.h),
                profileItem(
                  title: 'Edit Profile',
                  svg: SvgPicture.asset(Assets.icons.profile),
                  onPressed: () {
                    NavigationService.navigateToWithArgs(
                        Routes.editProfile, {'data': profileData});
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
                  onPressed: () {
                    Get.to(() => PrivacyPolicyScreen());
                  },
                ),
                Divider(
                  color: AppColors.cBBCBC4,
                  thickness: 0.5,
                ),
                profileItem(
                  title: 'Terms & Conditions',
                  svg: SvgPicture.asset(Assets.icons.check),
                  onPressed: () {
                    Get.to(() => TermsAndConditionsScreen());
                  },
                ),
                Divider(
                  color: AppColors.cBBCBC4,
                  thickness: 0.5,
                ),
                profileItem(
                  title: 'About Us',
                  svg: SvgPicture.asset(Assets.icons.help),
                  onPressed: () {
                    Get.to(() => AboutUsScreen());
                  },
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
          postLogoutRxObj.logogoutF().then((value) {
            NavigationService.navigateToReplacement(Routes.anotherOnboading);
          });
        });
        appData.write(kKeyIsLoggedIn, false);
        appData.remove(kKeyAccessToken);
        appData.read(userId).toString();
        DioSingleton.instance.update('');
        appData.erase();
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
