import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_task/controller/subject_controller.dart';
import 'package:video_task/utils/const.dart';
import 'package:video_task/view/widgets/appbar.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatelessWidget {
  final String title;
  final String description;
  final String videoType;
  final String videoUrl;

  VideoPage({
    super.key,
    required this.title,
    required this.description,
    required this.videoType,
    required this.videoUrl,
  });
  final controller = Get.find<SubjectController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(''),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: kwhite,
          border: Border.all(
            color: const Color.fromARGB(255, 221, 220, 220),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 221, 220, 220),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: GetBuilder<SubjectController>(
                  id: 'video-player',
                  builder: (c) {
                    if (c.currentVideoType == "YouTube" &&
                        c.playerController != null) {
                      return YouTubePlayerWidget(
                          videoUrl: videoUrl, controller: c);
                    } else if (c.currentVideoType == "Vimeo") {
                      return VimeoPlayerWidget(videoUrl: videoUrl);
                    }
                    return const Center(child: Text("No video loaded"));
                  },
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        color: kblack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.014,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 116, 118, 119),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YouTubePlayerWidget extends StatelessWidget {
  final String videoUrl;
  final SubjectController controller;
  const YouTubePlayerWidget(
      {super.key, required this.videoUrl, required this.controller});

  @override
  Widget build(BuildContext context) {
    // final videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
    // YoutubePlayerController controller = YoutubePlayerController(
    //   initialVideoId: videoId,
    //   flags: const YoutubePlayerFlags(
    //     autoPlay: false,
    //     controlsVisibleAtStart: true,
    //   ),
    // );

    return YoutubePlayer(
      controller: controller.playerController!,
      showVideoProgressIndicator: true,
      progressColors: const ProgressBarColors(
        playedColor: Colors.red,
        handleColor: Colors.redAccent,
      ),
    );
  }
}

class VimeoPlayerWidget extends StatelessWidget {
  final String videoUrl;

  const VimeoPlayerWidget({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return VimeoPlayer(
      videoId: videoUrl,
    );
  }
}
