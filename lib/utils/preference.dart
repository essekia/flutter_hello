import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:flutter_hello/utils/channel.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _keyChannels = 'channels';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();

    SharedPreferences.setMockInitialValues({}); // to reset State
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
    var channels = getChannels() ?? [];

    var channelsWithInfo = [];
    for (var ii = 0; ii < channels.length; ii++) {
      var channel = channels[ii];
      channelsWithInfo.add(channel['channelInfo']);
    }
    // print("channelsWithInfo: ");
    // print(channelsWithInfo);

    return channelsWithInfo;
  }

  static List<dynamic>? getAllChannelVideos() {

    List? channels = getChannels();
    var channelVideos = [];
    for (var ii = 0; ii < (channels?.length ?? 0); ii++) {
      channelVideos.add(channels?[ii]['videos']);
    }

    return channelVideos;
  }

  static Future addChannel(Map<dynamic, dynamic> channel) async {
    print("addChannel channelData: ");

    var channels = getChannels() ?? [];
    channels?.add(channel);
    var channelsString = itemsToJson(channels);
    // print("addChannel after adding channel: ");
    // print(channels);

    await _preferences?.setStringList(_keyChannels, channelsString.cast<String>() );
  }

  static Future deleteChannel(channelId) async {
    var channels = getChannels() ?? [];
    channels.removeWhere((item) {
      print("removeWhere item: ");
      print(item['channelId']);
      return item['channelInfo']['channelId'] == channelId;
    });

    // print("after Remove channels: ");
    // print(channels);
    var channelsString = itemsToJson(channels);
    await _preferences?.setStringList(_keyChannels, channelsString.cast<String>() );

  }


  static itemsToJson(channels) {
    // return channels.toJson();
    var stringifiedChannelList = [];


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

  static Future setChannels(List<dynamic> channels) async {
    print("preferences.setChannels() ");
    print(channels);
    var channelsString = itemsToJson(channels);
    await _preferences?.setStringList(_keyChannels, channelsString.cast<String>() );
  }

  static Future resetChannels() async {
    log("resetChannels");
    setChannels([]);
  }

}