import 'package:cached_network_image/cached_network_image.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/ui_helpers.dart';

class BuildHeaderCard extends StatelessWidget {
  const BuildHeaderCard(
      {super.key, this.image, this.courseTitle, this.duration});
  final image;
  final courseTitle;
  final duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132.h,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130.w,
            height: 120.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
            child: CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          UIHelper.horizontalSpace(12.w),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextFontStyle.textStyle13w600c9AB2A8StyleGTWalsheim,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Duration: ",
                        overflow: TextOverflow.ellipsis,
                        style: TextFontStyle
                            .textStyle16w400c999999StyleGTWalsheim
                            .copyWith(color: AppColors.c8C8C8C),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        duration,
                        overflow: TextOverflow.ellipsis,
                        style: TextFontStyle
                            .textStyle14w400c9AB2A8StyleGTWalsheim
                            .copyWith(color: AppColors.c8C8C8C),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
