class Constant {
  static bool isProduction = false;
  static const String baseUrl = 'http://10.0.2.2:5082/api/v1';

  // auth related routes
  static const String initialPath = '/';
  static const String loginPath = '/login';
  static const String registerPath = '/register';

  // app related routes
  static const String homePath = '/home';
  static const String monitoringPath = '/monitoring';
  static const String consultingPath = '/consulting';
  static const String paymentsPath = '/payments';
  static const String profilePath = '/profile';
  static const String notificationsPath = '/notifications';
  
  // error related routes
  static const String errorPath = '/error';
  static const String notFoundPath = '/404';
}