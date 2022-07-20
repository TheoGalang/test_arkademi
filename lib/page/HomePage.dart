// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:test_arkademi/controller/home_page_controller.dart';
import 'package:test_arkademi/utils/v_widget.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomePageController _controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 24,
        ),
        title: Obx(
          () => Text(
            _controller.dataCourse.isEmpty
                ? ""
                : _controller.dataCourse[0].courseName.toString(),
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          Center(
            child: Obx(
              () => Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                width: 30,
                child: _controller.dataCourse.isEmpty
                    ? Container()
                    : CircularPercentIndicator(
                        radius: 23.0,
                        lineWidth: 5.0,
                        percent: double.parse(
                                _controller.dataCourse[0].progress.toString()) /
                            100,
                        center: Text(
                          "${_controller.dataCourse[0].progress.toString()} %",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        progressColor: Colors.green,
                      ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _controller.isPlay.value = true;
                          _controller.controllerVideo.pause();
                        },
                        child: Center(
                          child: _controller.controllerVideo.value.isInitialized
                              ? AspectRatio(
                                  aspectRatio: _controller
                                      .controllerVideo.value.aspectRatio,
                                  child:
                                      VideoPlayer(_controller.controllerVideo),
                                )
                              : Container(
                                  height: 200,
                                  width: double.infinity,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _controller.isPlay.value = false;
                          _controller.controllerVideo.value.isPlaying
                              ? _controller.controllerVideo.pause()
                              : _controller.controllerVideo.play();
                        },
                        child: Visibility(
                          visible: _controller.isPlay.value,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey.shade200,
                            child: !_controller.controllerVideo.value.isPlaying
                                ? Icon(
                                    Icons.play_arrow,
                                    size: 30,
                                    color: Colors.blue,
                                  )
                                : Icon(
                                    Icons.pause,
                                    size: 30,
                                    color: Colors.blue,
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => Text(
                      _controller.dataCourse.isEmpty
                          ? ""
                          : _controller.dataCourse[0].courseName.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        bottom: TabBar(
                          tabs: [
                            Tab(
                              child: Text("Kurikulum",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Tab(
                              child: Text("Ikhtisar",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Tab(
                              child: Text("Lampiran",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Column(
                    children: _controller.dataCurriculum
                        .map(
                          (e) => Column(
                            children: [
                              e.type == "section"
                                  ? Container(
                                      padding: EdgeInsets.all(16),
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.grey.shade200,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.title.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "${(e.duration! / 60).ceil().toString()} menit",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        _controller.controllerVideo =
                                            VideoPlayerController.network(
                                                e.onlineVideoLink.toString())
                                              ..initialize().then((_) {
                                                // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                              });
                                        _controller.isPlay.value = true;
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(16),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    e.onlineVideoLink == "" ||
                                                            e.onlineVideoLink ==
                                                                null
                                                        ? Icon(
                                                            Icons.play_circle,
                                                            color: Colors.grey,
                                                            size: 16,
                                                          )
                                                        : Icon(
                                                            Icons.check_circle,
                                                            color: Colors.green,
                                                            size: 16,
                                                          ),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            e.title.toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14),
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                            "${(e.duration! / 60).ceil().toString()} menit",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible:
                                                    e.onlineVideoLink == "" ||
                                                            e.onlineVideoLink ==
                                                                null
                                                        ? false
                                                        : true,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      border: Border.all(
                                                          color: Colors.grey)),
                                                  padding: EdgeInsets.all(8),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Tersimpan",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        color: Colors.blue,
                                                        size: 14,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              color: Colors.white,
              padding: EdgeInsets.all(8),
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_ios_new_sharp, size: 12),
                          Icon(
                            Icons.arrow_back_ios_new_sharp,
                            size: 12,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Sebelumnya",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2,
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Selanjutnya"),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.arrow_forward_ios_sharp, size: 12),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
