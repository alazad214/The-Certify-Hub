import 'dart:developer';

import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/profile_screen/model/academic_support_response.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AcademicSupportScreen extends StatefulWidget {
  @override
  State<AcademicSupportScreen> createState() => _AcademicSupportScreenState();
}

class _AcademicSupportScreenState extends State<AcademicSupportScreen> {
  @override
  void initState() {
    getAcademicSupportRxObj.getAcademicData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title: 'Academic Support',
          onCallBack: () {
            NavigationService.goBack;
          },
        ),
        body: StreamBuilder(
          stream: getAcademicSupportRxObj.academicData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              log('Stream error: ${snapshot.error}');
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (snapshot.hasData) {
              AcademicSupportResponse? academicData = snapshot.data;
              if (academicData?.data?.user?.url == null) {
                return Center(
                    child: Text('No academic support URL available.'));
              }

              return SingleChildScrollView(
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
                      onCallBack: () async {
                        final String whatsappUrl =
                            'https://wa.me/${academicData!.data!.user!.url!}';

                        if (await canLaunch(whatsappUrl)) {
                          await launch(whatsappUrl);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Could not launch WhatsApp')),
                          );
                        }
                      },
                      context: context,
                    )
                  ],
                ),
              );
            }

            return Center(child: Text('No data available.'));
          },
        ));
  }
}
