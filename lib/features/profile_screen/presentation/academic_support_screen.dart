import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AcademicSupportScreen extends StatelessWidget {
  final String whatsappNumber = '0987654321';

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
        title: 'Academic Support',
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
              'If you need assistance with academic-related queries, feel free to contact us through the link below:',
              style: TextFontStyle.headline20w500c222222StyleGTWalsheim,
            ),
            UIHelper.verticalSpace(20.h),
            customButton(
              name: 'Contact Academic Support',
              height: 55.h,
              minWidth: Get.width / 1.5,
              onCallBack: _launchWhatsApp,
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
