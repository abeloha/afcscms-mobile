class AppConstants {
  AppConstants._();

  //title of pages
  static const String title = "AFCSCMS";

  //api Related http://192.168.43.26
  static const String apiBaseUrl = "http://105.112.136.217";
  //static const String apiBaseUrl = "http://192.168.43.26";
  static const String apiRegUrl = apiBaseUrl + '/register';
  static const String apiLoginUrl = apiBaseUrl + '/apilogincheck';
  static const String apiHomeUrl = apiBaseUrl + '/apilogin';
  static const String apiDashboardUrl = apiBaseUrl + '/';
}
