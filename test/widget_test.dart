// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_hello/utils/channel.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    Map channelData =
        {
          'channelInfo' : {
            "channelId": "UCDBAqLYtoCYYUe2K_kx9Crw",
            "title": "AutomatorWP",
            "thumbnailMedium": "https://yt3.ggpht.com/ytc/AKedOLRWeoI7S7KtiEpOPPQ4xbvWvSKli9d6EO8cYd2O=s48-c-k-c0x00ffffff-no-rj"
        },
          "videos": [
            {
              "id": "JHCWVbLqR0A",
              "title": "AutomatorWP - Give access to site B when a purchase is made on site A (WooCommerce & LifterLMS)",
              "kind": "video",
              "thumbnailUrl": "https://img.youtube.com/vi/JHCWVbLqR0A/mqdefault.jpg",
              "orderInChannel": 0
            }
            ],
    };
    var channel = Channel(
      channelInfo: channelData['channelInfo'],
      videos: channelData['videos'],
    );

    var channelJson = channel.toJson();
    var channelJsonDecoded = Channel.fromJson(channelJson);
    print("channelJsonDecoded: ");
    print(channelJsonDecoded);
    // expect(channelJson, channel);
    expect(channelJsonDecoded.channelInfo, channelData['channelInfo']);
    expect(channelJsonDecoded.channelInfo['channelId'], channelData['channelInfo']['channelId']);
    expect(channelJsonDecoded.videos, channelData['videos']);

    // var channelJsonDecoded = channel.toMap();

    // Build our app and trigger a frame.
    // await tester.pumpWidget(const MyApp());
    //
    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
