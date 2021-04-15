import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_player_app/blocs/musics_bloc/musics_bloc.dart';
import 'package:music_player_app/models/music.dart';
import 'package:http/src/client.dart';
import 'package:music_player_app/repositories/music_repository.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('musicsBloc', () {
    MusicsBloc musicsBloc;
    MusicRepositoryMock musicRepositoryMock;

    setUp(() {
      EquatableConfig.stringify = true;
      musicRepositoryMock = MusicRepositoryMock();
      musicsBloc = MusicsBloc(musicRepository: musicRepositoryMock);
    });

    blocTest(
      'emits [Loaded] when successful',
      build: () => musicsBloc,
      act: (bloc) => bloc.add(SearchMusic('Price Tag')),
      expect: () => [
        Loaded(musics: musicsMock)
      ],
    );

    tearDown(() {
      musicsBloc?.close();
    });
  });
}

final musicsMock = Musics(
  resultCount: 1,
  results: [
    Music(
        wrapperType: WrapperType.TRACK,
        kind: Kind.SONG,
        artistId: 1535831403,
        collectionId: 441453318,
        trackId: 441453325,
        artistName: "Price Tag",
        collectionName: "Price Tag - Single",
        trackName: "Price Tag",
        collectionCensoredName: "Price Tag - Single",
        trackCensoredName: "Price Tag",
        artistViewUrl:
            "https://music.apple.com/us/artist/price-tag/1535831403?uo=4",
        collectionViewUrl:
            "https://music.apple.com/us/album/price-tag/441453318?i=441453325&uo=4",
        trackViewUrl:
            "https://music.apple.com/us/album/price-tag/441453318?i=441453325&uo=4",
        previewUrl:
            "https://audio-ssl.itunes.apple.com/itunes-assets/Music/85/e0/a2/mzm.thnpsofj.aac.p.m4a",
        artworkUrl30:
            "https://is2-ssl.mzstatic.com/image/thumb/Music6/v4/cd/dd/2e/cddd2e24-2051-363f-f27a-c8ca16d2d4ed/source/30x30bb.jpg",
        artworkUrl60:
            "https://is2-ssl.mzstatic.com/image/thumb/Music6/v4/cd/dd/2e/cddd2e24-2051-363f-f27a-c8ca16d2d4ed/source/60x60bb.jpg",
        artworkUrl100:
            "https://is2-ssl.mzstatic.com/image/thumb/Music6/v4/cd/dd/2e/cddd2e24-2051-363f-f27a-c8ca16d2d4ed/source/100x100bb.jpg",
        collectionPrice: 1.98,
        trackPrice: 0.99,
        releaseDate: DateTime.parse("2011-06-03T12:00:00Z"),
        collectionExplicitness: Explicitness.NOT_EXPLICIT,
        trackExplicitness: Explicitness.NOT_EXPLICIT,
        discCount: 1,
        discNumber: 1,
        trackCount: 2,
        trackNumber: 1,
        trackTimeMillis: 221935,
        country: Country.USA,
        currency: Currency.USD,
        primaryGenreName: "Dance",
        isStreamable: true),
  ],
);

class MusicRepositoryMock implements MusicRepositoryImpl {
  @override
  Client get client => null;

  @override
  Future<Musics> searchMusic(String query) async {
    return musicsMock;
  }
}
