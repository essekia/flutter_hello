import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

// Our files
import 'youtube.dart';
import 'youtube_search.dart';
import 'widgets/videos_list.dart';
import 'add_channel.dart';
import 'utils/preference.dart';

// void main() {
//   HttpOverrides.global = new MyHttpOverrides();
//   runApp(const MyApp());
// }

Future main() async  {
  WidgetsFlutterBinding.ensureInitialized();

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
        title: const Text('First Route'),
      ),
      body: Column(
        children: [
          ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddChannels()),
            );
          },
        ),
          YoutubeChannelApp(),
    ]
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // YoutubePlayer(
//             //   controller: YoutubePlayerController(
//             //     initialVideoId: 'F9J3LktgUMs', //Add videoID.
//             //     flags: const YoutubePlayerFlags(
//             //       hideControls: false,
//             //       controlsVisibleAtStart: true,
//             //       autoPlay: true,
//             //       mute: false,
//             //     ),
//             //   ),
//             //   showVideoProgressIndicator: true,
//             // ),
//             // DemoApp(),
//             // YoutubeChannelApp(),
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
//               ),
//               onPressed: () {  MaterialPageRoute(builder: (context) => const AddChannels()); },
//               child: Text('Add Channel'),
//             ),
//             AddChannelsPage(),
//             AboutTopic('F9J3LktgUMs'),
//             //
//             // const Text(
//             //   'You have pushed the button this many times:',
//             // ),
//             // Text(
//             //   '$_counter',
//             //   style: Theme.of(context).textTheme.headline4,
//             // ),
//
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
//
//
// // For http handshaking
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
//
// }
//
//




