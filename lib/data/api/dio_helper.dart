import 'package:dio/dio.dart';
import 'package:friends/shared/constants/strings.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  //post data to the server
  static Future<Response> postData({
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'API-KEY': '456c1ee2114941baaf07b8145ee55cb3',
    };
    return await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: data
    );
  }
}
