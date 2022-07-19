class RoutesName {
  //home screen routes name
  static const String splash = '/';
  static const String home = '/home';
  static const String onboarding = '/onboarding';

  //accounts routes name
  static const String signUp = '/register';
  static const String verifyOTP = '/verify-otp';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String loginNow = '/login-now';
  //accounts routes name with token
  static const String viewProfile = '/user';
  static const String createProfile = '/user/create-profile';
  static const String editProfile = '/user/edit-profile';
  static const String changePassword = '/user/change-password';
  // Shop Routes
  static const String allShops = '/shops';
  static const String viewShop = '/shops/:shopId';
  // Owner Dashboard Routes
  static const String ownerDashboard = '/owner-dashboard';
  static const String createShop = '/shop/create';
  static const String updateShop = '/shop/update/:shopId';
  static const String createService = '/shop/service/add';
  static const String updateService = '/shop/service/update/:serviceId';
  static const String createTag = '/shop/tag/create';
  static const String updateTag = '/shop/tag/update/:tagId';

  // Error pages
  static const String tokenExpired = '/error/token-expired';
  static const String noConnection = '/error/no-internet';
  static const String unKnownError = '/error';
}
