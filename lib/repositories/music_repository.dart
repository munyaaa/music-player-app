import 'dart:convert';

import 'package:music_player_app/helpers/call_exception.dart';
import 'package:music_player_app/models/music.dart';

import 'package:http/http.dart' as http;

abstract class MusicRepository {
  Future<Musics> searchMusic(String query);
}

class MusicRepositoryImpl implements MusicRepository {
  final http.Client client;

  MusicRepositoryImpl(this.client);
  
  @override
  Future<Musics> searchMusic(String query) async {
    try {
      final response = await client.post(Uri.https('itunes.apple.com', '/search'), body: {'term': '$query', 'limit': '25'});
      return Musics.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      throw CallException(message: 'Something is going wrong');
    }
  }
}