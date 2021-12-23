import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';


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

  YoutubeAPI youtube = YoutubeAPI(apiKey, maxResults: 2, type: 'channel');
  List<YouTubeVideo> videoResult = [];
  List channelContents = [];

  // Main Function
  Future<void> getChannelVideos() async {
    var _baseUrl = 'www.youtube.googleapis.com';
    var channelId = 'UC5C1JAn2BOuquNNXI2oEgaA';
    var channelUri = Uri.parse('https://youtube.googleapis.com/youtube/v3/search?part=id,snippet&channelId='+channelId+'&key='+apiKey);

    var method1Response = await http.get(channelUri);
    log('Method1 Response status: ${method1Response.statusCode}');
    log('Method1 Response body: ${method1Response.body}');

    var channelContentsBody = await jsonDecode(method1Response.body);

    // todo: fromJson() -> List of youtube videos

    channelContents = await channelContentsBody['items'];
    print('channelContents');
    print(channelContents);
    log('channelContents');
    log(channelContents[0]['etag']);

  }

  Future<void> callAPI() async {
    log('callAPI');
    String query = "Holy Cross";
    videoResult = await youtube.search(query);
    print('videoResult');
    print(videoResult);

    videoResult = await youtube.nextPage();
    setState(() {});
    log('videoResult');
  }



  @override
  void initState() {
    log('initState');
    super.initState();
    callAPI();
    getChannelVideos();

  }

  @override
  Widget build(BuildContext context) {

    var sampleArray = ["one", "two", "three"];
    return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: channelContents.map<Widget>(listItem).toList()
    );

    // return const Text("Hello");

  }

  Widget listArray(String countThis) {
    return Text(countThis);
  }

  Widget listItem(video) {

    if(video['id']['kind'] != "youtube#video"){
      return Card();
    }
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
                video['snippet']['thumbnails']['medium']['url'] ?? '',
                width: 120.0,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    video['snippet']['thumbnails']['title'] ?? '',
                    softWrap: true,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 3.0),
                  //   child: Text(
                  //     video.channelTitle,
                  //     softWrap: true,
                  //     style: TextStyle(fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  Text(
                    video['id']['videoId']?? '',
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