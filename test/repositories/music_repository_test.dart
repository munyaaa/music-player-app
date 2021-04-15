import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:music_player_app/models/music.dart';
import 'package:music_player_app/repositories/music_repository.dart';

void main() {
  group('search music', () {
    test('return list of music if the http call is success', () async {
      final String response = File(
        'test/json_response/search_music_response.json',
      ).readAsStringSync();

      final http.Client client = MockClient(
        (request) async => http.Response(
          response,
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final MusicRepositoryImpl musicRepository = MusicRepositoryImpl(client);

      expect(await musicRepository.searchMusic('Price Tag'), isA<Musics>());
    });

    test('throw exception if the http call is failed', () async {
      final String response = File(
        'test/json_response/search_music_error_response.json',
      ).readAsStringSync();

      final http.Client client = MockClient(
        (request) async => http.Response(
          response,
          404,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      
      final MusicRepositoryImpl musicRepository = MusicRepositoryImpl(client);

      expect(await musicRepository.searchMusic('Price Tag'), isA<Musics>());
    });
  });
}
