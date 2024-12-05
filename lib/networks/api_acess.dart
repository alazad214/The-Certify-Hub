import 'package:christiandimene/features/auth/data/post_forget_rx/rx.dart';
import 'package:christiandimene/features/auth/data/post_login_rx/rx.dart';
import 'package:christiandimene/features/auth/data/post_reset_rx/rx.dart';
import 'package:christiandimene/features/auth/data/post_signup_rx/rx.dart';
import 'package:christiandimene/features/profile_screen/data/post_logout_rx/rx.dart';
import 'package:rxdart/subjects.dart';

import '../features/auth/data/otp_verification_rx/rx.dart';

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
