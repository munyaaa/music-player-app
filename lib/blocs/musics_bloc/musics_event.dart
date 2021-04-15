part of 'musics_bloc.dart';

@immutable
abstract class MusicsEvent extends Equatable {}

class SearchMusic extends MusicsEvent {
  final String query;

  SearchMusic(this.query);

  @override
  List<Object> get props => [query];
}
