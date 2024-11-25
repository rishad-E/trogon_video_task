import 'dart:developer';

import 'package:get/get.dart';
import 'package:video_task/model/modules_model.dart';
import 'package:video_task/model/subject_model.dart';
import 'package:video_task/model/video_model.dart';
import 'package:video_task/service/subject_service.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SubjectController extends GetxController {
  bool _isLoading = false;
  bool _isLoadingModule = false;
  bool _isLoadingVideo = false;
  final List<SubjectModel> _subjectList = [];
  final List<ModuleModel> _moduleList = [];
  final List<VideoModel> _videoList = [];

  bool get isLoading => _isLoading;
  bool get isLoadingModule => _isLoadingModule;
  bool get isLoadingVideo => _isLoadingVideo;
  List<SubjectModel> get subjectList => _subjectList;
  List<ModuleModel> get moduleList => _moduleList;
  List<VideoModel> get videoList => _videoList;

  YoutubePlayerController? playerController;
  String? currentVideoType;
  String? currentVideoUrl;

  @override
  void onInit() {
    super.onInit();
    fetchAllSubject();
  }

  Future<void> fetchAllSubject() async {
    try {
      _isLoading = true;
      update(['subject-list']);
      List<SubjectModel>? data = await Service().getAllSubjects();

      if (data != null) {
        _subjectList.assignAll(data);
      }

      update();
    } catch (e) {
      log(e.toString(), name: 'sub-error c');
    } finally {
      _isLoading = false;
      update(['subject-list']);
    }
  }

  Future<void> fetchModule(String subId) async {
    try {
      _isLoadingModule = true;
      update(['module-list']);
      List<ModuleModel>? data = await Service().getModule(subId);
      if (data != null) {
        _moduleList.assignAll(data);
      }
    } catch (e) {
      log(e.toString(), name: 'module-error c');
    } finally {
      _isLoadingModule = false;
      update(['module-list']);
    }
  }

  Future<void> fetchVideos(String moduleId) async {
    try {
      _isLoadingVideo = true;
      update(['video-list']);
      List<VideoModel>? data = await Service().getVideo(moduleId);
      if (data != null) {
        _videoList.assignAll(data);
      }
    } catch (e) {
      log(e.toString(), name: 'video-error c');
    } finally {
      update(['video-list']);
      _isLoadingVideo = false;
    }
  }

  void initializeVideo(String videoType, String videoUrl) {
    currentVideoType = videoType;
    currentVideoUrl = videoUrl;

    log(videoType, name: 'name');
    if (videoType == "VideoType.YOU_TUBE") {
      try {
        final videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
        log("Initializing YouTube Player with videoId: $videoId");

        playerController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            controlsVisibleAtStart: true,
          ),
        );
      } catch (e) {
        log("Error initializing YouTube Player: $e");
      }
    } else {
      log("Unsupported video type: $videoType");
    }

    update(['video-player']);
  }

  void disposeVideo() {
    playerController?.dispose();
    playerController = null;
    currentVideoType = null;
    currentVideoUrl = null;
    update(['video-player']);
  }
}
