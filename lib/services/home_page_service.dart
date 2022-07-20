import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_arkademi/models/course_response.dart';
import 'package:test_arkademi/models/course_response.dart';
import 'package:test_arkademi/models/course_response.dart';

class HomePageService {

  Future<CourseResponse> getActivity() async {
    String url = "https://engineer-test-eight.vercel.app/course-status.json";
    final response = await http.get(
      Uri.parse(url),
    );
    var errorStatus = json.decode(response.body);
    if (errorStatus != null) {
      return CourseResponse.fromJson(jsonDecode(response.body));
    } else {
      return CourseResponse.fromJson(jsonDecode(response.body));
    }
  }

}