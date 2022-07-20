class CourseResponse {
  String? courseName;
  String? progress;
  List<Curriculum>? curriculum;

  CourseResponse({this.courseName, this.progress, this.curriculum});

  CourseResponse.fromJson(Map<String, dynamic> json) {
    courseName = json['course_name'];
    progress = json['progress'];
    if (json['curriculum'] != null) {
      curriculum = <Curriculum>[];
      json['curriculum'].forEach((v) {
        curriculum!.add(new Curriculum.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_name'] = this.courseName;
    data['progress'] = this.progress;
    if (this.curriculum != null) {
      data['curriculum'] = this.curriculum!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Curriculum {
  int? key;
  dynamic? id;
  String? type;
  String? title;
  int? duration;
  String? content;
  List? meta;
  int? status;
  String? onlineVideoLink;
  String? offlineVideoLink;

  Curriculum(
      {this.key,
        this.id,
        this.type,
        this.title,
        this.duration,
        this.content,
        this.meta,
        this.status,
        this.onlineVideoLink,
        this.offlineVideoLink});

  Curriculum.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    id = json['id'];
    type = json['type'];
    title = json['title'];
    duration = json['duration'];
    content = json['content'];
    if (json['meta'] != null) {
      meta = [];
    }
    status = json['status'];
    onlineVideoLink = json['online_video_link'];
    offlineVideoLink = json['offline_video_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['duration'] = this.duration;
    data['content'] = this.content;
    if (this.meta != null) {
      data['meta'] = this.meta!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['online_video_link'] = this.onlineVideoLink;
    data['offline_video_link'] = this.offlineVideoLink;
    return data;
  }
}
