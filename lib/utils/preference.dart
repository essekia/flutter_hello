import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:flutter_hello/utils/channel.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;


  static const _keyChannels = 'channels';

  // static const _keyUsername = 'username';
  // static const _keyBirthday = 'birthday';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();

    // SharedPreferences.setMockInitialValues({}); // to reset State
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

  static Future resetChannels() async {
    log("resetChannels");
     setChannels([]);
  }

  static List<dynamic>? getChannels() {
    print("UserSimpPreference getChannels: ");
    var channelsJsoned = _preferences?.getStringList(_keyChannels) ?? [];
    print("channelsJsoned: ");
    print(channelsJsoned);
    var channels = [];
    for (var ii = 0; ii < channelsJsoned.length; ii++) {
      var channelDecoded = new Map();
      var channelData = json.decode(channelsJsoned[ii]);
      channelDecoded['channelInfo'] = json.decode(channelData[0]);
      channelDecoded['videos'] = json.decode(channelData[1]);
      channels.add(channelDecoded);
    }

    return channels;
  }

  static List<dynamic>? getChannelsInfo() {
    print("getChannelsInfo: ");
    var channelsJsoned = _preferences?.getStringList(_keyChannels) ?? [];
    var channels = getChannels() ?? [];
    print("All channelsJsoned: ");
    print(channelsJsoned);
    var channelsWithInfo = [];
    for (var ii = 0; ii < channels.length; ii++) {
      var channel = channels[ii];
      print("channel[channelInfo]: " + ii.toString());
      print(channel['channelInfo']);

      channelsWithInfo.add(channel['channelInfo']);
    }
    print("channelsWithInfo: ");
    print(channelsWithInfo);
    // for (var ii = 0; ii < channelsJsoned.length; ii++) {
    //   var channelData = json.decode(channelsJsoned[ii]);
    //   print("channelData[0] -- channelInfo before decode");
    //   print(channelData[0]);
    //
    //   Map<String, dynamic> channelInfo = jsonDecode(channelData[0]);
    //   print("channelData[0] -- channelInfo after decode");
    //   print(channelInfo);
    //   channels.add(channelInfo);
    // }

    return channelsWithInfo;
  }

  static List<dynamic>? getAllChannelVideos() {
    // var channelsJsoned = _preferences?.getStringList(_keyChannels) ?? [];
    // print("channelsJsoned: ");
    // print(channelsJsoned);
    // var channelVideos = [];
    // for (var ii = 0; ii < channelsJsoned.length; ii++) {
    //   var channelData = json.decode(channelsJsoned[ii]);
    //   print("channelData[1] -- channelVideos before decode");
    //   print(channelData[1]);
    //   var channelVideos = json.decode(channelData[1]);// videos in channelData
    //   print("channelData[0] -- channelVideos after decode");
    //   print(channelVideos);
    //   channelVideos.add(channelVideos);
    // }

    List? channels = getChannels();
    var channelVideos = [];
    for (var ii = 0; ii < (channels?.length ?? 0); ii++) {
      channelVideos.add(channels?[ii]['videos']);
    }

    return channelVideos;
  }



  static Future addChannel(Map<dynamic, dynamic> channel) async {
    print("addChannel channelData: ");
    print(channel);
    var channels = getChannels() ?? [];
    print("addChannel getting Channels: ");
    print(channels);
    channels?.add(channel);
    print("addChannel after adding channel: ");
    print(channels);
    var channelsString = itemsToJson(channels);
    // print("addChannel after Setting Channels: ");
    // print(channels);
    print("addChannel after adding channel: ");
    print(channels);

    await _preferences?.setStringList(_keyChannels, channelsString.cast<String>() );

    print("After setting preference:");
    channels = getChannels() ?? [];
    print("addChannel after Setting Channels: ");
    print(channels);

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





  static itemsToJson(channels) {
    // return channels.toJson();
    var stringifiedChannelList = [];
    //  channels.forEach((item) {
    //   String itemString = jsonEncode(item);
    //   print("itemString: " + itemString);
    // });

     for(var ii = 0; ii < channels.length; ii++){
       var item = Map<dynamic, dynamic>.from(channels[ii]);
       // 1. Encode channel['videos]
       var channelJsoned = List.filled(2, "");
       channelJsoned[0] = json.encode(item['channelInfo']);
       channelJsoned[1] = json.encode(item['videos']);

       String itemString = json.encode(channelJsoned);
       stringifiedChannelList.add(itemString);
       print("ii: " + ii.toString());
       print(itemString is String);
     }

     return stringifiedChannelList;
  }

}