import 'package:flutter/material.dart';
import 'package:music_player_app/models/music.dart';
import 'package:music_player_app/presentation/pages/musics_search_page.dart';

class MusicCard extends StatefulWidget {
  final Music music;
  final Function controlMedia;
  final Function updateTrackId;
  final int playingTrackId;
  final Function changePlayMusicArrangement;

  const MusicCard({
    Key key,
    this.music,
    @required this.controlMedia, 
    @required this.updateTrackId, 
    @required this.playingTrackId,
    @required this.changePlayMusicArrangement,
  }) : super(key: key);

  @override
  _MusicCardState createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.music.previewUrl != null) {
          widget.controlMedia(
              updatedPlayingStatus: PlayingStatus.PLAY,
              musicUrl: widget.music.previewUrl);
          widget.updateTrackId(widget.music.trackId);
          widget.changePlayMusicArrangement();
        }
      },
      child: Card(
        margin: EdgeInsets.all(5.0),
        color: widget.playingTrackId != null && widget.playingTrackId == widget.music.trackId ? Colors.purple[600] : Colors.grey[800],
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              widget.music.artworkUrl60 != null
                  ? Image.network(
                      widget.music.artworkUrl60,
                    )
                  : Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey,
                    ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.music.trackName != null
                          ? Text("${widget.music.trackName}", style: TextStyle(fontWeight: FontWeight.bold),)
                          : Container(),
                      Text("${widget.music.artistName ?? 'Unknown Artist'}", style: TextStyle(fontSize: 12),),
                      widget.music.collectionName != null
                          ? Text("${widget.music.collectionName}", style: TextStyle(fontSize: 12, color: Colors.grey),)
                          : Container(),
                    ],
                  ),
                ),
              ),
              widget.music.previewUrl != null
                  ? Icon(Icons.music_note_rounded)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}