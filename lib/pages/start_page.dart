import 'package:flutter/material.dart';
import 'package:supernova_translator/pages/Setting/setting_page.dart';
import 'package:supernova_translator/pages/favorite.dart';
import 'package:supernova_translator/pages/translation_page.dart';
import 'package:supernova_translator/translations/app_translations.dart';

final scaffoldKey = new GlobalKey<ScaffoldState>();

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _selectedIndex = 0;
  PageController _controller;

  @override
  void initState() {
    _controller = new PageController(
      initialPage: 0,
      keepPage: true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Supernova Translator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SettingPage())),
          )
        ],
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            title: Text(AppTranslations.of(context).text('common.translate')),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text(AppTranslations.of(context).text('common.favorite')),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: bottomTapped,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          child: PageView(
            onPageChanged: (index) {
              pageChanged(index);
            },
            controller: _controller,
            children: <Widget>[TranslationPage(), FavoritePage()],
          ),
        ),
      ),
    );
  }

  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
