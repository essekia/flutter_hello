import 'package:flutter/material.dart';

// Our files
import 'add_channel.dart';
import 'utils/preference.dart';

// Routes
import 'widgets/channels_list.dart';
import 'widgets/videos_list.dart';
import 'widgets/video_player.dart';



Future main() async  {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSimplePreferences.init();
  await UserSimplePreferences.init();
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
      ),
      body: Column(
        children: [
          Row(
          children: [
            ElevatedButton(
              child: const Text('Add Channel'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddChannels()),
                );
              },
            ),
              ElevatedButton(
                child: const Text('Channels List'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChannelsList()),
                  );
                },
              ),
            ElevatedButton(
              child: const Text('Video player'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoPlayer(videoId: 'K18cpp_-gP8')),
                );
              },
            ),
              ],
          ),
          Expanded(
            child: SingleChildScrollView( child: YoutubeChannelApp()),
          ),
    ]
      ),
    );
  }
}




