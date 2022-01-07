import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/preference.dart';
import '../utils/dummy_preference.dart';


// class ChannelsList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ChannelsListApp(),
//     );
//   }
// }

class ChannelsList extends StatefulWidget {
  @override
  _ChannelsListState createState() => _ChannelsListState();
}

class _ChannelsListState extends State<ChannelsList> {

  List channels = [];


  @override
  void initState() {
    log('initState');
    super.initState();
  }


  Future<void> getDummyChannels() async {

  }

  Future<void> deleteChannel(channelId) async {
    UserSimplePreferences.deleteChannel(channelId);
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {

    var channels = UserSimplePreferences.getChannels() ?? [];
    print("channels_list.dart channels");
    print(channels);

     return Scaffold(
        appBar: AppBar(
          title: const Text("Channels List"),
        ),
        body: ListView(
          // scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(), // new
          shrinkWrap: true,
          children: channels.map<Widget>(listItem).toList()
        )
    );
  }

  Widget listArray(String countThis) {
    return Text(countThis);
  }

  Widget listItem(channel) {
    log('channels_list listVideo');
    print(channel);
    log('-- channels_list listVideo');
    // if (video['id']['kind'] != "youtube#video") {
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
                  channel['thumbnailMedium'] ?? '',
                  width: 120.0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      channel['channelId'] ?? '',
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
                      channel['channelId'] ?? '',
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: '',
                onPressed: () { deleteChannel(channel['channelId']); },
              ),
            ],
          ),
        ),
      );

  }
}
