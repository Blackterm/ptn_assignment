import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shared/helpers/observers.dart';
import 'shared/routers/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(ProviderScope(
    observers: [
      Observers(),
    ],
    child: EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      child: MyApp(),
    ),
  ));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Piton Assignment',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: appRouter.delegate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
