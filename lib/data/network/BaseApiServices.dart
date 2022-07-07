abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url, dynamic header);

  Future<dynamic> getPostApiResponse(String url, dynamic header, dynamic data);
}
