import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TechnicalSupportScreen extends StatelessWidget {
  final String whatsappNumber = '1234567890';

  Future<void> _launchWhatsApp() async {
    final String whatsappUrl = 'https://wa.me/$whatsappNumber';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Technical Support',
        onCallBack: () {
          NavigationService.goBack();
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'If you are facing any technical issues, you can contact us through the following link:',
              style: TextFontStyle.headline20w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(20.h),
            customButton(
              name: 'Visit Technical Suppot',
              height: 55.h,
              minWidth: Get.width / 1.5,
              onCallBack: _launchWhatsApp,
              context: context,
            )
          ],
        ),
      ),
    );
  }
}
