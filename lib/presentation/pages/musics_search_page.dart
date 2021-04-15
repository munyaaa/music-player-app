import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_app/blocs/musics_bloc/musics_bloc.dart';
import 'package:music_player_app/helpers/media_control.dart';
import 'package:music_player_app/presentation/widgets/music_card.dart';
import 'package:music_player_app/presentation/widgets/music_control_card.dart';
import 'package:music_player_app/service_locator.dart';

enum PlayingStatus {
  PLAY,
  RESUME,
  PAUSE,
  STOP,
}

class MusicsSearchPage extends StatefulWidget {
  @override
  _MusicsSearchPageState createState() => _MusicsSearchPageState();
}

class _MusicsSearchPageState extends State<MusicsSearchPage> {
  TextEditingController _searchQuery;

  PlayingStatus _playingStatus;
  String _musicPreviewUrl;
  int _playingTrackId;

  @override
  void initState() {
    super.initState();
    _playingStatus = PlayingStatus.STOP;
    _searchQuery = TextEditingController();
  }

  void _handleChanged(String query, MusicsBloc musicsBloc) {
    musicsBloc.add(SearchMusic(query));
  }

  void _updateTrackId(int id) {
    setState(() {
      _playingTrackId = id;
    });
  }

  void _controlMedia({PlayingStatus updatedPlayingStatus, String musicUrl}) {
    if (updatedPlayingStatus == PlayingStatus.PLAY) {
      MediaControl.playAudio(musicUrl);
    } else if (updatedPlayingStatus == PlayingStatus.PAUSE) {
      MediaControl.pauseAudio();
    } else if (updatedPlayingStatus == PlayingStatus.RESUME) {
      MediaControl.resumeAudio();
    } else {
      MediaControl.stopAudio();
    }

    setState(() {
      _playingStatus = updatedPlayingStatus;
      _musicPreviewUrl = musicUrl ?? _musicPreviewUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _playingStatus == PlayingStatus.STOP
            ? Wrap()
            : MusicControlCard(
                playingStatus: _playingStatus,
                controlMedia: _controlMedia,
              ),
        body: BlocProvider<MusicsBloc>(
          create: (_) => locator<MusicsBloc>(),
          child: BlocBuilder<MusicsBloc, MusicsState>(
            builder: (BuildContext context, MusicsState state) {
              if (state is Loaded) {
                return Column(
                  children: [
                    buildSearchField(context.read<MusicsBloc>()),
                    Expanded(
                      child: BlocBuilder<MusicsBloc, MusicsState>(
                        builder: (BuildContext context, MusicsState state) {
                          if (state is Loaded) {
                            return ListView.builder(
                              itemCount: state.musics.resultCount,
                              itemBuilder: (BuildContext context, int index) {
                                return MusicCard(
                                  music: state.musics.results[index],
                                  controlMedia: _controlMedia,
                                  updateTrackId: _updateTrackId,
                                  playingTrackId: _playingTrackId,
                                );
                              },
                            );
                          } else if (state is Error) {
                            return Text(state.errorMessage);
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return buildSearchField(context.read<MusicsBloc>());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildSearchField(MusicsBloc musicsBloc) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: TextField(
        controller: _searchQuery,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
          hintText: 'Search song, artist name, ...',
          hintStyle: TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: Colors.purple,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 20.0,
          ),
        ),
        onChanged: (value) => _handleChanged(value, musicsBloc),
      ),
    );
  }
}
