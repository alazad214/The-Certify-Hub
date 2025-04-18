// ignore_for_file: constant_identifier_names

const String url = "https://relmaxpdc.com/api";
const String baseUrl = "https://relmaxpdc.com/";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class PaymentGateway {
  PaymentGateway._();
  static String gateway() => "/create-payment-intent";
}

final class Endpoints {
  Endpoints._();
  //backend_url
  static String register() => "/register";
  static String logIn() => "/login";
  static String logout() => "/logout";
  static String forget() => "/forget-password";
  static String verifyOtp() => "/verify-otp-password";
  static String verifyRegisterOtp() => "/verify-otp";

  static String resetPassword() => "/reset-password";

  static String profile() => "/me";
  static String course() => "/course";
  static String profileEdit() => "/user-update";
  static String courseDetails(int id) => "/courses/$id";
  static String lessonsVideo(int id) => "/course-modules/$id";
  static String pdf(int id) => "/courses/$id/files";
  static String mockTest(int id) => "/get-quizzes/$id";

  //MOCK TEST-->>

  static String testQuiz(int id) => "/quizzes/$id";
  static String testQuizResult(int id) => "/quiz-result/$id";
  static String resultCalculate() => "/quizzes/calculate-result";
  static String practiceQuiz(int id) => "/quizzes/$id/correct-answers";
  static String purchaseCourse() => "/purchased-courses";
  static String courseProgress() => "/course-progress";
  static String trackContentProgress() => "/track-content-progress";
  static String contentProgress() => "/content-progress";
  static String technicalLink() => "/technicalLink";
  static String academicLink() => "/academicLink";
  static String privacyPolicy() => "/privacy-policy";
  static String termsAndConditions() => "/terms-and-conditions";
}
