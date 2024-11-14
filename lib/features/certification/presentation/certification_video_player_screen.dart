import 'package:chewie/chewie.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/widgets/custom_ask_me_card.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class CertificationVideoPlayerScreen extends StatefulWidget {
  const CertificationVideoPlayerScreen({super.key});

  @override
  State<CertificationVideoPlayerScreen> createState() =>
      _CertificationVideoPlayerScreenState();
}

class _CertificationVideoPlayerScreenState
    extends State<CertificationVideoPlayerScreen> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  bool isLoading = true;

  String videoUlr =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    // ignore: deprecated_member_use
    videoPlayerController = VideoPlayerController.network(
      videoUlr,
    );

    try {
      await videoPlayerController.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: videoPlayerController.value.aspectRatio,
        autoPlay: true,
        allowFullScreen: true,
        looping: true,
      );
    } catch (e) {}

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                isLoading
                    ? Container(
                        height: 300.h,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.r),
                                bottomRight: Radius.circular(30.r))),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 252, 5, 66),
                            strokeWidth: 5,
                          ),
                        ),
                      )
                    : chewieController != null
                        ? Container(
                            height: 300.h,
                            clipBehavior: Clip.antiAlias,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.r),
                                bottomRight: Radius.circular(30.r),
                              ),
                            ),
                            child: Chewie(
                              controller: chewieController!,
                            ),
                          )
                        : const Center(
                            child: Text(
                              'Video not available',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                Positioned(
                    top: 40.h,
                    left: 20.w,
                    child: InkWell(
                        onTap: () {
                          NavigationService.goBack;
                        },
                        child: SvgPicture.asset(Assets.icons.backButtonFrame))),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(24.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'What is Time Management?',
                    style: TextFontStyle.headline20w500c222222StyleGTWalsheim,
                  ),
                  UIHelper.verticalSpace(24.h),
                  Container(
                    padding: EdgeInsets.all(16.sp),
                    height: 400.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Up Next',
                            style: TextFontStyle
                                .headline20w500c222222StyleGTWalsheim,
                          ),
                          _buildLessonItem(),
                        ],
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(24.h),
                  CustomAskMeCard(),
                  UIHelper.verticalSpace(120.h),
                ],
              ),
            )
          ],
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

  Widget _buildLessonItem() {
    return ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              height: 93.h,
              padding: EdgeInsets.all(8.sp),
              margin: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 103.w,
                    height: 120.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Image.asset(
                      Assets.images.homeCardImage.path,
                      fit: BoxFit.cover,
                    ),
                  ),
                  UIHelper.horizontalSpace(12.w),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Weekend lessons for children',
                          overflow: TextOverflow.ellipsis,
                          style: TextFontStyle
                              .headline20w500c222222StyleGTWalsheim,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                '79 Lessons',
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
                                '8,289 Students',
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
                  SvgPicture.asset(
                    Assets.icons.playButtonContainer,
                    height: 30.h,
                    width: 30.w,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
