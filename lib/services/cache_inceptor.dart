import 'package:dio/dio.dart';
import 'package:supernova_translator/models/api_models/google_translate_request.dart';

class CacheInterceptor extends Interceptor {
  CacheInterceptor();

  var _cache = Map<String, Response>();

  @override
  Future onRequest(RequestOptions options) async {
    Response response = _cache[(options.data as GoogleTranslationRequest)?.key];
    if (options.extra["refresh"] == true) {
      print(
          "${(options.data as GoogleTranslationRequest)?.key}: force refresh, ignore cache! \n");
      return options;
    } else if (response != null) {
      print("cache hit: ${(options.data as GoogleTranslationRequest)?.key} \n");
      return response;
    }
  }

  @override
  Future onResponse(Response response) async {
    _cache[(response.request.data as GoogleTranslationRequest)?.key] = response;
  }

  @override
  Future onError(DioError e) async {
    print('onError: $e');
  }
}
