import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_task/controller/subject_controller.dart';
import 'package:video_task/view/home/video_list_page.dart';
import 'package:video_task/view/widgets/appbar.dart';
import 'package:video_task/view/widgets/widgets.dart';

class ModuleListPage extends StatelessWidget {
  ModuleListPage({super.key});

  final SubjectController controller = Get.put(SubjectController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Modules'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: GetBuilder<SubjectController>(
          id: 'module-list',
          builder: (c) {
            if (c.isLoadingModule) {
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 1),
              );
            }
            return ListView.separated(
              itemCount: c.moduleList.length,
              itemBuilder: (context, index) {
                final data = c.moduleList[index];
                return moduleTile(
                  title: data.title.toString(),
                  description: data.description.toString(),
                  type: 'click here',
                  onPressed: () {
                    c.fetchVideos(data.id.toString());
                    Get.to(()=>VideoListPage());
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
