import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/config/service/environment.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/local_storage_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home_base/home_base_screen.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  // load .env file
  await dotenv.load(fileName: "app_config.env");
  WidgetsFlutterBinding.ensureInitialized();
  final Environment appEnvironment = E.fromString(dotenv.env['ENVIRONMENT']);
  await LocalStorageService().init();
  await AppService().initialize(LocalStorageService().sharedPreferences);
  await NetworkService().init(appEnvironment);
  // print(dotenv.env['URL_DATA_FEED'].runtimeType);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppService appService = AppService();
  final GoRouter _router =
      GoRouter(initialLocation: "/SignIn", routes: <GoRoute>[
    GoRoute(
      path: '/',
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
  ]);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return MaterialApp.router(
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
        supportedLocales: S.delegate.supportedLocales,
        // routeInformationParser: _router.routeInformationParser,
        // routeInformationProvider: _router.routeInformationProvider,
        // routerDelegate: _router.routerDelegate,
        routerConfig: _router,
      );
    });
  }
}
