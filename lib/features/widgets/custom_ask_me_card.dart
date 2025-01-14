import 'package:cached_network_image/cached_network_image.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/assets.gen.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAskMeCard extends StatelessWidget {
  CustomAskMeCard(
      {this.aiImage, this.aiText, this.aiDescription, this.aiUrl, super.key});
  String? aiImage;
  String? aiText;
  String? aiDescription;
  String? aiUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.c245741,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 77.h,
            width: 74.w,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage(
              imageUrl: baseUrl + aiImage!,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          UIHelper.horizontalSpace(10.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  aiText ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextFontStyle.textStyle14w500c6B6B6BtyleGTWalsheim
                      .copyWith(
                    color: AppColors.cFFFFFF,
                  ),
                ),
                Text(
                  aiDescription ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextFontStyle.textStyle12w400c9AB2A8StyleGTWalsheim
                      .copyWith(color: AppColors.cBBCBC4),
                ),
                InkWell(
                  onTap: () async {
                    final Uri uri = Uri.parse(aiUrl ?? '');
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    } else {
                      throw 'Could not launch $aiUrl';
                    }
                  },
                  child: Container(
                    height: 31.h,
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.cFDB338,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      'Ask me a question',
                      overflow: TextOverflow.ellipsis,
                      style: TextFontStyle.textStyle14w500c6B6B6BtyleGTWalsheim
                          .copyWith(
                        color: AppColors.c222222,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Image.asset(
            Assets.images.askMe2.path,
            height: 70.h,
            width: 80.w,
          )
        ],
      ),
    );
  }
}
