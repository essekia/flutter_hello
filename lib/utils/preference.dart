import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserSimplePreferences {
  static SharedPreferences? _preferences;


  static const _keyChannels = 'channels';

  // static const _keyUsername = 'username';
  // static const _keyBirthday = 'birthday';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();

    // SharedPreferences.setMockInitialValues({});
  }

  // static Future setUsername(String username) async =>
  //     await _preferences?.setString(_keyUsername, username);
  //
  // static String? getUsername() => _preferences?.getString(_keyUsername);

  static Future setChannels(List<dynamic> channels) async {
    print("preferences.setChannels() ");
    print(channels);
    var channelsString = itemsToJson(channels);
    print("channelsString: ");
    print(channelsString);
    await _preferences?.setStringList(_keyChannels, channelsString.cast<String>() );
}

  static Future addChannel(Map<String, dynamic> channel) async {
    print("addChannel channels: ");
    var channels = getChannels() ?? [];
    channels?.add(channel);
    var channelsString = itemsToJson(channels);
    print(channels);

    await _preferences?.setStringList(_keyChannels, channelsString.cast<String>() );
  }

  static Future deleteChannel(channelId) async {
    var channels = getChannels() ?? [];
    channels.removeWhere((item) {
      print("removeWhere item: ");
      print(item);
      return item['channelId'] == channelId;
    });
    var channelsString = itemsToJson(channels);
    await _preferences?.setStringList(_keyChannels, channelsString.cast<String>() );
  }

  static List<dynamic>? getChannels() {
    var channelsJsoned = _preferences?.getStringList(_keyChannels) ?? [];
    var channels = [];
    for (var ii = 0; ii < channelsJsoned.length; ii++) {
      channels.add(json.decode(channelsJsoned[ii]));
    }

    return channels;
  }

  static itemsToJson(channels) {
    // return channels.toJson();
    var stringifiedChannelList = [];
    //  channels.forEach((item) {
    //   String itemString = jsonEncode(item);
    //   print("itemString: " + itemString);
    // });

     for(var ii = 0; ii < channels.length; ii++){
       var item = Map<String, dynamic>.from(channels[ii]);
       String itemString = json.encode(item);
       stringifiedChannelList.add(itemString);
       print("ii: " + ii.toString());
       print(itemString is String);
     }

     return stringifiedChannelList;
  }

}