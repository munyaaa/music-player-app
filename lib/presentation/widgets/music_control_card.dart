import 'package:flutter/material.dart';
import 'package:music_player_app/helpers/media_control.dart';
import 'package:music_player_app/presentation/pages/musics_search_page.dart';

class MusicControlCard extends StatefulWidget {
  final PlayingStatus playingStatus;
  final Function controlMedia;

  const MusicControlCard({
    Key key,
    @required this.playingStatus,
    @required this.controlMedia,
  }) : super(key: key);

  @override
  _MusicControlCardState createState() => _MusicControlCardState();
}

class _MusicControlCardState extends State<MusicControlCard> {
  Duration position = Duration();
  Duration length = Duration();

  @override
  void initState() {
    super.initState();
    MediaControl.player.onDurationChanged.listen((d) {
      setState(() {
        length = d;
      });
    });

    MediaControl.player.onAudioPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  int backSeconds = position.inSeconds - 5;
                  if (Duration(seconds: backSeconds) > Duration.zero) {
                    MediaControl.player.seek(Duration(seconds: backSeconds));
                  } else {
                    MediaControl.player.seek(Duration.zero);
                  }
                },
                child: Icon(
                  Icons.fast_rewind_rounded,
                  size: 50.0,
                ),
              ),
              widget.playingStatus == PlayingStatus.PLAY || widget.playingStatus == PlayingStatus.RESUME
                  ? GestureDetector(
                      onTap: () {
                        widget.controlMedia(
                          updatedPlayingStatus: PlayingStatus.PAUSE,
                        );
                      },
                      child: Icon(
                        Icons.pause,
                        size: 50.0,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        widget.controlMedia(
                          updatedPlayingStatus: PlayingStatus.RESUME,
                        );
                      },
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 50.0,
                      ),
                    ),
              GestureDetector(
                onTap: () {
                  int skipSeconds = position.inSeconds + 5;
                  if (Duration(seconds: skipSeconds) < length) {
                    MediaControl.player.seek(Duration(seconds: skipSeconds));
                  } else {
                    MediaControl.player.seek(length);
                  }
                },
                child: Icon(
                  Icons.fast_forward_rounded,
                  size: 50.0,
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Slider.adaptive(
              activeColor: Colors.purple,
              inactiveColor: Colors.grey,
              value: position.inSeconds.toDouble(),
              max: length.inSeconds.toDouble(),
              onChanged: (value) {
                MediaControl.player.seek(Duration(seconds: value.toInt()));
              },
            ),
          )
        ],
      ),
    );
  }
}
