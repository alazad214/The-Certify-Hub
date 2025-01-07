import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/common_widgets/custom_textfeild.dart';
import 'package:christiandimene/constants/app_constants.dart';
import 'package:christiandimene/constants/text_font_style.dart';
import 'package:christiandimene/constants/textfield_validation.dart';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/helpers/ui_helpers.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/di.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  ///CONTROLLER & VARIABLE...
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var isPassChecked = false;
  var isConPassChecked = false;

  togglePassword() {
    setState(() {
      isPassChecked = !isPassChecked;
    });
  }

  toggleConfirmPassword() {
    setState(() {
      isConPassChecked = !isConPassChecked;
    });
  }

  ///INITSTATE--->>
  @override
  void initState() {
    togglePassword();
    toggleConfirmPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UIHelper.verticalSpace(32.h),
                  Text(
                    'Create Your Account',
                    style: TextFontStyle.headline32w700cFFFFFFStyleGTWalsheim
                        .copyWith(color: AppColors.c000000),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    "Sign up to access world-class certifications preparation courses, questions bank and mock exams, and more.",
                    style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                        .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                    textAlign: TextAlign.center,
                  ),
                  UIHelper.verticalSpace(32.h),
                  CustomTextfield(
                    hintText: 'Name',
                    borderRadius: 10.r,
                    controller: nameController,
                    validator: InputValidator.validatefiled,
                  ),
                  UIHelper.verticalSpace(24.h),
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
                    validator: InputValidator.validatePassword,
                    isObsecure: isPassChecked,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          togglePassword();
                        });
                      },
                      icon: isPassChecked == false
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                  UIHelper.verticalSpace(24.h),
                  CustomTextfield(
                    hintText: 'Confirm Password',
                    borderRadius: 10.r,
                    controller: confirmPasswordController,
                    validator: InputValidator.validatePassword,
                    isObsecure: isConPassChecked,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          toggleConfirmPassword();
                        });
                      },
                      icon: isConPassChecked == false
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                  UIHelper.verticalSpace(40.h),
                  customButton(
                    name: 'Sign Up',
                    onCallBack: () async {
                      if (_formKey.currentState!.validate()) {
                        await postRegisterRxObj
                            .register(
                          email: emailController.text,
                          password: passwordController.text,
                          passwordConfirmation: confirmPasswordController.text,
                          name: nameController.text,
                        )
                            .then((value) {
                      
                          appData.write(kUserEmail, emailController.text);
                        });

                        // nameController.clear();
                        // confirmPasswordController.clear();
                        // emailController.clear();
                        // passwordController.clear();`
                      }
                    },
                    context: context,
                    borderRadius: 12.r,
                    textStyle: TextFontStyle
                        .headline18w500c222222StyleGTWalsheim
                        .copyWith(
                      color: AppColors.c000000,
                    ),
                  ),
                  UIHelper.verticalSpace(32.h),
                  // Text(
                  //   'Or continue with'.tr,
                  //   style: TextFontStyle.textStyle14w400c9AB2A8StyleGTWalsheim
                  //       .copyWith(
                  //     color: AppColors.c6B6B6B,
                  //   ),
                  // ),
                  // UIHelper.verticalSpace(20.h),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Image.asset(Assets.images.facebook.path,
                  //         width: 56.w, height: 42.h),
                  //     UIHelper.horizontalSpace(16.w),
                  //     Image.asset(Assets.images.google.path,
                  //         width: 56.w, height: 42.h),
                  //     UIHelper.horizontalSpace(16.w),
                  //     Image.asset(Assets.images.apple.path,
                  //         width: 56.w, height: 42.h),
                  //   ],
                  // ),
                  // UIHelper.verticalSpace(42.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account?'.tr,
                        style: TextFontStyle
                            .textStyle14w400c9AB2A8StyleGTWalsheim
                            .copyWith(color: AppColors.c6B6B6B),
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigationService.navigateTo(Routes.logInScreen);
                        },
                        child: Text(
                          ' Log In here'.tr,
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
