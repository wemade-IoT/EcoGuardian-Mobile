import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecoguardian/analytics/interface/screens/home_screen.dart';
import 'package:ecoguardian/crm/interface/screens/consulting_screen.dart';
import 'package:ecoguardian/iam/interface/screens/login_screen.dart';
import 'package:ecoguardian/monitoring/interface/screens/monitoring_screen.dart';
import 'package:ecoguardian/planning/interface/screens/order_detail_screen.dart';
import 'package:ecoguardian/planning/interface/screens/installation_screen.dart';
import 'package:ecoguardian/profile/interface/screens/notifications_screen.dart';
import 'package:ecoguardian/profile/interface/screens/profile_screen.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';
import 'package:ecoguardian/shared/interface/widgets/main_wrapper.dart';
import 'package:ecoguardian/monitoring/domain/dto/plant.dto.dart';

final appRouter = GoRouter(
  initialLocation: StorageHelper.getToken() != null ? '/home' : '/',
  routes: [
    GoRoute(
      path: '/',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainWrapper(child: child);
      },
      redirect: (BuildContext context, _) async {
        final token = await StorageHelper.getToken();
        if (token == null) {
          return '/';
        }
        return null;
      },
      routes: [
        GoRoute(
          path: '/home',
          name: HomeScreen.name,
          pageBuilder:
              (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const HomeScreen(),
              ),
        ),
        GoRoute(
          path: '/monitoring',
          name: MonitoringScreen.name,
          pageBuilder:
              (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const MonitoringScreen(),
              ),
        ),
        GoRoute(
          path: '/consulting',
          name: ConsultingScreen.name,
          pageBuilder:
              (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ConsultingScreen(),
              ),
        ),
        GoRoute(
          path: '/profile',
          name: ProfileScreen.name,
          pageBuilder:
              (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ProfileScreen(),
              ),
        ),
        GoRoute(
          path: '/notifications',
          name: NotificationsScreen.name,
          pageBuilder:
              (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const NotificationsScreen(),
              ),
        ),
        GoRoute(
          path: '/installations',
          name: InstallationScreen.name,
          pageBuilder: (context, state) {
            final plant = state.extra as PlantDto;
            return NoTransitionPage(
              key: state.pageKey,
              child: InstallationScreen(plant: plant),
            );
          },
        ),
        GoRoute(
          path: '/order-detail',
          name: OrderDetailScreen.name,
          pageBuilder: (context, state) {
            final plant = state.extra as PlantDto;
            final installationDateString =
                state.uri.queryParameters['installationDate'] ?? '';

            DateTime installationDate = DateTime.parse(installationDateString);

            return NoTransitionPage(
              key: state.pageKey,
              child: OrderDetailScreen(
                installationDate: installationDate,
                plant: plant,
              ),
            );
          },
        ),
      ],
    ),
  ],
);
