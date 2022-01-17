
import 'package:flutter/material.dart';
import 'utils/preference.dart';
import 'utils/youtube_api.dart';
import '../utils/dummy_preference.dart';
import 'widgets/channels_list.dart';

import 'utils/state_container.dart';


class AddChannels extends StatefulWidget {
  @override
  _AddChannelsState createState() => _AddChannelsState();
}

class _AddChannelsState extends State<AddChannels> {

  // const _AddChannelsState({Key? key}) : super(key: key);
  List<dynamic> channels = [];
  final channelFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // UserSimplePreferences.resetChannels();
    channels = UserSimplePreferences.getChannels() ?? [];

    // print('--hello');
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    channelFieldController.dispose();
    super.dispose();
  }


  Future<void> dummySaveChannel() async {
    print("dummySaveChannel");
    var channels = DummyUserSimplePreferences.getChannels() ?? [];
    UserSimplePreferences.setChannels(channels);
  }

  Future<void> getAllChannelVideos() async {
    var allVideos =  await YoutubeApi.getAllChannelVideos();
    final container = StateContainer.of(context);

    container.updateUserInfo(allVideos);
  }


  Future<void> saveChannel(channelFieldData) async {
    print("channelFieldData: " + channelFieldData);
    print(channelFieldData);
    // var re = RegExp(r'(?<=/c/)(.*)(?=over)');
    var end = "/channel/";
    var  endIndex = channelFieldData.indexOf(end);
    var channelId = (channelFieldData.substring(endIndex + end.length , channelFieldData.length));
    print("channelId: " + channelId);
    var channelData = new Map();
    channelData['channelInfo'] = await YoutubeApi.getChannelInfo(channelId);
    channelData['videos'] = await YoutubeApi.getChannelVideos(channelId);
    print("saveChannel-> channelVideos: ");
    print(channelData);

    UserSimplePreferences.addChannel(channelData);
    getAllChannelVideos();
    setState(() {});

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChannelsList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Channel"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [


                TextField(
                  controller: channelFieldController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Channel ID',
                  ),
                ),

             Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Go back!'),
                  ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () { saveChannel(channelFieldController.text);},
                    child: Text('Add Channel'),
                  )
                ]
              )

          ],
        )
        ),
    );

  }
}
