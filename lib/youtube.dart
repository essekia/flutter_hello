import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

// import 'youtube_search.dart';

class AboutTopic extends StatefulWidget {
  final String videoLink;

  AboutTopic(this.videoLink );

  @override
  _AboutTopicState createState() => _AboutTopicState();
}

class _AboutTopicState extends State<AboutTopic> {
   YoutubePlayerController _controller = YoutubePlayerController(initialVideoId:'phxNriIKrG4');



  @override
  void initState() {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'phxNriIKrG4',

    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return YoutubePlayer(
    //         controller: _controller,
    //         showVideoProgressIndicator: true,

    return YoutubePlayerIFrame(
      controller: _controller,
      aspectRatio: 16 / 9,
    );


      // YoutubePlayer(
      //   controller: _controller,
      //   showVideoProgressIndicator: true,
      //   videoProgressIndicatorColor: Colors.amber,
      //   progressColors: ProgressColors(
      //     playedColor: Colors.amber,
      //     handleColor: Colors.amberAccent,
      //   ),
      //   onReady() {
      //     _controller.addListener(listener);
      // },
      //

  }
}