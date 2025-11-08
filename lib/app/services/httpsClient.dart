import 'package:dio/dio.dart';

class HttpsClient {
  static String domain = "https://miapp.itying.com";
  
  // 使用静态初始化，在类加载时就配置好 Dio
  static final Dio dio = Dio()
    ..options.baseUrl = domain
    ..options.connectTimeout = Duration(seconds: 10)
    ..options.receiveTimeout = Duration(seconds: 10);

  static Future<Response> get(String url, {Map<String, dynamic> params = const {}}) async {
    try {
      var response = await dio.get(url, queryParameters: params);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Response> post(String url, {Map<String, dynamic> data = const {}}) async {
    try {
      var response = await dio.post(url, data: data);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// 获取完整的图片 URL
  /// @param url 图片路径（可能带或不带前导斜杠）
  /// @return 完整的图片 URL
  static String getNetPictureUrl(String url) {
    if (url.isEmpty) return '';
    
    // 如果路径已经是完整 URL，直接返回
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    
    // 将 Windows 路径分隔符 \ 替换为 URL 路径分隔符 /
    url = url.replaceAll('\\', '/');
    
    // 如果路径不以 / 开头，添加 /
    if (!url.startsWith('/')) {
      return "$domain/$url";
    }
    
    // 路径以 / 开头，直接拼接
    return "$domain$url";
  }


}