import 'package:flutter/material.dart';
import 'package:music_player_app/presentation/pages/musics_search_page.dart';
import 'package:music_player_app/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        accentColor: Colors.purple,
      ),
      home: MusicsSearchPage(),
    );
  }
}