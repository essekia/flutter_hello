
import 'package:flutter/material.dart';

import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/preference.dart';
import '../utils/dummy_preference.dart';
import '../add_channel.dart';

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

    var channels = UserSimplePreferences.getChannelsInfo() ?? [];
    print("channels_list.dart channels");
    print(channels);

     return Scaffold(
        appBar: AppBar(
          title: const Text("Channels List"),
        ),
        body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddChannels()),
                      );
                    },
                    label: Text('Add Channel'),
                    icon: Icon(Icons.add),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                  ),
                ],
              ),
                ListView(
                // scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(), // new
                shrinkWrap: true,
                children: channels.map<Widget>(listItem).toList()
              )
            ]
        )
    );
  }

  Widget listArray(String countThis) {
    return Text(countThis);
  }

  Widget listItem(channel) {
    log('channels_list listVideo');
    print(channel);
    print(channel['thumbnailMedium']);
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
                padding: const EdgeInsets.only(right: 5.0),
                child: Image.network(
                  channel['thumbnailMedium'] ?? '',
                  width: 60.0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      channel['title'] ?? '',
                      softWrap: true,
                      style: TextStyle(fontSize: 18.0),
                    ),
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
