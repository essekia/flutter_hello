import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
YoutubePlayer(
controller: YoutubePlayerController(
initialVideoId: 'zn2GwbPG-tc', //Add videoID.
flags: YoutubePlayerFlags(
hideControls: false,
controlsVisibleAtStart: true,
autoPlay: false,
mute: false,
),
),
showVideoProgressIndicator: true,
progressIndicatorColor: AppColors.primary,
),