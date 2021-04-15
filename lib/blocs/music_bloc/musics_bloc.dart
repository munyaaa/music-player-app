import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player_app/repositories/music_repository.dart';
import 'package:meta/meta.dart';

part 'musics_event.dart';
part 'musics_state.dart';

class MusicsBloc extends Bloc<MusicsEvent, MusicsState> {
  final MusicRepository musicRepository;

  MusicsBloc({@required this.musicRepository}) : super(MusicsInitial());

  @override
  Stream<MusicsState> mapEventToState(
    MusicsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
