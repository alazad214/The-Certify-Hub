import 'package:christiandimene/features/auth/data/post_forget_rx/rx.dart';
import 'package:christiandimene/features/auth/data/post_login_rx/rx.dart';
import 'package:christiandimene/features/auth/data/post_reset_rx/rx.dart';
import 'package:christiandimene/features/auth/data/post_signup_rx/rx.dart';
import 'package:christiandimene/features/certification/data/get_course_detials_rx/rx.dart';
import 'package:christiandimene/features/certification/model/course_details_response.dart';
import 'package:christiandimene/features/certification/model/lesson_model_response.dart';
import 'package:christiandimene/features/certification/model/pdf_model_response.dart';
import 'package:christiandimene/features/home/data/rx.dart';
import 'package:christiandimene/features/home/model/course_response.dart';
import 'package:christiandimene/features/profile_screen/data/get_profile_rx/rx.dart';
import 'package:christiandimene/features/profile_screen/data/post_logout_rx/rx.dart';
import 'package:christiandimene/features/profile_screen/model/get_profile_response.dart';
import 'package:rxdart/subjects.dart';

import '../features/auth/data/otp_verification_rx/rx.dart';
import '../features/certification/data/get_lessons_rx/rx.dart';
import '../features/certification/data/get_pdf_rx/rx.dart';
import '../features/profile_screen/data/post_edit_profile_rx/rx.dart';

PostLoginRx postLoginRxObj =
    PostLoginRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostRegisterRx postRegisterRxObj =
    PostRegisterRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostLogoutRx postLogoutRxObj =
    PostLogoutRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostForgetPasswordRx postForgetPasswordRxObj =
    PostForgetPasswordRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

VerifyOTPRX verifyOTPRXObj =
    VerifyOTPRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

ResetPasswordRx resetPasswordRxObj =
    ResetPasswordRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetProfileDataRx getProfileDataRxObj = GetProfileDataRx(
    empty: ProfileResponse(), dataFetcher: BehaviorSubject<ProfileResponse>());

GetCourseRx getCourseRxObj = GetCourseRx(
    empty: CourseResponse(), dataFetcher: BehaviorSubject<CourseResponse>());

PostProfileEditRx postProfileEditRxObj =
    PostProfileEditRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetCourseDetailsRx getCourseDetailsRxObj = GetCourseDetailsRx(
    empty: CourseDetailsResponse(),
    dataFetcher: BehaviorSubject<CourseDetailsResponse>());

GetLessonsRx getLessonsRxObj = GetLessonsRx(
    empty: LessonsModelResponse(),
    dataFetcher: BehaviorSubject<LessonsModelResponse>());

GetPdfRx getPdfRxObj = GetPdfRx(
    empty: PdfModelResponse(),
    dataFetcher: BehaviorSubject<PdfModelResponse>());
