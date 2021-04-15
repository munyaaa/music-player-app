import 'package:get_it/get_it.dart';
import 'package:music_player_app/blocs/music_bloc/musics_bloc.dart';
import 'package:music_player_app/repositories/music_repository.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<http.Client>(http.Client());

  locator.registerSingleton<MusicRepository>(
    MusicRepositoryImpl(locator<http.Client>()),
  );

  locator.registerFactory(
    () => MusicsBloc(
      musicRepository: locator<MusicRepository>(),
    ),
  );
}
