import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';


class YoutubeSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoApp(),
    );
  }
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  static String key = "AIzaSyD1rB5tSMhu3b7W2X3SIEdFfQ-gimxysfQ";

  YoutubeAPI youtube = YoutubeAPI(key, maxResults: 2, type: 'channel');
  List<YouTubeVideo> videoResult = [];

  Future<void> callAPI() async {
    // print('callAPI');
    String query = "Holy Cross";
    videoResult = await youtube.search(query);
    // print('videoResult');
    // print(videoResult);

    videoResult = await youtube.nextPage();
    setState(() {});
    // print('videoResult');
    // print(videoResult);
  }

  @override
  void initState() {
    super.initState();
    callAPI();
    // print('--hello');

  }

  @override
  Widget build(BuildContext context) {
    var sampleArray = ["one", "two", "three"];
    return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: videoResult.map<Widget>(listItem).toList()
    );

    // return const Text("Hello");

  }

  Widget listArray(String countThis) {
    return Text(countThis);
  }



  // Widget listItem(YouTubeVideo video) {
  //   return Card(
  //     child: Container(
  //       margin: EdgeInsets.symmetric(vertical: 7.0),
  //       padding: EdgeInsets.all(12.0),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.only(right: 20.0),
  //             child: Image.network(
  //               video.thumbnail.small.url ?? '',
  //               width: 120.0,
  //             ),
  //           ),
  //
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget listItem(YouTubeVideo video) {
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
                video.thumbnail.small.url ?? '',
                width: 120.0,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    video.title,
                    softWrap: true,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      video.channelTitle,
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    video.url,
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