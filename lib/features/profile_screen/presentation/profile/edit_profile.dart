import 'dart:io';
import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/common_widgets/custom_button.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
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
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _profileImage; // Variable to hold the selected image
  String _selectedGender = 'Male'; // Default selected gender

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
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Edit Profile',
        onCallBack: () {
          NavigationService.goBack();
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
                  controller: null,
                  fillColor: AppColors.cFFFFFF,
                  hintTextSyle: TextFontStyle
                      .textStyle16w400c999999StyleGTWalsheim
                      .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                ),
                UIHelper.verticalSpace(16.h),
                CustomTextfield(
                  hintText: 'Email',
                  borderRadius: 12.r,
                  controller: null,
                  fillColor: AppColors.cFFFFFF,
                  hintTextSyle: TextFontStyle
                      .textStyle16w400c999999StyleGTWalsheim
                      .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                ),
                UIHelper.verticalSpace(16.h),
                CustomTextfield(
                  hintText: '+123 123 123 123',
                  borderRadius: 12.r,
                  controller: null,
                  fillColor: AppColors.cFFFFFF,
                  hintTextSyle: TextFontStyle
                      .textStyle16w400c999999StyleGTWalsheim
                      .copyWith(color: AppColors.c000000.withOpacity(0.6)),
                ),
                UIHelper.verticalSpace(16.h),
                // Gender Dropdown
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
                  decoration: BoxDecoration(
                    color: AppColors.cFFFFFF,
                    borderRadius: BorderRadius.circular(12.r),
                    // border:
                    //     Border.all(color: AppColors.c000000.withOpacity(0.2)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedGender,
                      icon: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: SvgPicture.asset(
                          Assets.icons.arrowDown,
                          height: 12.h,
                          width: 12.w,
                        ),
                      ),
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(12.r),
                      items: <String>['Male', 'Female'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextFontStyle
                                .textStyle16w400c999999StyleGTWalsheim
                                .copyWith(
                                    color: AppColors.c000000.withOpacity(0.6)),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue!;
                        });
                      },
                    ),
                  ),
                ),

                UIHelper.verticalSpace(100.h),
                customButton(
                  name: 'Update',
                  onCallBack: () {},
                  context: context,
                  color: AppColors.cFDB338,
                  textStyle: TextFontStyle.headline18w400cFFFFFFStyleGTWalsheim
                      .copyWith(color: AppColors.cFFFFFF),
                  borderRadius: 12.r,
                ),
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
              // Background Circle
              Container(
                height: 137.0.h,
                width: 137.0.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cBBCBC4,
                ),
              ),
              // Profile Image
              Container(
                height: 110.0.h,
                width: 110.0.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: profileImage != null
                        ? FileImage(profileImage!) // Display picked image
                        : AssetImage(Assets.images.profileImage.path)
                            as ImageProvider, // Default image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Edit Icon
              Positioned(
                right: 15.0, // Adjust position as needed
                bottom: 10.0, // Position near the bottom-right corner
                child: GestureDetector(
                  onTap: onEditPressed,
                  child: Container(
                    height: 32.0.h, // Size of edit icon background
                    width: 32.0.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // Background color for the edit icon
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
