import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:music_player_app/helpers/call_exception.dart';
import 'package:music_player_app/models/music.dart';
import 'package:music_player_app/repositories/music_repository.dart';

part 'musics_event.dart';
part 'musics_state.dart';

class MusicsBloc extends Bloc<MusicsEvent, MusicsState> {
  final MusicRepository musicRepository;

  MusicsBloc({@required this.musicRepository}) : super(Loading());

  @override
  Stream<MusicsState> mapEventToState(
    MusicsEvent event,
  ) async* {
    if (event is SearchMusic) {
      try {
        final response = await musicRepository.searchMusic(event.query);
        yield Loaded(musics: response);
      } on CallException catch (e) {
        yield Error(e.message);
      }
    }
  }
}
