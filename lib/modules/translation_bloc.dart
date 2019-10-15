import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supernova_translator/models/lang.dart';
import 'package:supernova_translator/models/translation.dart';
import 'package:supernova_translator/models/translation_request.dart';
import 'package:supernova_translator/modules/seed_languages.dart';
import 'package:supernova_translator/services/local_storage/m_local_storage.dart';

import '../app.dart';

const String favoriteKey = "favorite";

class TranslationBloc {
  static final TranslationBloc _instance = new TranslationBloc._();

  factory TranslationBloc() => TranslationBloc._instance;

  TranslationBloc._() {
    var initLangs = Languages.langs
        .map((k, v) {
          return MapEntry(k, Lang(k, v));
        })
        .values
        .toList();
    srcLanguages.add([Lang('', 'Detect'), ...initLangs]);

    trgLanguages.add(initLangs);

    translationRequestDebounce =
        translationRequest.debounceTime(Duration(milliseconds: 800));
    translationRequestDebounce.listen((onData) => translate(onData));

    favoriteTranslation.add(List<TranslationResponse>());
    Future.delayed(Duration.zero, () async {
      MLocalStorage prefs = await MLocalStorage.getInstance();
      var favoriteJson = prefs.getStringList(favoriteKey);
      var storedFavorite = favoriteJson.map((f) {
        var map = json.decode(f);
        return TranslationResponse.fromJson(map);
      }).toList();
      this.favoriteTranslation.add(storedFavorite);
    });
  }

  BehaviorSubject<List<Lang>> srcLanguages = new BehaviorSubject<List<Lang>>();
  BehaviorSubject<List<Lang>> trgLanguages = new BehaviorSubject<List<Lang>>();

  BehaviorSubject<TranslationResponse> translation =
      new BehaviorSubject<TranslationResponse>();

  BehaviorSubject<List<TranslationResponse>> favoriteTranslation =
      new BehaviorSubject<List<TranslationResponse>>();

  PublishSubject<TranslationRequest> translationRequest =
      new PublishSubject<TranslationRequest>();

  Observable<TranslationRequest> translationRequestDebounce;

  translate(TranslationRequest data) async {
    // if text is empty
    if (data.srcText.trim().length == 0) return;
    //if src and trg lang are same
    if (data.srcText == data.trgLang) {
      return;
    }
    var response = await App.http.translate(data);

    translation.add(response);
  }

  Lang getLangName(String code) {
    return this
        .srcLanguages
        ?.value
        ?.where((test) => test.language == code)
        ?.first;
  }

  addFavorite(TranslationResponse response) async {
    var oldVal = this.favoriteTranslation.value;

    if (oldVal.contains(response)) {
      return;
    }

    oldVal.add(response);
    this.favoriteTranslation.add(oldVal);
    await _updateStorage();
  }

  removeFavorite(TranslationResponse response) async {
    var oldVal = this.favoriteTranslation.value;
    oldVal.remove(response);
    this.favoriteTranslation.add(oldVal);
    await _updateStorage();
  }

  _updateStorage() async {
    var oldVal = this.favoriteTranslation.value;
    MLocalStorage prefs = await MLocalStorage.getInstance();
    prefs.setStringList(
        favoriteKey, oldVal.map((f) => json.encode(f.toJson())).toList());
  }
}
