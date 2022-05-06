import 'dart:async';
import "dart:core";
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class UsersApiService {
  String url = "https://api.github.com/search/users";

  Future<dynamic> getData({
    required String query,
    required int page,
    required int pageSize,
  }) async {
    DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions = buildCacheOptions(Duration(days: 7));
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);

    try {
      query = Uri.encodeComponent(query);
      var response = await _dio
          .get("$url?q=$query&page=$page&per_page=$pageSize",
              options: _cacheOptions)
          .timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        return {"success": true, "data": response.data};
      } else {
        return {
          "success": false,
          "message": "Error: Status Code ${response.statusCode}"
        };
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        return {
          "success": false,
          "message": 'The connection has timed out, Please try again!'
        };
      } else if (e.type == DioErrorType.other) {
        return {
          "success": false,
          "message": "You are not connected to internet"
        };
      } else {
        return {"success": false, "message": "Error Occured"};
      }
    } on SocketException {
      return {"success": false, "message": "You are not connected to internet"};
    } on TimeoutException {
      return {
        "success": false,
        "message": 'The connection has timed out, Please try again!'
      };
    } catch (e) {
      return {"success": false, "message": "Error Occured"};
    }
  }
}
