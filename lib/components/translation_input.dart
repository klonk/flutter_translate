import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supernova_translator/models/lang.dart';
import 'package:supernova_translator/models/translation_request.dart';

import 'package:supernova_translator/modules/data_provider.dart';
import 'package:supernova_translator/modules/translation_bloc.dart';

import 'lang_picker.dart';

const String srcLangKey = "srcLang";
const String trgLangKey = "trgLang";

class TranslationInput extends StatefulWidget {
  const TranslationInput({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final TranslationBloc bloc;

  @override
  _TranslationInputState createState() => _TranslationInputState();
}

class _TranslationInputState extends State<TranslationInput> {
  String srcLang = "";
  String trgLng = "en";
  TextEditingController controller;

  @override
  void initState() {
    controller = new TextEditingController();
    super.initState();
    Future.delayed(Duration.zero, () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var srcLang = prefs.getString(srcLangKey);
      var trgLng = prefs.getString(trgLangKey);

      setState(() {
        if (srcLang != null) this.srcLang = srcLang;
        if (trgLng != null) this.trgLng = trgLng;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var bloc = DataProvider.getTranslation(context);
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child: StreamBuilder<List<Lang>>(
                        stream: bloc.srcLanguages,
                        builder: (context, snapshot) {
                          return LangPicker(
                            lang: snapshot.data,
                            selectedLang: srcLang,
                            onChanged: (lng) async {
                              setState(() {
                                srcLang = lng;
                              });
                              bloc.translate(
                                  createTranslationRequest(controller.text));
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(srcLangKey, lng);
                            },
                          );
                        })),
                srcLang != ""
                    ? IconButton(
                        icon: Icon(Icons.compare_arrows),
                        onPressed: () => swithLang(bloc),
                      )
                    : Icon(Icons.arrow_right),
                Expanded(
                  flex: 3,
                  child: StreamBuilder<List<Lang>>(
                      stream: widget.bloc.trgLanguages,
                      builder: (context, snapshot) {
                        return LangPicker(
                          lang: snapshot.data,
                          selectedLang: trgLng,
                          onChanged: (lng) async {
                            setState(() {
                              trgLng = lng;
                            });
                            bloc.translate(
                                createTranslationRequest(controller.text));
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString(trgLangKey, lng);
                          },
                        );
                      }),
                ),
              ],
            ),
            TextField(
              autofocus: false,
              controller: controller,
              onSubmitted: (text) {
                bloc.translationRequest.add(createTranslationRequest(text));
              },
              onChanged: (text) {
                bloc.translationRequest.add(createTranslationRequest(text));
              },
            )
          ],
        ));
  }

  TranslationRequest createTranslationRequest(String text) {
    return new TranslationRequest(this.srcLang, this.trgLng, text);
  }

  swithLang(TranslationBloc bloc) {
    setState(() {
      var tmp = trgLng;
      trgLng = srcLang;
      srcLang = tmp;
    });
    bloc.translate(createTranslationRequest(controller.text));
  }
}
