import 'package:flutter/material.dart';
import 'package:video_task/view/home/subjects_list.dart';
import 'package:video_task/view/widgets/appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Subjects'),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 14),
        child: SubjectsList(),
      ),
    );
  }
}
