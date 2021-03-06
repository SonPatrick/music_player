import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
import 'package:music_player/songs.dart';
import 'package:music_player/theme.dart';

class BottomControls extends StatelessWidget {
  const BottomControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Material(
        shadowColor: const Color(0x44000000),
        color: accentColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 50.0),
          child: Column(
            children: <Widget>[
              AudioPlaylistComponent(
                playlistBuilder:
                    (BuildContext context, Playlist playlist, Widget child) {
                  final songTitle =
                      demoPlaylist.songs[playlist.activeIndex].songTitle;
                  final artistName =
                      demoPlaylist.songs[playlist.activeIndex].artist;

                  return RichText(
                    text: TextSpan(
                      text: '',
                      children: [
                        TextSpan(
                          text: '${songTitle.toUpperCase()}\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4.0,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: '${artistName.toUpperCase()}',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.75),
                            fontSize: 12.0,
                            letterSpacing: 3.0,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Container()),
                    new PreviousButton(),
                    Expanded(child: Container()),
                    new PlayPauseButton(),
                    Expanded(child: Container()),
                    new NextButton(),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AudioComponent(
      updateMe: [WatchableAudioProperties.audioPlayerState],
      playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
        IconData icon = Icons.music_note;
        Color buttonColor = Colors.black; 
        Function onPressed;
        if (player.state == AudioPlayerState.playing) {
          icon = Icons.pause;
          onPressed = player.pause;
          buttonColor = Colors.black;
        } else if (player.state == AudioPlayerState.paused ||
            player.state == AudioPlayerState.completed) {
          icon = Icons.play_arrow;
          onPressed = player.play;
          buttonColor = Colors.black;
        }
        return RawMaterialButton(
          shape: CircleBorder(),
          fillColor: buttonColor,
          splashColor: accentColor,
          highlightColor: accentColor.withOpacity(0.5),
          elevation: 10.0,
          highlightElevation: 5.0,
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 35.0,
            ),
          ),
        );
      },
    );
  }
}

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AudioPlaylistComponent(
      playlistBuilder: (BuildContext context, Playlist playlist, Widget child) {
        return IconButton(
          splashColor: Colors.grey,
          highlightColor: Colors.transparent,
          icon: Icon(Icons.skip_previous),
          color: Colors.black,
          iconSize: 36.5,
          onPressed: playlist.previous,
        );
      },
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AudioPlaylistComponent(playlistBuilder:
        (BuildContext context, Playlist playlist, Widget child) {
      return IconButton(
        splashColor: Colors.grey,
        highlightColor: Colors.transparent,
        icon: Icon(Icons.skip_next),
        color: Colors.black,
        iconSize: 36.5,
        onPressed: playlist.next,
      );
    });
  }
}

class CircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: min(size.width, size.height) / 2,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
