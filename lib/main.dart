import 'package:flutter/material.dart';

// Utils
import 'utils/preference.dart';
import 'utils/state_container.dart';
import 'utils/youtube_api.dart';

// Routes
import 'widgets/channels_list.dart';
import 'widgets/videos_list.dart';
import 'widgets/stream.dart';
import 'widgets/video_player.dart';



Future main() async  {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSimplePreferences.init();
  await UserSimplePreferences.init();

  // runApp(const MaterialApp(
  //   title: 'Navigation Basics',
  //   home: FirstRoute(),
  // ));
  // var user = new User('John', 'Paul', 'Jackson');
  var allVideos =  await YoutubeApi.getAllChannelVideos();

  runApp(new StateContainer(child: new TodoApp(), allStreamVideos: allVideos));
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = new User('John', 'Paul', 'Jackson');
    return new MaterialApp(
      title: 'Some Todos',
      home: new FirstRoute(),
    );
  }
}

class FirstRoute extends StatefulWidget {
  @override
  FirstRouteState createState() => new FirstRouteState();
}
class FirstRouteState extends State<FirstRoute> {
  // User? user;
  List allStreamVideos = [];

  @override
  void initState()  {
    super.initState();
    getAllChannelVideos();
    print("Main initState: ");
  }

  Future<Null> _handleRefresh() async {
    print("_handleRefresh");
    getAllChannelVideos();

    return null;
  }

  Future<void> getAllChannelVideos() async {
    print("Main->getAllChannelVideos()");
    var allVideos =  await YoutubeApi.getAllChannelVideos();
    allVideos.take(50);
    setState(() { allStreamVideos = allVideos; });

  }



  @override
  Widget build(BuildContext context) {
    // final container = StateContainer.of(context);
    // user = container.user;
    // print("user: ");
    // print(container.user);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
      ),
      body: RefreshIndicator(
        child: Column(
        children: [
          Row(
          children: [
            // ElevatedButton(
            //   child: const Text('Add Channel'),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => AddChannels()),
            //     );
            //   },
            // ),
              ElevatedButton(
                child: const Text('Channels List'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChannelsList()),
                  );
                },
              ),
            // ElevatedButton(
            //   child: const Text('Video player'),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => VideoPlayer(videoId: 'K18cpp_-gP8')),
            //     );
            //   },
            // ),
              ],
          ),
          Expanded(
            child: SingleChildScrollView( child: StreamWidget(allStreamVideos: allStreamVideos)),
          ),
    ]
      ),
        onRefresh: _handleRefresh,
      ),
    );
  }
}




