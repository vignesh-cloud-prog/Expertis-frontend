class ApiUrl {
  // static var baseUrl = 'http://localhost:4000/';
  static var baseUrl = 'https://expertis-api.azurewebsites.net/';

  static var loginEndPint = '${baseUrl}users/login';
  static var forgetPasswordEndPint = '${baseUrl}users/forget-password';
  static var changePasswordEndPint = '${baseUrl}users/change-password';
  static var verifyOTPEndPint = '${baseUrl}users/verify-otp';
  static var verifyTokenEndPint = '${baseUrl}users/verify-token';
  static var registerApiEndPoint = '${baseUrl}users/register';
  static var updateProfileApiEndPoint = '${baseUrl}users/update';

  static var fetchCategoryEndPoint = '${baseUrl}tags';
  static var fetchHomeDataEndPoint = '${baseUrl}shops';
  static String fetchNearbyShopsEndPoint(pin, city) =>
      '${baseUrl}shops?pinCode=$pin&city=$city';
  static String fetchSelectedShopEndPoint(shopId) =>
      '${baseUrl}shops/shop/$shopId';
  static String fetchSelectedShopEndPointWithShopId(shopId) =>
      '${baseUrl}shops/shops/$shopId';
  static String fetchSlotsEndPoint(shopId, memberId, date) =>
      '${baseUrl}shops/shop/slot/$shopId/$memberId/$date';

  static var bookAppointmentEndPoint = '${baseUrl}appointments/book';
  static var cancelAppointmentEndPointWithId =
      (String id) => '${baseUrl}appointments/cancel/$id';
  static var acceptAppointmentEndPointWithId =
      (String id) => '${baseUrl}appointments/accept/$id';
  static var rejectAppointmentEndPointWithId =
      (String id) => '${baseUrl}appointments/reject/$id';
  static var confirmAppointmentEndPointWithId =
      (String id) => '${baseUrl}appointments/confirm/$id';
  static var completeAppointmentEndPointWithId =
      (String id) => '${baseUrl}appointments/complete/$id';

  static String fetchUserAppointmentsEndPoint(String userId, bool past) =>
      '${baseUrl}appointments/user/$userId?past=$past';
  static String fetchShopAppointmentsEndPoint(String shopId, bool upcoming) =>
      '${baseUrl}appointments/shop/$shopId?upcoming=$upcoming';

  static String fetchSelectedAppointmentEndPoint(String appointmentId) =>
      '${baseUrl}appointments/$appointmentId';

  static String fetchServicesDataEndPoint(String? shopId) =>
      '${baseUrl}shops/shop/services/$shopId';
  static String deleteShopEndPoint(String? id) => '${baseUrl}shops/shop/$id';
  static String deleteUserEndPoint(String? id) => '${baseUrl}users/delete/$id';

  static String createShopEndPoint = '${baseUrl}shops/shop';
  static String tagsEndPoint = '${baseUrl}tags';
  static String updateTagEndPoint(String tagId) =>
      '${baseUrl}tags/update/$tagId';
  static String deleteTagEndPoint(String? tagId) => '${baseUrl}tags/$tagId';

  static String uploadServiceApiEndPoint = '${baseUrl}shops/services';

  static String reviewEndPoint = '${baseUrl}reviews/';

  static String getShopReviewEndPoint(String? id) => '${baseUrl}reviews/$id';
  static String deleteShopReviewEndPoint(String? shopId) =>
      '${baseUrl}reviews/$shopId';
  static String getReviewsEndPoint = '${baseUrl}tags';
  //to fetch all the user data for admin
  static var fetchUserDataEndPoint = '${baseUrl}users/allUser';
}
