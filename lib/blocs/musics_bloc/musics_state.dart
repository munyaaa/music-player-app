part of 'musics_bloc.dart';

@immutable
abstract class MusicsState extends Equatable {}

class Loading extends MusicsState {
  @override
  List<Object> get props => [];
}

class Loaded extends MusicsState {
  final Musics musics;

  Loaded({@required this.musics});

  @override
  List<Object> get props => [musics];
}

class Error extends MusicsState {
  final String errorMessage;

  Error(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
