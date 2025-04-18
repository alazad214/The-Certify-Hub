import 'package:christiandimene/constants/app_constants.dart';
import 'package:christiandimene/constants/textfield_validation.dart';
import 'package:christiandimene/helpers/di.dart';
import 'package:christiandimene/loading_screen.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../common_widgets/custom_textfeild.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/ui_helpers.dart';

class CreateNewPassScreen extends StatefulWidget {
  const CreateNewPassScreen({super.key});

  @override
  State<CreateNewPassScreen> createState() => _CreateNewPassScreenState();
}

class _CreateNewPassScreenState extends State<CreateNewPassScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var isVisibility = false;

  togglePassword() {
    setState(() {
      isVisibility = !isVisibility;
    });
  }

  @override
  void initState() {
    togglePassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.0, vertical: 55.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UIHelper.verticalSpace(32.0),
                  Text(
                    'Create New Password!'.tr,
                    style: TextFontStyle.headline32w700cFFFFFFStyleGTWalsheim
                        .copyWith(color: AppColors.c000000),
                    textAlign: TextAlign.center,
                  ),
                  UIHelper.verticalSpace(8.0),
                  Text(
                    "Sign up to continue".tr,
                    style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                        .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              UIHelper.verticalSpace(55.0),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        "Please enter and confirm your new password. You will need to login after you reset. "
                            .tr,
                        style: TextFontStyle
                            .textStyle16w400c999999StyleGTWalsheim
                            .copyWith(
                                color: AppColors.c000000.withOpacity(0.6)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    UIHelper.verticalSpace(16.0),
                    CustomTextfield(
                      hintText: 'New Password',
                      borderRadius: 12.0,
                      controller: passwordController,
                      isObsecure: isVisibility,
                      validator: InputValidator.validatePassword,
                    ),
                    UIHelper.verticalSpace(16.0),
                    CustomTextfield(
                      hintText: 'Confirm Password',
                      borderRadius: 12.0,
                      controller: confirmPasswordController,
                      isObsecure: isVisibility,
                      validator: InputValidator.validatePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            togglePassword();
                          });
                        },
                        icon: isVisibility == false
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                    ),
                    UIHelper.verticalSpace(129.0),
                    customButton(
                      name: 'Reset Password',
                      onCallBack: () {
                        if (_formKey.currentState!.validate()) {
                          resetPasswordRxObj
                              .resetPassword(
                            email: appData.read(kUserEmail),
                            password: passwordController.text,
                            passwordConfirmation:
                                confirmPasswordController.text,
                            otp: appData.read(kforgetOtp),
                          )
                              .then((value) {
                            Get.offAll(() => Loading());
                          });

                          appData.erase();
                        }
                      },
                      context: context,
                      borderRadius: 12.r,
                      textStyle: TextFontStyle
                          .headline18w500c222222StyleGTWalsheim
                          .copyWith(
                              color: AppColors.c222222,
                              fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
