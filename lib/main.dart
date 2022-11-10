import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/logic/app_service_provider.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  // load .env file
  // await dotenv.load(fileName: "test_domain_config.env");
  WidgetsFlutterBinding.ensureInitialized();
  await AppService.initialize();
  // print(dotenv.env['URL_DATA_FEED']);
  // print(dotenv.env['URL_DATA_FEED'].runtimeType);
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(appLocaleProvider);
    return MaterialApp(
      themeMode: themeMode,
      darkTheme: darkThemeData,
      theme: lightThemeData,
      locale: locale.data,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const LoginScreen(),
    );
  }
}
