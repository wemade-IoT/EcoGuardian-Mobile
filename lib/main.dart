import 'package:ecoguardian/config/router/app_router.dart';
import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/shared/interface/it/locators/logger_locator.dart';
import 'package:flutter/material.dart';

void main() {
  setUpLoggerLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: MainTheme.primaryTheme,
      routerConfig: appRouter,
    );
  }
}