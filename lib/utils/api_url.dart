class ApiUrl {
  static var baseUrl = 'https://expertis-api.azurewebsites.net/';

  static var moviesBaseUrl =
      'https://dea91516-1da3-444b-ad94-c6d0c4dfab81.mock.pstmn.io/';

  static var loginEndPint = '${baseUrl}users/login';

  static var forgetPasswordEndPint = '${baseUrl}users/forget-password';
  static var changePasswordEndPint = '${baseUrl}users/change-password';
  static var verifyOTPEndPint = '${baseUrl}users/verify-otp';
  static var verifyTokenEndPint = '${baseUrl}users/verify-token';

  static var registerApiEndPoint = '${baseUrl}users/register';
  static var updateProfileApiEndPoint = '${baseUrl}users/update';

  static var moviesListEndPoint = '${moviesBaseUrl}movies_list';
}
