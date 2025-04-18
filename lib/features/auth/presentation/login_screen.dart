import 'package:christiandimene/constants/textfield_validation.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/common_widgets/custom_textfeild.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../networks/api_acess.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  //

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var isVisibility = false;
  bool _isChecked = false;

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.sp),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UIHelper.verticalSpace(32.h),
                  Text(
                    'Welcome Back!'.tr,
                    style: TextFontStyle.headline32w700cFFFFFFStyleGTWalsheim
                        .copyWith(color: AppColors.c000000),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    "Log in to continue your certification journey.".tr,
                    style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                        .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                    textAlign: TextAlign.center,
                  ),
                  UIHelper.verticalSpace(55.h),
                  CustomTextfield(
                    hintText: 'Email',
                    borderRadius: 10.r,
                    controller: emailController,
                    validator: InputValidator.validateEmail,
                  ),
                  UIHelper.verticalSpace(24.h),
                  CustomTextfield(
                    hintText: 'Password',
                    borderRadius: 10.r,
                    controller: passwordController,
                    isObsecure: isVisibility,
                    validator: InputValidator.validatePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          togglePassword();
                        });
                      },
                      icon: isVisibility == true
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value ?? false;
                              });
                            },
                            checkColor: AppColors.white,
                            activeColor: AppColors.c999999,
                            side: BorderSide(
                              color: AppColors.c999999,
                              width: 1.0,
                            ),
                          ),
                          Text(
                            'Remember me'.tr,
                            style: TextFontStyle
                                .textStyle12w400c9AB2A8StyleGTWalsheim
                                .copyWith(
                                    color: AppColors.c6B6B6B,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            NavigationService.navigateTo(Routes.forgetPassword);
                          },
                          child: Text(
                            'Forget Password?'.tr,
                            overflow: TextOverflow.ellipsis,
                            style: TextFontStyle
                                .textStyle14w400c9AB2A8StyleGTWalsheim
                                .copyWith(
                                    color: AppColors.c245741,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  UIHelper.verticalSpace(16.h),
                  customButton(
                    name: 'Log In',
                    onCallBack: () async {
                      if (_formKey.currentState!.validate()) {
                        await postLoginRxObj.postLogin(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        emailController.clear();
                        passwordController.clear();
                      }
                    },
                    context: context,
                    borderRadius: 12.r,
                    textStyle: TextFontStyle
                        .headline18w500c222222StyleGTWalsheim
                        .copyWith(color: AppColors.c000000),
                  ),
                  UIHelper.verticalSpace(24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?'.tr,
                        style: TextFontStyle
                            .textStyle14w400c9AB2A8StyleGTWalsheim
                            .copyWith(color: AppColors.c6B6B6B),
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigationService.navigateTo(Routes.signUpScreen);
                        },
                        child: Text(
                          ' Sign Up'.tr,
                          style: TextFontStyle
                              .textStyle14w400c9AB2A8StyleGTWalsheim
                              .copyWith(
                                  color: AppColors.c245741,
                                  fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
