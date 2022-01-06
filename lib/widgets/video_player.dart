
import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class VideoPlayer extends StatefulWidget {
  final videoId;

  VideoPlayer({Key? key, this.videoId}) : super(key: key);
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print("VideoPlayer build widget.videoId");
    print(widget.videoId);
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: widget.videoId ?? 'K18cpp_-gP8',
      params: YoutubePlayerParams(
        playlist: [ widget.videoId,  widget.videoId], // Defining custom playlist
        startAt: Duration(seconds: 30),
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    YoutubePlayerIFrame(
      controller: _controller,
      aspectRatio: 16 / 9,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Play Video"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: YoutubePlayerControllerProvider( // Provides controller to all the widget below it.
            controller: _controller,
            child: YoutubePlayerIFrame(
              aspectRatio: 16 / 9,
            ),
          ),
      ),
    );

  }
}


