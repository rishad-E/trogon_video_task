import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_task/controller/subject_controller.dart';
import 'package:video_task/view/home/video_page.dart';
import 'package:video_task/view/widgets/appbar.dart';
import 'package:video_task/view/widgets/widgets.dart';

class VideoListPage extends StatelessWidget {
  VideoListPage({super.key});

  final SubjectController controller = Get.put(SubjectController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('watch videos'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: GetBuilder<SubjectController>(
          id: 'video-list',
          builder: (c) {
            if (c.isLoadingVideo) {
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 1),
              );
            }
            return ListView.separated(
              itemCount: c.videoList.length,
              itemBuilder: (context, index) {
                final data = c.videoList[index];
                return moduleTile(
                  title: data.title.toString(),
                  description: data.description.toString(),
                  type: "watch video",
                  onPressed: () {
                    c.initializeVideo(
                      data.videoType.toString(),
                      data.videoUrl.toString(),
                    );
                    Get.to(
                      () => VideoPage(
                        title: data.title.toString(),
                        description: data.description.toString(),
                        videoType: data.videoType.toString(),
                        videoUrl: data.videoUrl.toString(),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => preferedBox(height: 5),
            );
          },
        ),
      ),
    );
  }
}
