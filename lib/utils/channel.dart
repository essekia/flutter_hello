import 'dart:convert';

class Channel {
  Map channelInfo = {};
  List videos = [];

  Channel({
    required this.channelInfo,
    required this.videos,
  });

  factory Channel.fromJson(String str) => Channel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Channel.fromMap(Map<String, dynamic> json){
    print("Channel.fromMap json: ");
    print(json);
    return Channel(
      channelInfo: json["channelInfo"],
      videos: json["videos"],
    );
  }

    Map<String, dynamic> toMap() => {
      "channelInfo": channelInfo,
      "videos": videos,
    };
  }
