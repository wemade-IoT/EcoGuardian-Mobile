import 'package:ecoguardian/config/constants/constant.dart';
import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/profile/interface/providers/profile_provider.dart';
import 'package:ecoguardian/shared/interface/widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainWrapper extends StatefulWidget {
  final Widget? child;

  const MainWrapper({super.key, this.child});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  void _onIndexSelected(int index) {
    switch (index) {
      case 0:
        context.push(Constant.homePath);
        break;
      case 1:
        context.push(Constant.monitoringPath);
        break;
      case 2:
        context.push(Constant.consultingPath);
        break;
      case 3:
        context.push(Constant.paymentsPath);
        break;
      case 4:
        context.push(Constant.profilePath);
        break;
      case 5:
        context.push(Constant.notificationsPath);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final profileProvider = context.watch<ProfileProvider>();

    final routeIndexMap = {
      Constant.homePath: 0,
      Constant.monitoringPath: 1,
      Constant.consultingPath: 2,
      Constant.paymentsPath: 3,
      Constant.profilePath: 4,
      Constant.notificationsPath: 5,
    };

    final currentRoute =
        GoRouter.of(
          context,
        ).routerDelegate.currentConfiguration.last.matchedLocation;

    int currentIndex =
        routeIndexMap.entries
            .firstWhere(
              (entry) => currentRoute.startsWith(entry.key),
              orElse: () => MapEntry('', 0),
            )
            .value;

    final noBottomBarRoutes = [
      Constant.installationPath,
      Constant.orderDetailPath,
    ];

    bool showBottomBar = !noBottomBarRoutes.any(
      (route) => currentRoute.startsWith(route),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBar(
      toolbarHeight: 85.0,
      backgroundColor: CustomColors.checkoutGreen,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        // Avatar/imagen de perfil a la izquierda
        Container(
          decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 2,
          ),
          ),
          child: GestureDetector(
          onTap: () => {
            context.go(Constant.initialPath),
          },
          child: CircleAvatar(
            radius: 24.0,
            backgroundColor: Colors.white.withOpacity(0.2),
            backgroundImage: NetworkImage(
            profileProvider.profile != null ?   profileProvider.profile.avatarUrl
            : "https://www.pngitem.com/pimgs/m/421-4212617_person-placeholder-image-transparent-hd-png-download.png",
            ),
          ),
          ),
        ),
        // Título centrado
        Text(
          'EcoGuardian',
          style: TextStyle(
          fontSize: 24.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          ),
        ),
        // Icono de notificaciones con círculo a la derecha
        Container(
          decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
          ),
          child: IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: Colors.white,
            size: 26.0,
          ),
          onPressed: () => _onIndexSelected(5),
          ),
        ),
        ],
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 0,
      ),
      body: Stack(
      children: [
        if (widget.child != null) widget.child!,
        if (showBottomBar)
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: CustomNavigationBar(
          onIndexSelected: _onIndexSelected,
          index: currentIndex,
          ),
        ),
      ],
      ),
    );
  }
}
