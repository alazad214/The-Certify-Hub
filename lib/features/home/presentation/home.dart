import 'package:cached_network_image/cached_network_image.dart';
import 'package:christiandimene/common_widgets/custom_textfeild.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/home/model/course_response.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Course? data;
  String url = "https://christiandimene.reigeeky.com/";

  @override
  void initState() {
    getCourseRxObj.getCourseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          children: [
            ///home header.....
            _buildHomeHeader(),
            UIHelper.verticalSpace(12.h),

            ///search textfield...
            CustomTextfield(
                hintText: 'Search a certification',
                fillColor: AppColors.white,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 13),
                  child: SvgPicture.asset(
                    Assets.icons.search,
                    height: 20,
                    width: 20,
                  ),
                )),
            UIHelper.verticalSpace(26.h),

            ///build custom card.....
            _buildHomeCustomCard(),
            UIHelper.verticalSpace(26.h),
          ],
        ),
      ),
    ));
  }

  Widget _buildHomeCustomCard() {
    return StreamBuilder(
      stream: getCourseRxObj.getCourse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            CourseResponse courseData = snapshot.data;

            if (courseData.data == null || courseData.data!.isEmpty) {
              return Center(child: Text('No courses available'));
            } else {
              return GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: courseData.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.w,
                  crossAxisSpacing: 8.w,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  data = courseData.data![index];
                  return InkWell(
                    onTap: () {
                      NavigationService.navigateToWithArgs(
                          Routes.certificationScreen, {'data': data});
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///COURSE IMAGE...
                          Container(
                            height: 115.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: url + data!.courseFeatureImage,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),

                          UIHelper.verticalSpace(8.h),

                          ///COURSE TITLE...
                          Text(
                            "${data!.courseTitle}",
                            style: TextFontStyle
                                .textStyle16w500c222222StyleGTWalsheim,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const SizedBox.shrink();
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Row _buildHomeHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey, Al Azad 👋',
                style: TextFontStyle.headline24w400c222222StyleGTWalsheim,
              ),
              UIHelper.verticalSpace(10.h),
              Text(
                'Pick a certification to get started!',
                style: TextFontStyle.headline18w400cFFFFFFStyleGTWalsheim,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            NavigationService.navigateTo(Routes.notification);
          },
          child: Container(
            height: 44.h,
            width: 44.w,
            padding: EdgeInsets.all(7.sp),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              Assets.icons.notification,
              height: 24.h,
              width: 24.w,
            ),
          ),
        )
      ],
    );
  }
}
