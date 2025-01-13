import 'dart:developer';

import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/features/profile_screen/model/technical_support_response.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TechnicalSupportScreen extends StatefulWidget {
  @override
  State<TechnicalSupportScreen> createState() => _TechnicalSupportScreenState();
}

class _TechnicalSupportScreenState extends State<TechnicalSupportScreen> {
  @override
  void initState() {
    gettechnicalSupportRxObj.gettechnicalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title: 'Technical Support',
          onCallBack: () {
            NavigationService.goBack;
          },
        ),
        body: StreamBuilder(
            stream: gettechnicalSupportRxObj.technicalData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  TechnicalSupportResponse technicalData = snapshot.data;

                  if (technicalData.data == null) {
                    return Center(child: Text('No courses available'));
                  } else {
                    return SingleChildScrollView(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'If you are facing any technical issues, you can contact us through the following link:',
                            style: TextFontStyle
                                .headline20w500c222222StyleGTWalsheim,
                          ),
                          UIHelper.verticalSpace(20.h),
                          customButton(
                            name: 'Visit Technical Suppot',
                            height: 55.h,
                            minWidth: Get.width / 1.5,
                            onCallBack: () async {
                              final String whatsappUrl =
                                  'https://wa.me/${technicalData.data!.user!.url!}';

                              if (await canLaunch(whatsappUrl)) {
                                await launch(whatsappUrl);
                              } else {
                                throw 'Could not launch WhatsApp';
                              }
                              log(technicalData.data!.user!.url.toString());
                            },
                            context: context,
                          )
                        ],
                      ),
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
            }));
 
 
  }
}
