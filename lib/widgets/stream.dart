import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/preference.dart';
import '../utils/youtube_api.dart';
import '../utils/state_container.dart';
// Routes
import 'video_player.dart';

class StreamWidget extends StatefulWidget {
  // StreamWidget(List allStreamVideos);
  //
  // Object? get allStreamVideos => null;

  List allStreamVideos = [];
  StreamWidget(
      {Key? key,  required this.allStreamVideos})
      : super(key: key);

  @override
  _StreamState createState() => _StreamState();
}



class _StreamState extends State<StreamWidget> {

  static String apiKey = "AIzaSyD1rB5tSMhu3b7W2X3SIEdFfQ-gimxysfQ";

  YoutubeAPI youtube = YoutubeAPI(apiKey, maxResults: 15, type: 'channel');
  List<YouTubeVideo> videoResult = [];
  List allVideos = [];
  List channels = [];
  List topVideos = [];
  List _allVideosState = [];
  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  // new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    log('initState');
    super.initState();
    // callAPI();
    getAllChannelVideos();
    // getChannelVideos();

    // WidgetsBinding.instance
    //     ?.addPostFrameCallback((_) => _refreshIndicatorKey.currentState?.show());

    print("widget.allStreamVideos: ");
    print(widget.allStreamVideos);

  }

  @override
  void didUpdateWidget(oldWidget) {
    log('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
    getAllChannelVideos();

  }

  // Main Function
  Future<void> getAllChannelVideos() async {
    print("Stream->getAllChannelVideos()");
    var allVideos =  await YoutubeApi.getAllChannelVideos();
    allVideos.take(50);
    setState(() { _allVideosState = allVideos; });

  }



  Future<Null> _refresh() async{
    return await YoutubeApi.getAllChannelVideos().then((_videos) {
      setState(() => _allVideosState = _videos);
    });
  }


  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    // var allStreamVideos = container.allStreamVideos;
    // print("allStreamVideos.length: ");
    // print(allStreamVideos.length);

    print("videosList build - channels count" );
    print(channels.length);
    print("widget.allStreamVideos count: ");
    print(widget.allStreamVideos?.length);
    // final videosList = _allVideosState.take(50).toList();
    widget.allStreamVideos.sort((a, b) => a['orderInChannel'].compareTo(b['orderInChannel']));
    return  ListView(
        // scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(), // new
        shrinkWrap: true,
        children: widget.allStreamVideos.map<Widget>(listItem).toList()
    );



    // return const Text("Hello");
  }

  Widget listArray(String countThis) {
    return Text(countThis);
  }
 onVideoClick(videoId) {
  print("onVideoClick ");

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => VideoPlayer(videoId: videoId)),
  );
}
  static getVideoObject(video){
    print("getVideoObject");
    print(video);
    // var video = await yt!.videos.get(VideoId(videoUrl));
    var videoObject = {
      'id': video.id.value,
      'title': video.title,
      'kind' : 'video',
      'thumbnailUrl' : video.thumbnails.mediumResUrl
    };
    print(videoObject);

    return videoObject;
  }

  static getVideoObjectOld(video){

    var videoObject = {
      'id': video['id']['videoId'],
      'title': video.channelTitle,
      'kind' : video['id']['kind'],
      'thumbnailUrl' : video['snippet']['thumbnails']['medium']['url'],
    };
    print(videoObject);

    return videoObject;
  }
  Widget listItem(video) {
    // log('listVideo');
    // var videoObject = getVideoObject(video);
    var videoObject = video;
    // print(videoObject);
    // log('listVideo--');
    // return Card();

    // if (videoObject['kind'] != "youtube#video") {
    //   return Card();
    // }

    // return Text("hello");
      return Card(
        child: GestureDetector(
          onTap: () {  onVideoClick(videoObject['id']);   },
          child: Container(
          margin: EdgeInsets.symmetric(vertical: 7.0),
          padding: EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Image.network(
                  videoObject['thumbnailUrl'] ?? '',
                  width: 120.0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      videoObject['title'] ?? '',
                      softWrap: true,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      videoObject['id'] ?? '',
                      softWrap: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        ),
      );

  }
}
