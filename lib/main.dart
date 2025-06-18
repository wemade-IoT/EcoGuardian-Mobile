import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ecoguardian/config/router/app_router.dart';
import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:ecoguardian/analytics/interface/providers/plant_metrics_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlantMetricsProvider()),
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