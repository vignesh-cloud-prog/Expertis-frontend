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

  // Appointment routes name
  static const String appointment = '/appointments';
  static const String viewAppointment = '/appointment/view/:appointmentId';
  static get viewAppointmentWithId => (String id) => '/appointment/view/$id';
  static const String acceptAppointment = '/appointment/accept/:appointmentId';
  static get acceptAppointmentWithId =>
      (String id) => '/appointment/accept/$id';
  static const String cancelAppointment = '/appointment/cancel/:appointmentId';
  static get cancelAppointmentWithId =>
      (String id) => '/appointment/cancel/$id';
  static const String confirmAppointment =
      '/appointment/confirm/:appointmentId';
  static get confirmAppointmentWithId =>
      (String id) => '/appointment/confirm/$id';
  static const String rejectAppointment = '/appointment/reject/:appointmentId';
  static get rejectAppointmentWithId =>
      (String id) => '/appointment/reject/$id';
  static const String completeAppointment =
      '/appointment/complete/:appointmentId';
  static get completeAppointmentWithId =>
      (String id) => '/appointment/complete/$id';

  // Search routes name
  static const String search = '/search';
  // More routes name
  static const String more = '/more';

  // Shop Routes
  static const String allShops = '/shops';
  static const String viewShop = '/shops/view/:shopId';
  static get viewShopWithId => (String shopId) => '/shops/view/$shopId';
  static const String bookAppointment = '/shops/book/:shopId';
  static get bookAppointmentWithId => (String shopId) => '/shops/book/$shopId';
  static const String shopPortfolio = '/shops/portfolio/:shopId';
  static get shopPortfolioWithId =>
      (String shopId) => '/shops/portfolio/$shopId';
  static const String shopReviewsById = '/shops/reviews/:shopId';
  static get shopReviewsWithId => (String shopId) => '/shops/reviews/$shopId';
  static const String shopServicesById = '/shops/services/:shopId';
  static get shopServicesWithId => (String shopId) => '/shops/services/$shopId';
  static const String aboutShop = '/shops/about/:shopId';
  static get aboutShopWithId => (String shopId) => '/shops/about/$shopId';
  static const String reviewShop = '/shop/write-review/:shopId';
  static get reviewShopWithId =>
      (String shopId) => '/shop/write-review/$shopId';

  // Owner Dashboard Routes
  static const String ownerDashboard = '/shop/dashboard/:shopId';
  static const String shopServices = '/shop/services';
  static const String shopAppointments = '/shop/appointments';
  static const String shopDetails = '/shop/info';
  static const String createShop = '/shop/create';
  static const String updateShopInfo = '/shop/update/info/:shopId';
  static get updateShopInfoWithId =>
      (String shopId) => '/shop/update/info/$shopId';
  static const String updateShopContact = '/shop/update/contact/:shopId';
  static get updateShopContactWithId =>
      (String shopId) => '/shop/update/contact/$shopId';
  static const String createService = '/shop/service/add';
  static const String updateService = '/shop/service/update/:serviceId';
  static get updateServiceWithId =>
      (String serviceId) => '/shop/service/update/$serviceId';

  // Admin Dashboard Routes
  static const String adminDashboard = '/admin/dashboard';
  static const String adminUsers = '/admin/users';
  static const String adminShops = '/admin/shops';
  static const String adminTags = '/admin/tags';
  static const String createTag = '/admin/tag/create';
  static const String updateTag = '/admin/tag/update/:tagId';
  static get updateTagWithId => (String tagId) => '/admin/tag/update/$tagId';

  // Error pages
  static const String tokenExpired = '/error/token-expired';
  static const String noConnection = '/error/no-internet';
  static const String unKnownError = '/error';
}
