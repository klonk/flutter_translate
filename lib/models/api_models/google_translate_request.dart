import '../translation_request.dart';

class GoogleTranslationRequest {
  GoogleTranslationRequest(TranslationRequest request) {
    this.source = request.srcLang;
    this.target = request.trgLang;
    this.q = request.srcText;
  }
  String source;

  String target;

  String q;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (target != null) {
      json['target'] = target;
    }
    if (source != null) {
      json['source'] = source;
    }
    if (q != null) {
      json['q'] = [q];
    }
    return json;
  }

  String get key {
    return "${this.target}_ ${this.source}_${this.q}";
  }
}
