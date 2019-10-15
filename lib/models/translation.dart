import 'package:supernova_translator/models/translation_request.dart';

import 'api_models/google_translate_response.dart';

class TranslationResponse {
  TranslationResponse(
      GoogleTranslateResponse response, TranslationRequest request) {
    this.detected = response?.detectedSourceLanguage != null;
    this.srcText = request.srcText;
    this.trgText = response.translatedText;
    this.srcLang = response.detectedSourceLanguage == null
        ? request.srcLang
        : response.detectedSourceLanguage;
    this.trgLang = request.trgLang;
  }

  String srcLang;

  String trgLang;

  String srcText;

  String trgText;

  bool detected;

  String get _key {
    return "${srcLang}_${trgLang}_${srcText}_$trgText";
  }

  @override
  int get hashCode => this._key.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranslationResponse &&
          runtimeType == other.runtimeType &&
          _key == other._key;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (srcLang != null) json['srcLang'] = srcLang;

    if (trgLang != null) json['trgLang'] = trgLang;

    if (srcText != null) json['srcText'] = srcText;

    if (trgText != null) json['trgText'] = trgText;

    if (detected != null) json['detected'] = detected;

    return json;
  }

  TranslationResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    if (json['srcLang'] == null) {
      srcLang = null;
    } else {
      srcLang = json['srcLang'];
    }
    if (json['trgLang'] == null) {
      trgLang = null;
    } else {
      trgLang = json['trgLang'];
    }
    if (json['srcText'] == null) {
      srcText = null;
    } else {
      srcText = json['srcText'];
    }
    if (json['trgText'] == null) {
      trgText = null;
    } else {
      trgText = json['trgText'];
    }
    if (json['detected'] == null) {
      detected = null;
    } else {
      detected = json['detected'];
    }
  }
}
