
import 'package:flutter/material.dart';
import 'utils/preference.dart';
import 'utils/youtube_api.dart';
import '../utils/dummy_preference.dart';
import 'widgets/channels_list.dart';


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
    var userName = "Paul";
    // var channels = ['UC5C1JAn2BOuquNNXI2oEgaA', 'UCIPPMRA040LQr5QPyJEbmXA'];
    var channels = DummyUserSimplePreferences.getChannels() ?? [];

    UserSimplePreferences.setChannels(channels);
    // SharedPreferences prefsJsonString = await SharedPreferences.getInstance();
    // Map decode_options = jsonDecode(prefsJsonString);
    // prefs.setString('userName', userName);
  }

  Future<void> saveChannel(channelFieldData) async {
    print("channelFieldData: " + channelFieldData);
    print(channelFieldData);
    // var re = RegExp(r'(?<=/c/)(.*)(?=over)');
    var end = "/channel/";
    var  endIndex = channelFieldData.indexOf(end);
    var channelId = (channelFieldData.substring(endIndex + end.length , channelFieldData.length));
    print("channelId: " + channelId);
    var channelVideos = await YoutubeApi.getChannelInfo(channelId);

    // print("channelVideos: ");
    // print(channelVideos[0]);
    // print(channelVideos[0]['snippet']);
    // print(" -- channelVideos: ");




    // var channelInfoToStore = {
    //   'channelId': channelVideos[0]['snippet']['channelId'],
    //   'title': channelVideos[0]['snippet']['title'],
    //   'thumbnailMedium':  channelVideos[0]['snippet']['thumbnails']['medium']['url'],
    // };

    UserSimplePreferences.addChannel(channelVideos);

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




// class AddChannels extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AddChannelsPage(),
//     );
//   }
// }
//
// class AddChannelsPage extends StatefulWidget {
//   @override
//   _AddChannelsState createState() => _AddChannelsState();
// }
//
// class _AddChannelsState extends State<AddChannelsPage> {
//
//   Future<void> saveChannel(channel) async {
//     var userName = "Paul";
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('userName', userName);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     var sampleArray = ["one", "two", "three"];
//     return  Column(
//       children: [
//        TextField(
//       obscureText: true,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: 'Enter Channel ID',
//       ),
//     ),
//         ElevatedButton(
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
//           ),
//           onPressed: () { },
//           child: Text('Looks like a RaisedButton'),
//         )
//     ]
//     );
//
//
//
//     // return const Text("Hello");
//
//   }
// }
