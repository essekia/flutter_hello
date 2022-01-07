import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';
import '../utils/preference.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeApi {

  static String apiKey = "AIzaSyD1rB5tSMhu3b7W2X3SIEdFfQ-gimxysfQ";

  static Future getChannelInfo(channelId) async {
    YoutubeExplode? yt;
    yt = YoutubeExplode();

    var channel = await yt!.channels.get(channelId);
    var aboutPage =  await yt!.channels.getAboutPage(channelId);
    log('getChannelInfo New aboutPage:');
    print(aboutPage.thumbnails);
    var channelInfoToStore = {
      'channelId': channel.id.value,
      'title': channel.title,
      'thumbnailMedium':  "https://yt3.ggpht.com/ytc/AKedOLRDqB-y_zJ_Yr7EzU4YKYhThsjHG7c0ql6zk8jKiw=s48-c-k-c0x00ffffff-no-rj",
    };
    log('channelInfoToStore :');
    print(channelInfoToStore);

    return channelInfoToStore;

  }
  static Future getChannelVideos(channelId) async {
    YoutubeExplode? yt;
    yt = YoutubeExplode();

    var channel = await yt!.channels.get(channelId);
    var videos = await yt!.channels.getUploads('UCbJgkRhA-d61PTVOE62Al9g').toList();

    log('getChannelVideos New channel:');
    print(channel);
    log('getChannelVideos New channel -- :');
    log('getChannelVideos New:' + videos.length.toString());
    print(videos);
    return videos;
  }

  static Future getChannelVideosStable(channelId) async {
    var _baseUrl = 'www.youtube.googleapis.com';
    var channelUri = Uri.parse('https://youtube.googleapis.com/youtube/v3/search?part=id,snippet&maxResults=15&channelId='+channelId+'&key='+apiKey);

    var method1Response = await http.get(channelUri);
    log('Method1 Response status: ${method1Response.statusCode}');
    log('Method1 Response body: ${method1Response.body}');

    var channelContentsBody = await jsonDecode(method1Response.body);

    // todo: fromJson() -> List of youtube videos

    List channelContents = await channelContentsBody['items'];
    return channelContents;


  }

  // Main Function
  static Future<List> getAllChannelVideos() async {
    List allVideos = [];
    List channels = [];

    channels = UserSimplePreferences.getChannels() ?? [];
    print('getAllChannelVideos channels: ');
    print(channels);

    for (var ii = 0; ii < channels.length; ii++) {
      var channel = channels[ii];
      print('loop: ' + ii.toString());
      List channelContents = await getChannelVideos(channel['channelId']);
      var orderInChannel = 0;
      final videosOfChannel = channelContents.map((video){
        var videoObject = {
          'id': video.id.value,
          'title': video.title,
          'kind' : 'video',
          'thumbnailUrl' : video.thumbnails.mediumResUrl,
          'orderInChannel' : orderInChannel,
        };
        orderInChannel++;

        return videoObject;
      }).toList();


      allVideos.addAll(videosOfChannel);
      var totalContent = allVideos.length;
      log('allVideos.length: ' + totalContent.toString());
      print(totalContent);
    }

    return allVideos;


  }

}