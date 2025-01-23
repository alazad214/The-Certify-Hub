import 'dart:convert';
import 'package:christiandimene/constants/app_constants.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/certification/model/course_details_response.dart';
import 'package:christiandimene/helpers/di.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/features/certification/model/lesson_model_response.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:christiandimene/provider/video_screen_provider/video_screen_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import '../../../gen/assets.gen.dart';

class CertificationVideoPlayerScreen extends StatefulWidget {
  CourseContent? data;
  LessonsModelResponse? lessonData;
  CourseModule? courseModule;
  CertificationVideoPlayerScreen(
      {this.lessonData, this.data, this.courseModule, Key? key})
      : super(key: key);

  @override
  State<CertificationVideoPlayerScreen> createState() =>
      _CertificationVideoPlayerScreenState();
}

class _CertificationVideoPlayerScreenState
    extends State<CertificationVideoPlayerScreen> {
  late WebViewController _controller;
  bool _isControllerReady = false;
  int? currentPlayingVideoIndex;
  int? currentPlayingVideoId;
  String? currentVideoTitle;

  Future<void> _initializeWebView() async {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          debugPrint('Page started loading: $url');
        },
        onPageFinished: (url) {
          debugPrint('Page finished loading: $url');

          context.read<VideoScreenProvider>().setLoading(false);
        },
      ))
      ..addJavaScriptChannel(
        'VimeoChannel',
        onMessageReceived: (message) {
          if (message.message == 'enter_full_screen') {
            _lockOrientation();
          } else if (message.message == 'exit_full_screen') {
            _unlockOrientation();
          } else if (message.message == "ended") {
            context.read<VideoScreenProvider>().setCompleted(true);
            postProgressRxObj.progressData(courseId: {
              "course_id": widget.data!.courseId,
              "course_content_id": widget.data!.id.toString(),
              "is_completed": true
            });

            postTrackContentRxObj.postTrackContent(
              userId: appData.read(userId),
              courseModuleId: widget.courseModule!.id!,
              courseContentId: widget.data!.id!,
              isCompleted: true,
            );
          }
        },
      );

    _loadVimeoVideo(widget.data!.videoFile!);
    setState(() {
      currentVideoTitle = widget.data!.contentTitle;
      _isControllerReady = true;
    });
  }

  void _loadVimeoVideo(String videoId) {
    final html = '''
    <html>
      <head>
        <style>
          body { 
            margin: 0; 
            background-color: black; 
            overflow: hidden;
          }
          iframe { 
            position: absolute; 
            top: 0; 
            left: 0; 
            width: 100%; 
            height: 100%; 
            border: none; 
          }
          html, body { 
            height: 100%; 
            width: 100%; 
            overflow: hidden; 
            margin: 0;
          }
        </style>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <script src="https://player.vimeo.com/api/player.js"></script>
      </head>
      <body>
        <iframe 
          id="vimeo-player"
         src="$videoId" 
          width="100%" height="100%" frameborder="0" allow="fullscreen" 
        ></iframe>
        <script>
          document.addEventListener("DOMContentLoaded", function() {
            var iframe = document.getElementById('vimeo-player');
            window.player = new Vimeo.Player(iframe);

            window.player.on("fullscreenchange", function () {
              if (document.fullscreenElement) {
                VimeoChannel.postMessage("enter_full_screen");
              } else {
                VimeoChannel.postMessage("exit_full_screen");
              }
            });

            window.player.on('ended', function (data) {
                VimeoChannel.postMessage("ended");
            });
          });
        </script>
      </body>
    </html>
  ''';

    final String contentBase64 = base64Encode(utf8.encode(html));
    _controller.loadRequest(Uri.parse('data:text/html;base64,$contentBase64'));
  }

  void _lockOrientation() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  }

  void _unlockOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void initState() {
    super.initState();
    _initializeWebView();
    currentPlayingVideoId = widget.data!.id!;
  }

  @override
  void dispose() {
    _unlockOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: currentVideoTitle ?? 'Loading...',
        onCallBack: () {
          NavigationService.goBack;
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 195.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.allPrimaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: _isControllerReady
                    ? Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r)),
                        height: 200.h,
                        child: WebViewWidget(
                          controller: _controller,
                        ))
                    : Center(child: CircularProgressIndicator()),
              ),
              UIHelper.verticalSpace(24.h),

              ///UP NEXT=========>>>>>>>>>
              Container(
                padding: EdgeInsets.all(16.sp),
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
                        style:
                            TextFontStyle.headline20w500c222222StyleGTWalsheim,
                      ),
                      ListView.builder(
                          itemCount: widget.lessonData!.data!.contents!.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (_, index) {
                            CourseContent? video;
                            video = widget.lessonData!.data!.contents![index];

                            bool isCurrentlyPlaying =
                                currentPlayingVideoIndex == index;

                            return video.id! <= currentPlayingVideoId!
                                ? SizedBox()
                                : InkWell(
                                    onTap: () {
                                      if (video!.isPurchased == false) {
                                        if (video.beforePurchase == 1) {
                                          _loadVimeoVideo(video.videoFile!);
                                          setState(() {
                                            currentPlayingVideoIndex = index;
                                            currentVideoTitle =
                                                video!.contentTitle;
                                            currentPlayingVideoId = video.id;
                                          });
                                        } else {
                                          Get.snackbar(
                                            backgroundColor: Colors.red,
                                            'Something went wrong!',
                                            'Enroll in this course to get started',
                                          );
                                        }
                                      } else {
                                        _loadVimeoVideo(video.videoFile!);
                                        setState(() {
                                          currentPlayingVideoIndex = index;
                                          currentVideoTitle =
                                              video!.contentTitle;
                                          currentPlayingVideoId = video.id;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 93.h,
                                      padding: EdgeInsets.all(8.sp),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 8,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                        border: Border.all(
                                          color: isCurrentlyPlaying
                                              ? AppColors.c245741
                                              : Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 103.w,
                                            height: 120.h,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: Image.asset(
                                              Assets.images.homeCardImage.path,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          UIHelper.horizontalSpace(12.w),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${video.contentTitle}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextFontStyle
                                                      .headline20w500c222222StyleGTWalsheim,
                                                ),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        video.contentLength!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextFontStyle
                                                            .textStyle14w400c9AB2A8StyleGTWalsheim
                                                            .copyWith(
                                                                color: AppColors
                                                                    .c8C8C8C),
                                                      ),
                                                    ),
                                                    video.viewed == true
                                                        ? Container(
                                                            width: 1.5.w,
                                                            height: 16.h,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.w),
                                                            color: AppColors
                                                                .c8C8C8C,
                                                          )
                                                        : SizedBox.shrink(),
                                                    Flexible(
                                                      child: Text(
                                                        video.viewed == true
                                                            ? "Viewed"
                                                            : "",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextFontStyle
                                                            .textStyle14w400c9AB2A8StyleGTWalsheim
                                                            .copyWith(
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          (video.isPurchased == true)
                                              ? SvgPicture.asset(
                                                  Assets.icons
                                                      .playButtonContainer,
                                                  height: 30.h,
                                                  width: 30.w,
                                                )
                                              : video.beforePurchase == 1
                                                  ? SvgPicture.asset(
                                                      Assets.icons
                                                          .playButtonContainer,
                                                      height: 30.h,
                                                      width: 30.w,
                                                    )
                                                  : SvgPicture.asset(
                                                      Assets.icons.lockSvg,
                                                      height: 30.h,
                                                      width: 30.w,
                                                    )
                                        ],
                                      ),
                                    ),
                                  );
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
