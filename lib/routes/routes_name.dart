class RoutesName {
  //home screen routes name
  static const String splash = '/splash';
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String viewAllShops = '/shop/viewall';

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
  static const String pastAppointment = '/appointments/past';
  static const String upcomingAppointment = '/appointments/upcoming';
  static const String viewAppointment = '/appointment/view/:appointmentId';
  static get viewAppointmentWithId => (String id) => '/appointment/view/$id';
  static const String setAppointmentStatus =
      '/appointment/:status/:appointmentId';
  static get getSetAppointmentStatusURL =>
      (String id, String status) => '/appointment/$status/$id';

  // Search routes name
  static const String search = '/search';
  // More routes name
  static const String more = '/more';

  // Shop Routes
  static const String allShops = '/shops';
  static const String viewShop = '/shops/view/:shopId';
  static get viewShopWithId => (String shopId) => '/shops/view/$shopId';
  static const String bookAppointment = '/shops/book/:shopId/:memberId';
  static get bookAppointmentWithId =>
      (String shopId, String memberId) => '/shops/book/$shopId/$memberId';
  static const String shopPortfolio = '/shops/portfolio/:shopId';
  static get shopPortfolioWithId =>
      (String shopId) => '/shops/portfolio/$shopId';
  static const String shopReviewsById = '/shops/reviews/:shopId';
  static get shopReviewsWithId => (String shopId) => '/shops/reviews/$shopId';
  static const String shopsServicesById = '/shops/services/:shopId';
  static get shopsServicesWithId =>
      (String shopId) => '/shops/services/$shopId';
  static const String aboutShop = '/shops/about/:shopId';
  static get aboutShopWithId => (String shopId) => '/shops/about/$shopId';

  // Owner Dashboard Routes
  static const String ownerDashboard = '/shop/dashboard/:shopId';
  static get ownerDashboardWithId =>
      (String shopId) => '/shop/dashboard/$shopId';
  static const String shopServices = '/shop/services/:shopId';
  static get shopServicesWithId => (String? shopId) =>
      shopId != null ? '/shop/services/$shopId' : '/shop/services';
  static const String shopAppointments = '/shop/appointments/:shopId';
  static get shopAppointmentsWithId => (String? shopId) =>
      shopId == null ? '/shop/appointments' : '/shop/appointments/$shopId';
  static const String shopDetails = '/shop/view/info/:shopId';
  static get shopDetailsWithId => (String shopId) => '/shop/view/info/$shopId';
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
  static const String adminShopInfoScreen = '/admin/shop/info';
  static const adminUpdateShopInfo = '/admin/shop/update';
  static get adminUpdateShopInfoWithId =>
      (String shopId) => '/admin/update/shop/info/$shopId';
  static get adminUpdateShopContactWithId =>
      (String shopId) => '/admin/update/contact/$shopId';
  static const String adminUpdateShopContact = '/admin/update/contact';
  static const String adminUserEditProfile = '/admin/update/user';

  //review screen
  static const String reviewShop = '/shop/write-review/:shopId';
  static const String editReviewShop = '/shop/edit-review/:shopId';
  static get reviewShopWithId =>
      (String shopId) => '/shop/write-review/$shopId';

//admin

  // Error pages
  static const String tokenExpired = '/error/token-expired';
  static const String noConnection = '/error/no-internet';
  static const String unKnownError = '/error';
}
