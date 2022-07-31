abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url, dynamic header);
  Future<dynamic> getDeleteApiResponse(String url, dynamic header);

  Future<dynamic> getPostApiResponse(String url, dynamic header, dynamic data);
  Future<dynamic> getPatchApiResponse(String url, dynamic header, dynamic data);
  Future<dynamic> getMultipartApiResponse(
      bool isEditMode,
      String url,
      Map<String, String> header,
      Map<String, String> data,
      bool isFileSelected,
      Map<String, dynamic> files);
}
