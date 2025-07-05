import 'package:ecoguardian/ecoguardian/analytics/interface/screens/home_screen.dart';
import 'package:ecoguardian/ecoguardian/consulting/interface/screens/consulting_screen.dart';
import 'package:ecoguardian/ecoguardian/iam/interface/screens/login_screen.dart';
import 'package:ecoguardian/ecoguardian/iam/interface/screens/register_screen.dart';
import 'package:ecoguardian/ecoguardian/monitoring/interface/screens/monitoring_screen.dart';
import 'package:ecoguardian/ecoguardian/payment/interface/screens/payments_screen.dart';
import 'package:ecoguardian/ecoguardian/planning/interface/screens/installation_screen.dart';
import 'package:ecoguardian/ecoguardian/profile/interface/screens/notifications_screen.dart';
import 'package:ecoguardian/ecoguardian/profile/interface/screens/profile_screen.dart';
import 'package:ecoguardian/shared/interface/widgets/main_wrapper.dart';
import 'package:ecoguardian/shared/interface/screens/error_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: RegisterScreen.name,
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainWrapper(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: HomeScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/monitoring',
          name: MonitoringScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const MonitoringScreen(),
          ),
        ),
        GoRoute(
          path: '/consulting',
          name: ConsultingScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ConsultingScreen(),
          ),
        ),
        GoRoute(
          path: '/payments',
          name: PaymentsScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const PaymentsScreen(),
          ),
        ),
        GoRoute(
          path: '/profile',
          name: ProfileScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ProfileScreen(),
          ),
        ),
        GoRoute(
          path: '/notifications',
          name: NotificationsScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const NotificationsScreen(),
          ),
        ),
        GoRoute(
          path: '/installations',
          name: InstallationScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const InstallationScreen(),
          ),
        ),
      ]
    ),
    // Rutas de error
    GoRoute(
      path: '/error',
      name: 'error',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return ErrorPage(
          errorMessage: extra?['message'] as String?,
          errorCode: extra?['code'] as String?,
          onRetry: extra?['onRetry'] as VoidCallback?,
        );
      },
    ),
    GoRoute(
      path: '/404',
      name: 'not-found',
      builder: (context, state) => const NotFoundPage(),
    ),
  ]
);