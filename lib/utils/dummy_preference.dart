import 'package:shared_preferences/shared_preferences.dart';

class DummyUserSimplePreferences {

  static List<dynamic>? getChannels() {
    var channels = [
      {
        'channelId': 'UC5C1JAn2BOuquNNXI2oEgaA',
        'thumbnailMedium': 'https://i.ytimg.com/vi/0QRTAwJoXuk/mqdefault.jpg',
      },
      {
        'channelId': 'UCIPPMRA040LQr5QPyJEbmXA',
        'thumbnailMedium': 'https://i.ytimg.com/vi/0QRTAwJoXuk/mqdefault.jpg',
      }
    ];

    return channels;
  }

}