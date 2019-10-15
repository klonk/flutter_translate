class GoogleTranslateResponse{
  String translatedText;
  String detectedSourceLanguage;

    GoogleTranslateResponse.fromJson(Map<String, dynamic> json) {
      if (json == null) return;
      if(json['data'] == null) return;
      if(json['data']['translations'] == null) return;

      var translations = json['data']['translations'] as List<dynamic>;
      if(translations.length == 0){
        return;
      }

      var translation = translations[0];

      if(translation['translatedText'] != null)
        this.translatedText = translation['translatedText'] ;

      if(translation['detectedSourceLanguage'] != null)
        this.detectedSourceLanguage = translation['detectedSourceLanguage'] ;

    }
}