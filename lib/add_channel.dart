

import 'package:flutter/material.dart';

import 'utils/preference.dart';

class AddChannels extends StatefulWidget {
  @override
  _AddChannelsState createState() => _AddChannelsState();
}

class _AddChannelsState extends State<AddChannels> {

  // const _AddChannelsState({Key? key}) : super(key: key);
  List<String> channels = [];
  @override
  void initState() {
    super.initState();
    saveChannel();
    channels = UserSimplePreferences.getChannels() ?? [];

    // print('--hello');
  }

  Future<void> saveChannel() async {
    var userName = "Paul";
    var channels = ['UC5C1JAn2BOuquNNXI2oEgaA', 'UCIPPMRA040LQr5QPyJEbmXA'];
    UserSimplePreferences.setChannels(channels);
    // SharedPreferences prefsJsonString = await SharedPreferences.getInstance();
    // Map decode_options = jsonDecode(prefsJsonString);
    // prefs.setString('userName', userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Second Route"),
        ),
        body: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back!'),
              ),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Channel ID',
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () { },
                child: Text('Looks like a RaisedButton'),
              )
            ]
        )
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
