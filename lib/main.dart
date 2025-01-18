import 'package:christiandimene/loading_screen.dart';
import 'package:christiandimene/networks/internet_checker/internet_controller.dart';
import 'package:christiandimene/provider/video_screen_provider/video_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:provider/provider.dart';
import 'constants/custome_theme.dart';
import 'gen/colors.gen.dart';
import 'helpers/all_routes.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/navigation_service.dart';
import 'networks/dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await _requestPermissions();
  await GetStorage.init();
  diSetup();

  Stripe.publishableKey =
      'pk_test_51PuhUnCNNZOwq4CUa7L48iSaSvJsJeL2nNZV5ApvJOoiguUi84pkNI95PUCVDVZ9a0CRF9et4FUl9SnnDhS9p7Cp00tDu86hgn';

  DioSingleton.instance.create();
  Get.put(InternetController(), permanent: true);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoScreenProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();
    return AnimateIfVisibleWrapper(
      showItemInterval: const Duration(milliseconds: 150),
      child: PopScope(
        canPop: false,
        // ignore: deprecated_member_use
        onPopInvoked: (bool didPop) async {
          showMaterialDialog(context);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return const UtillScreenMobile();
          },
        ),
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, _) async {
            showMaterialDialog(context);
          },
          child: GetMaterialApp(
            //    showPerformanceOverlay: true,
            theme: ThemeData(
                unselectedWidgetColor: Colors.white,
                primarySwatch: CustomTheme.kToDark,
                useMaterial3: false,
                scaffoldBackgroundColor: AppColors.cE9EEEC,
                appBarTheme:
                    const AppBarTheme(color: AppColors.cFFFFFF, elevation: 0)),
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              return MediaQuery(data: MediaQuery.of(context), child: widget!);
            },
            navigatorKey: NavigationService.navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: const Loading(),
          ),
        );
      },
    );
  }
}
