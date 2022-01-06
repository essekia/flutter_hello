import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/preference.dart';
import '../utils/youtube_api.dart';

class YoutubeChannel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: YoutubeChannelApp(),
    );
  }
}

class YoutubeChannelApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<YoutubeChannelApp> {

  static String apiKey = "AIzaSyD1rB5tSMhu3b7W2X3SIEdFfQ-gimxysfQ";

  YoutubeAPI youtube = YoutubeAPI(apiKey, maxResults: 15, type: 'channel');
  List<YouTubeVideo> videoResult = [];
  List allVideos = [];
  List channels = [];
  List topVideos = [];
  List _allVideosState = [];

  @override
  void initState() {
    log('initState');
    super.initState();
    // callAPI();
    getAllChannelVideos();
    // getChannelVideos();

  }

  // Main Function
  Future<void> getAllChannelVideos() async {
   var allVideos =  await YoutubeApi.getAllChannelVideos();
    setState(() { _allVideosState = allVideos; });

  }

  Future getChannelVideos(channelId) async {
    var _baseUrl = 'www.youtube.googleapis.com';
    // var channelId = 'UC5C1JAn2BOuquNNXI2oEgaA';
    var channelUri = Uri.parse('https://youtube.googleapis.com/youtube/v3/search?part=id,snippet&maxResults=15&channelId='+channelId+'&key='+apiKey);

    var method1Response = await http.get(channelUri);
    log('Method1 Response status: ${method1Response.statusCode}');
    log('Method1 Response body: ${method1Response.body}');

    var channelContentsBody = await jsonDecode(method1Response.body);

    // todo: fromJson() -> List of youtube videos

    List channelContents = await channelContentsBody['items'];
    return channelContents;
    allVideos.addAll(channelContents);
    print('allVideos');
    print(allVideos);
    log('allVideos');
    log(allVideos[0]['etag']);

  }

  Future<void> callAPI() async {
    log('callAPI');
    String query = "Holy Cross";
    videoResult = await youtube.search(query);
    // print('videoResult');
    // print(videoResult);

    videoResult = await youtube.nextPage();
    setState(() {});
    log('videoResult');
  }

  // Future<void> saveChannel(channel) async {
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('userName', userName);
  // }



  @override
  Widget build(BuildContext context) {

    var sampleArray = ["one", "two", "three"];
    // var channels = UserSimplePreferences.getChannels() ?? [];
    print("videosList build - channels" );
    print(channels);
    print("_allVideosState: ");
    print(_allVideosState);
    return ListView(
        // scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(), // new
        shrinkWrap: true,
        children: _allVideosState.map<Widget>(listItem).toList()
    );


    // return const Text("Hello");
  }

  Widget listArray(String countThis) {
    return Text(countThis);
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
    var videoObject = getVideoObject(video);
    // print(videoObject);
    // log('listVideo--');
    // return Card();

    // if (videoObject['kind'] != "youtube#video") {
    //   return Card();
    // }

    // return Text("hello");
      return Card(
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
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 3.0),
                    //   child: Text(
                    //     video.title,
                    //     softWrap: true,
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    // ),
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
      );

  }
}

class Music {
  final int? id;


  Music({
    this.id,

  });

  factory Music.fromJson(Map<String, dynamic> jsonData) {
    return Music(
      id: jsonData['id'] ?? '',

    );
  }

  static Map<String, dynamic> toMap(Music music) => {
    'id': music.id ?? '',

  };

  static String encode(List<Music> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => Music.toMap(music))
        .toList(),
  );

  static List<Music> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Music>((item) => Music.fromJson(item))
          .toList();
}