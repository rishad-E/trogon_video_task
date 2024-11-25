import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:video_task/model/modules_model.dart';
import 'package:video_task/model/subject_model.dart';
import 'package:video_task/model/video_model.dart';
import 'package:video_task/utils/apis.dart';
import 'package:video_task/view/widgets/snackbar.dart';

class Service {
  Dio dio = Dio();

  /* ----------function to get all the subjects---------*/
  Future<List<SubjectModel>?> getAllSubjects() async {
    String path = Apis().baseUrl + Apis().subjectApi;
    try {
      Response response = await dio.get(
        path,
        options: Options(
          validateStatus: (status) => status! < 599,
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.data);
        final res = data.map((json) => SubjectModel.fromJson(json)).toList();
        return res;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        // log('Server error: ${e.message}', name: 'save education info error');
        log('Exception: ${e.toString()}', name: 'subject result error');
        throw SnackbarPopUps.popUpB(
            'Error fetching data...Please try after sometime');
      } else {
        log('Exception: ${e.toString()}', name: 'subject result error');
        throw SnackbarPopUps.popUpB(
            'Error fetching data...Please try after sometime');
      }
    }
    return null;
  }

  /* ----------function to get the appropriate modules---------*/
  Future<List<ModuleModel>?> getModule(String subId) async {
    String path = Apis().baseUrl + Apis().moduleApi;
    try {
      Response response = await dio.get(
        path,
        queryParameters: {"subject_id": subId},
        options: Options(
          validateStatus: (status) => status! < 599,
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.data);
        // log(data.toString(),name: 'modules');
        final res = data.map((json) => ModuleModel.fromJson(json)).toList();
        return res;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        // log('Server error: ${e.message}', name: 'save education info error');
        log('Exception: ${e.toString()}', name: 'modeul result error');
        throw SnackbarPopUps.popUpB(
            'Error fetching data...Please try after sometime');
      } else {
        log('Exception: ${e.toString()}', name: 'module result error');
        throw SnackbarPopUps.popUpB(
            'Error fetching data...Please try after sometime');
      }
    }
    return null;
  }

  Future<List<VideoModel>?> getVideo(String moduleId) async {
    String path = Apis().baseUrl + Apis().videoApi;
    try {
      Response response = await dio.get(
        path,
        queryParameters: {"module_id": moduleId},
        options: Options(
          validateStatus: (status) => status! < 599,
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.data);
        log(data.toString(),name: 'video');
        final res = data.map((json) => VideoModel.fromJson(json)).toList();
        return res;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        // log('Server error: ${e.message}', name: 'save education info error');
        log('Exception: ${e.toString()}', name: 'modeul result error');
        throw SnackbarPopUps.popUpB(
            'Error fetching data...Please try after sometime');
      } else {
        log('Exception: ${e.toString()}', name: 'module result error');
        throw SnackbarPopUps.popUpB(
            'Error fetching data...Please try after sometime');
      }
    }
    return null;
  }
}
