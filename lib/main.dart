import 'package:ecoguardian/config/router/app_router.dart';
import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/iam/interface/providers/auth_provider.dart';
import 'package:ecoguardian/monitoring/interface/providers/plant_provider.dart';
import 'package:ecoguardian/shared/interface/it/locators/logger_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setUpLoggerLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PlantProvider())
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: MainTheme.primaryTheme,
        routerConfig: appRouter,
      ),
    );
  }
}