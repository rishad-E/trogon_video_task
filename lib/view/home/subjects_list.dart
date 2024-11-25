import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_task/controller/subject_controller.dart';
import 'package:video_task/view/home/module_list.dart';
import 'package:video_task/view/widgets/widgets.dart';

class SubjectsList extends StatelessWidget {
  SubjectsList({super.key});

  final SubjectController controller = Get.put(SubjectController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(
      id: 'subject-list',
      builder: (c) {
        if (c.isLoading) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 1),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 7,
            mainAxisSpacing: 10,
            childAspectRatio: 6 / 7,
          ),
          itemCount: c.subjectList.length,
          itemBuilder: (context, index) {
            final data = c.subjectList[index];
            return InkWell(
              onTap: () {
                c.fetchModule(data.id.toString());
                Get.to(() => ModuleListPage());
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.13,
                        decoration: BoxDecoration(
                          // color: Colors.yellow,
                          image: DecorationImage(
                            image: NetworkImage(data.image.toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      preferedBox(height: 5),
                      Text(
                        data.description.toString(),
                        style: const TextStyle(
                          overflow: TextOverflow.visible,
                          color: Color.fromARGB(255, 145, 143, 143),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
