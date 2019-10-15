import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supernova_translator/models/api_models/google_translate_request.dart';
import 'package:supernova_translator/models/api_models/google_translate_response.dart';
import 'package:supernova_translator/models/translation.dart';
import 'package:supernova_translator/models/translation_request.dart';
import 'package:supernova_translator/pages/start_page.dart';
import 'package:supernova_translator/services/cache_inceptor.dart';

import '../app.dart';

class ApiClient {
  final Dio _dio;

  final String baseUrl;

  ApiClient(url)
      : baseUrl = url,
        _dio = new Dio(new BaseOptions(
            baseUrl: url,
            connectTimeout: 500,
            queryParameters: {'key': App.googleApiKeys}));

  void init() {
    _dio.interceptors
      ..add(InterceptorsWrapper(onError: (DioError error) async {
        if (error?.response?.data != null) {
          String errorMsg;
          try {
            errorMsg = error.response.data['error']['message'] as String;
            FocusScope.of(scaffoldKey.currentContext).unfocus();
            scaffoldKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(errorMsg),
              duration: Duration(seconds: 3),
            ));
          } catch (e) {}
        } else {
          try {
            FocusScope.of(scaffoldKey.currentContext).unfocus();
            scaffoldKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(error.message),
              duration: Duration(seconds: 3),
            ));
          } catch (e) {}
        }
        print(error.message);
      }))
      ..add(CacheInterceptor());
  }

  Future<TranslationResponse> translate(TranslationRequest request) async {
    var url = Uri.https(baseUrl, '/language/translate/v2');
    var apiRequest = GoogleTranslationRequest(request);

    return _dio.post(url.toString(), data: apiRequest).then((data) {
      var googleResponse = GoogleTranslateResponse.fromJson(data.data);
      var response = TranslationResponse(googleResponse, request);

      return response;
    });
  }
}
