import 'dart:developer';
import 'dart:io';
import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/features/profile_screen/model/get_profile_response.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/networks/api_acess.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common_widgets/custom_textfeild.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/ui_helpers.dart';

class EditProfileScreen extends StatefulWidget {
  User data;
  EditProfileScreen({required this.data, super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  File? _profileImage;
  // String _selectedGender = 'Male';

  Future<void> _showImagePickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log(widget.data.phoneNumber.toString());

    if (kDebugMode) {
      emailController.text = widget.data.email!;
      phoneController.text = widget.data.phoneNumber!;
      nameController.text = widget.data.name!;
    }
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Edit Profile',
        onCallBack: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.sp),
          child: SafeArea(
            child: Column(
              children: [
                ProfileSection(
                  profileImage: _profileImage,
                  onEditPressed: _showImagePickerOptions,
                ),
                UIHelper.verticalSpace(24.h),
                Text(
                  'Personal Information',
                  style: TextFontStyle.headline18w400cFFFFFFStyleGTWalsheim,
                ),
                UIHelper.verticalSpace(24.h),
                CustomTextfield(
                  hintText: 'Name',
                  borderRadius: 12.r,
                  controller: nameController,
                  fillColor: AppColors.cFFFFFF,
                  hintTextSyle: TextFontStyle
                      .textStyle16w400c999999StyleGTWalsheim
                      .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                ),
                UIHelper.verticalSpace(16.h),
                CustomTextfield(
                  hintText: 'Email',
                  borderRadius: 12.r,
                  controller: emailController,
                  isRead: true,
                  fillColor: AppColors.cFFFFFF,
                  hintTextSyle: TextFontStyle
                      .textStyle16w400c999999StyleGTWalsheim
                      .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                ),
                UIHelper.verticalSpace(16.h),
                CustomTextfield(
                  hintText: 'Phone',
                  borderRadius: 12.r,
                  controller: phoneController,
                  inputType: TextInputType.number,
                  fillColor: AppColors.cFFFFFF,
                  hintTextSyle: TextFontStyle
                      .textStyle16w400c999999StyleGTWalsheim
                      .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                ),
                UIHelper.verticalSpace(100.h),
                customButton(
                  name: 'Update',
                  height: 50.h,
                  onCallBack: () {
                    postProfileEditRxObj
                        .profileData(
                      name: nameController.text,
                      phone: phoneController.text.toString(),
                      avatar: _profileImage,
                    )
                        .then((value) {
                      getProfileDataRxObj.getprofileData();
                      setState(() {});
                    });
                  },
                  context: context,
                  color: AppColors.cFDB338,
                  textStyle: TextFontStyle.headline18w400cFFFFFFStyleGTWalsheim
                      .copyWith(color: AppColors.cFFFFFF),
                  borderRadius: 12.r,
                ),
                UIHelper.verticalSpace(16.h),

                // ///DELETE ACCOUNT...
                // customButton(
                //   name: 'Delete Account?',
                //   height: 50.h,
                //   onCallBack: () {
                //     deleteButtonDialog(context, () {});
                //   },
                //   context: context,
                //   color: AppColors.c245741,
                //   borderColor: AppColors.c245741,
                //   textStyle: TextFontStyle.headline18w400cFFFFFFStyleGTWalsheim
                //       .copyWith(color: AppColors.cFFFFFF),
                //   borderRadius: 12.r,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final File? profileImage;
  final VoidCallback onEditPressed;

  const ProfileSection({
    super.key,
    required this.profileImage,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 110.0.h,
                width: 110.0.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cBBCBC4,
                  image: DecorationImage(
                    image: profileImage != null
                        ? FileImage(profileImage!)
                        : AssetImage(Assets.images.profileAvatar.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Edit Icon
              Positioned(
                right: 15.0,
                bottom: 10.0,
                child: GestureDetector(
                  onTap: onEditPressed,
                  child: Container(
                    height: 32.0.h,
                    width: 32.0.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: SvgPicture.asset(
                        Assets.icons.edit,
                        height: 8.h,
                        width: 8.w,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



      // // Gender Dropdown
                // Container(
                //   padding:
                //       EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
                //   decoration: BoxDecoration(
                //     color: AppColors.cFFFFFF,
                //     borderRadius: BorderRadius.circular(12.r),
                //     // border:
                //     //     Border.all(color: AppColors.c000000.withOpacity(0.2)),
                //   ),
                //   child: DropdownButtonHideUnderline(
                //     child: DropdownButton<String>(
                //       value: _selectedGender,
                //       icon: Padding(
                //         padding: EdgeInsets.all(8.0.sp),
                //         child: SvgPicture.asset(
                //           Assets.icons.arrowDown,
                //           height: 12.h,
                //           width: 12.w,
                //         ),
                //       ),
                //       isExpanded: true,
                //       borderRadius: BorderRadius.circular(12.r),
                //       items: <String>['Male', 'Female'].map((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(
                //             value,
                //             style: TextFontStyle
                //                 .textStyle16w400c999999StyleGTWalsheim
                //                 .copyWith(
                //                     color: AppColors.c000000.withOpacity(0.6)),
                //           ),
                //         );
                //       }).toList(),
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           _selectedGender = newValue!;
                //         });
                //       },
                //     ),
                //   ),
                // ),
