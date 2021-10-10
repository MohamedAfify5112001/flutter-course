import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getDataFromApi(
      {required String path,
       Map<String, dynamic>? query,
        String? token}) async {
    dio!.options.headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
      'lang' : 'en'
    };
    return await dio!.get(path, queryParameters: query);
  }


  static Future<Response> postDataWithoutData(
      {required String path,
        Map<String, dynamic>? query,
        String lang = 'en',
        String? token}) async {
    dio!.options.headers = {'lang': lang, 'Authorization': token};
    return dio!.post(path);
  }

  static Future<Response> postData(
      {required String path,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String lang = 'en',
      String? token}) async {
    dio!.options.headers = {'lang': lang, 'Authorization': token};
    return dio!.post(path, queryParameters: query, data: data);
  }

  static Future<Response> updateData(
      {required String path,
        Map<String, dynamic>? query,
        required Map<String, dynamic> data,
        String lang = 'en',
        String? token}) async {
    dio!.options.headers = {'lang': lang, 'Authorization': token};
    return dio!.put(path, queryParameters: query, data: data);
  }
}
