class AppUrl {
  static var baseUrl = 'https://expertis-node-api.herokuapp.com/';

  static var moviesBaseUrl =
      'https://dea91516-1da3-444b-ad94-c6d0c4dfab81.mock.pstmn.io/';

  static var loginEndPint = '${baseUrl}users/login';

  static var forgetPasswordEndPint = '${baseUrl}users/forget-password';
  static var changePasswordEndPint = '${baseUrl}users/change-password';
  static var verifyOTPEndPint = '${baseUrl}users/verify-otp';

  static var registerApiEndPoint = '${baseUrl}users/register';

  static var moviesListEndPoint = '${moviesBaseUrl}movies_list';
}
