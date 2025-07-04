import 'package:ecoguardian/planning/interface/providers/device_provider.dart';
import 'package:ecoguardian/planning/interface/providers/order_provider.dart';
import 'package:ecoguardian/crm/interface/providers/answer_provider.dart';
import 'package:ecoguardian/crm/interface/providers/question_provider.dart';
import 'package:ecoguardian/profile/interface/providers/notification_provider.dart';
import 'package:ecoguardian/profile/interface/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ecoguardian/config/router/app_router.dart';
import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/analytics/interface/providers/plant_metrics_provider.dart';
import 'package:ecoguardian/iam/interface/providers/auth_provider.dart';
import 'package:ecoguardian/monitoring/interface/providers/plant_provider.dart';
import 'package:ecoguardian/shared/interface/it/locators/logger_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setUpLoggerLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlantProvider()),
        ChangeNotifierProvider(create: (_) => PlantMetricsProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => DeviceProvider())
        ChangeNotifierProvider(create: (_) => AnswerProvider()),
        ChangeNotifierProvider(create: (_) => QuestionProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EcoGuardian',
      debugShowCheckedModeBanner: false,
      theme: MainTheme.primaryTheme,
      routerConfig: appRouter,
      locale: const Locale('en'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
    );
  }
}