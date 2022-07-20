import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:test_arkademi/models/course_response.dart';
import 'package:test_arkademi/services/home_page_service.dart';
import 'package:video_player/video_player.dart';

import '../utils/v_widget.dart';

class HomePageController extends GetxController {
  final HomePageService _resp = HomePageService();

  final RxList<CourseResponse> _dataCourse = <CourseResponse>[].obs;

  RxList<CourseResponse> get dataCourse => _dataCourse;

  final RxList<Curriculum> _dataCurriculum = <Curriculum>[].obs;

  RxList<Curriculum> get dataCurriculum => _dataCurriculum;

  RxString onlineVideo = "".obs;

  late VideoPlayerController controllerVideo;
  RxBool isPlay = false.obs;

  @override
  void onReady() {
    getCourse();
    super.onReady();
  }


  @override
  void onInit() {
    controllerVideo =
    VideoPlayerController.network("https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      });
    isPlay.value = true;
    super.onInit();
  }

  @override
  void dispose() {
    controllerVideo.dispose();
    super.dispose();
  }

  getCourse() async {
    Get.dialog(
      const Loading(),
      barrierDismissible: false,
    );
    CourseResponse _courseresp = await _resp.getActivity();
    Get.back();

    if (_courseresp != null) {
      dataCourse.value = [_courseresp];
      dataCurriculum.value = _courseresp.curriculum!;
      Fluttertoast.showToast(msg: "Success");
    } else {
      Fluttertoast.showToast(msg: "Fail");
    }
  }

}
