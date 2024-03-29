import 'dart:io';

import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/config/service/environment.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/firebase_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/ekyc/page/camera_preview_card.dart';
import 'package:dtnd/ui/screen/home_base/home_base.dart';
import 'package:dtnd/ui/screen/loading/loading_screen.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/screen/sign_up/page/success_sign_up_page.dart';
import 'package:dtnd/ui/screen/sign_up/sign_up_screen.dart';
import 'package:dtnd/ui/theme/app_theme.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'firebase_options.dart';
import 'ui/screen/ekyc/ekyc_view.dart';
import 'ui/screen/otp/otp_view.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  // load .env file
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  final Environment appEnvironment = E.fromString(dotenv.env['ENVIRONMENT']);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseService.init();
  } catch (e) {
    logger.e(e);
  }

  HttpOverrides.global = MyHttpOverrides();

  await LocalStorageService().init();
  await AppService().initialize(LocalStorageService().sharedPreferences);
  await NetworkService().init(appEnvironment);
  await DataCenterService().init();

  // print(dotenv.env['URL_DATA_FEED'].runtimeType);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppService appService = AppService();
  final GoRouter _router = GoRouter(
    initialLocation: "/",
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoadingScreen();
        },
      ),
      GoRoute(
        path: '/Home',
        name: "home",
        builder: (BuildContext context, GoRouterState state) {
          return const HomeBase();
        },
      ),
      GoRoute(
        path: '/SignIn',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/SignUp',
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpView();
        },
      ),
      GoRoute(
        path: '/SuccessPage',
        name: 'success',
        builder: (BuildContext context, GoRouterState state) {
          return const SuccessSignUpPage();
        },
      ),
      GoRoute(
        name: "otp",
        path: '/otp/:phone',
        builder: (BuildContext context, GoRouterState state) {
          return OtpPage(phone: state.pathParameters['phone']!);
        },
      ),
      GoRoute(
        name: "ekyc",
        builder: (BuildContext context, GoRouterState state) {
          return const EkycPage();
        },
        path: '/Ekyc',
      ),
      GoRoute(
        name: "camera",
        path: '/Camera',
        builder: (BuildContext context, GoRouterState state) {
          return const CameraPreviewCard();
        },
      ),
      GoRoute(
        path: '/VirtualAssistant',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
    ],
  );

  @override
  void initState() {
    FirebaseService.setupFirebaseOnApp();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: hideKeyboard,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: appService.themeMode.value,
          darkTheme: darkThemeData,
          theme: lightThemeData,
          locale: appService.locale.value,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('vi', 'VN'), Locale('en', 'EN')],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          routerConfig: _router,
          builder: EasyLoading.init(),
        ),
      );
    });
  }

  void hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
