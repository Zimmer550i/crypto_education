import 'dart:convert';

import 'package:crypto_education/models/courses_model.dart';
import 'package:crypto_education/models/live_class.dart';
import 'package:crypto_education/models/topic.dart';
import 'package:crypto_education/models/video.dart';
import 'package:crypto_education/services/api_service.dart';
import 'package:crypto_education/services/shared_prefs_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utils/custom_snackbar.dart';

class VideoController extends GetxController {
  final api = ApiService();

  RxList<Topic> topics = RxList.empty();
  RxList<CourseModel> courses = RxList.empty();
  RxBool isLoading = RxBool(false);
  Rxn<LiveClass> liveClass = Rxn();
  List<Video> videos = RxList.empty();

  Future<String> getCourses({bool override = false}) async {
    isLoading(true);
    try {
      final response = await SharedPrefsService().cacheResponse(
        key: "courses",
        frequency: CacheFrequency.oneHour,
        fetchCallback: () =>
            api.get("/api/v1/tutorials/courses/", authReq: true),
      );
      final body = jsonDecode(response.body);

      debugPrint("📦${response.body}");

      if (response.statusCode == 200) {
        final data = body['data'];

        courses.clear();
        for (var i in data) {
          courses.add(CourseModel.fromJson(i));
        }

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }


  Future<String> getCategory({bool override = false, required int id}) async {
    isLoading(true);
    try {
      final response = await SharedPrefsService().cacheResponse(
        key: "topics_$id",
        frequency: CacheFrequency.oneHour,
        override: override,
        fetchCallback: () =>
            api.get("/api/v1/tutorials/categories/courses/$id/", authReq: true),
      );

      final body = jsonDecode(response.body);
      debugPrint("📦 ${response.body}");

      topics.clear();

      if (response.statusCode == 200) {
        final List data = body['data'] ?? [];
        topics.addAll(data.map((e) => Topic.fromJson(e)).toList());
        return "success";
      } else {
        return body['message']?.toString() ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }

  Future<String> getLiveClass() async {
    try {
      final response = await api.get("/api/v1/tutorials/live_classes/",
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        if ((data as List).isNotEmpty) {
          liveClass.value = LiveClass.fromJson(data.first);
        } else {
          liveClass.value = null;
        }

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> getVideos(String id, {bool override = false}) async {
    isLoading(true);
    try {
      final response = await SharedPrefsService().cacheResponse(
        key: id.toString(),
        frequency: CacheFrequency.sixHours,
        override: override,
        fetchCallback: () =>
            api.get("/api/v1/tutorials/category_videos/$id/", authReq: true),
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        videos.clear();
        for (var i in data['videos']) {
          videos.add(Video.fromJson(i));
        }

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }
}
