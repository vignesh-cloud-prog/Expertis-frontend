class ApiUrl {
  static var baseUrl = 'https://expertis-api.azurewebsites.net/';

  static var loginEndPint = '${baseUrl}users/login';
  static var forgetPasswordEndPint = '${baseUrl}users/forget-password';
  static var changePasswordEndPint = '${baseUrl}users/change-password';
  static var verifyOTPEndPint = '${baseUrl}users/verify-otp';
  static var verifyTokenEndPint = '${baseUrl}users/verify-token';
  static var registerApiEndPoint = '${baseUrl}users/register';
  static var updateProfileApiEndPoint = '${baseUrl}users/update';

  static var fetchCategoryEndPoint = '${baseUrl}tags';
  static var fetchHomeDataEndPoint = '${baseUrl}shops/?city=nittur';
}
