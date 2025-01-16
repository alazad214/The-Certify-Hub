import 'package:christiandimene/features/auth/data/post_forget_rx/rx.dart';
import 'package:christiandimene/features/auth/data/post_login_rx/rx.dart';
import 'package:christiandimene/features/auth/data/post_reset_rx/rx.dart';
import 'package:christiandimene/features/auth/data/post_signup_rx/rx.dart';
import 'package:christiandimene/features/auth/data/register_verify/rx.dart';
import 'package:christiandimene/features/certification/data/get_course_detials_rx/rx.dart';
import 'package:christiandimene/features/certification/data/get_mock_test_rx/rx.dart';
import 'package:christiandimene/features/certification/data/get_track_content/rx.dart';
import 'package:christiandimene/features/certification/data/post_payment_rx/rx.dart';
import 'package:christiandimene/features/certification/data/post_track_content/rx.dart';
import 'package:christiandimene/features/certification/data/post_video_progress/rx.dart';
import 'package:christiandimene/features/certification/model/course_details_response.dart';
import 'package:christiandimene/features/certification/model/lesson_model_response.dart';
import 'package:christiandimene/features/certification/model/mock_test_response.dart';
import 'package:christiandimene/features/certification/model/pdf_model_response.dart';
import 'package:christiandimene/features/certification/model/track_content_response.dart';
import 'package:christiandimene/features/home/data/rx.dart';
import 'package:christiandimene/features/home/model/course_response.dart';
import 'package:christiandimene/features/my_course/data/rx.dart';
import 'package:christiandimene/features/practice_exam/data/rx.dart';
import 'package:christiandimene/features/practice_exam/model/practice_quiz_response.dart';
import 'package:christiandimene/features/profile_screen/data/get_profile_rx/rx.dart';
import 'package:christiandimene/features/profile_screen/data/get_technical_support/rx.dart';
import 'package:christiandimene/features/profile_screen/data/post_logout_rx/rx.dart';
import 'package:christiandimene/features/profile_screen/model/get_profile_response.dart';
import 'package:christiandimene/features/profile_screen/model/technical_support_response.dart';
import 'package:christiandimene/features/test_exam/data/get_quiz_result/rx.dart';
import 'package:christiandimene/features/test_exam/data/get_test_quiz/rx.dart';
import 'package:christiandimene/features/test_exam/data/post_calculate_result/rx.dart';
import 'package:christiandimene/features/test_exam/model/test_quiz_response.dart';
import 'package:christiandimene/features/test_exam/model/test_result_response.dart';
import 'package:rxdart/subjects.dart';
import '../features/auth/data/otp_verification_rx/rx.dart';
import '../features/certification/data/get_lessons_rx/rx.dart';
import '../features/certification/data/get_pdf_rx/rx.dart';
import '../features/profile_screen/data/get_academic_support/rx.dart';
import '../features/profile_screen/data/post_edit_profile_rx/rx.dart';
import '../features/profile_screen/model/academic_support_response.dart';

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

GetMockTestRx getMockTestRxObj = GetMockTestRx(
    empty: MockTestResponse(),
    dataFetcher: BehaviorSubject<MockTestResponse>());

GetTrackContentRx getTrackContentRxObj = GetTrackContentRx(
    empty: TrackContentResponse(),
    dataFetcher: BehaviorSubject<TrackContentResponse>());

GetTestQuizRx getTestQuizRxObj = GetTestQuizRx(
    empty: TestQuizResponse(),
    dataFetcher: BehaviorSubject<TestQuizResponse>());

GetTestQuizResultRx getTestQuizResultRxObj = GetTestQuizResultRx(
    empty: TestResultResponse(),
    dataFetcher: BehaviorSubject<TestResultResponse>());

PostCalculateQuizRx postCalculateQuizRxObj =
    PostCalculateQuizRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

PaymentRx paymentRxObj =
    PaymentRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetPracticeQuizRx getPracticeQuizRxObj = GetPracticeQuizRx(
    empty: PracticeQuizResponse(),
    dataFetcher: BehaviorSubject<PracticeQuizResponse>());

GetPurchaseCourseRx getPurchaseCourseRxObj = GetPurchaseCourseRx(
    empty: CourseResponse(), dataFetcher: BehaviorSubject<CourseResponse>());

PostProgressRx postProgressRxObj =
    PostProgressRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

RegisterVerifyRx registerVerifyRxObj =
    RegisterVerifyRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostTrackContentRx postTrackContentRxObj =
    PostTrackContentRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GettechnicalSupportRx gettechnicalSupportRxObj = GettechnicalSupportRx(
    empty: TechnicalSupportResponse(),
    dataFetcher: BehaviorSubject<TechnicalSupportResponse>());

final getAcademicSupportRxObj = GetAcademicSupportRx(
    empty: AcademicSupportResponse(), dataFetcher: BehaviorSubject());

