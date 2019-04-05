import 'package:dio/dio.dart';

class DioTool {
  static Future<Map> get(String url) async {
    Dio dio = new Dio();
    Response response = await dio.get(url);
//    print('=============😊==============');
//    print(response.data);
//    print('=============😊==============');

    return response.data;
  }

  static Future<Map> post(String url) async {
    Dio dio = new Dio();

// 配置dio实例
    Response response = await dio.get(
      'https://www.apiopen.top/satinApi?type=1&page=1',
    );

    print('😄--------：${response.data}');

    return response.data;
  }
}
