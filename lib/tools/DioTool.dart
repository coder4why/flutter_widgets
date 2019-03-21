import 'package:dio/dio.dart';

class DioTool{

  static Future<Map> get(String url) async {

    Dio dio = new Dio();
    Response response=await dio.get(url);
//    print('=============😊==============');
//    print(response.data);
//    print('=============😊==============');

    return response.data;
  }


}