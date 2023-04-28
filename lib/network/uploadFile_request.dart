import 'dart:io';
import 'package:eventsource/eventsource.dart';
const String progressUrl = 'http://103.162.20.167/api/progress';
const String postFileUrl = 'https://huydt.online/api/file/';

class UploadFileRequest {

  static Future<String> fetchUploadFile(String access_token, String fileType, File file) async {
    EventSource eventSource = await EventSource.connect(progressUrl, headers: {
      'Authorization': 'Bearer $access_token',
    });

    eventSource.listen((event) {
      if(event.event == 'GUID') {
        final GUID = event.data;
        var formData = new Map<String, dynamic>();

      }
    });

    // var _client = http.Client();
    // Map<String, String> headers = { 'Authorization': 'Bearer $access_token' };
    //
    // final req = http.Request('GET', Uri.parse(progressUrl));
    // req.headers.addAll(headers);
    // final res = await _client.send(req);
    //
    // res.stream.toStringStream().listen((value) {
    //   debugPrint(jsonDecode(value));
    // });

    // final response = await http.post(
    //   Uri.parse(url),
    //   body: jsonEncode({
    //     'amount': amount,
    //     'orderAttachment': orderAttachment
    //   }),
    //   headers: <String, String> {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Bearer $access_token',
    //   },
    // );
    // if (response.statusCode == 200) {
    //   return response.body.toString();
    // } else if (response.statusCode == 404) {
    //   throw Exception('Not Found');
    // } else if (response.statusCode == 401) {
    //   throw Exception('unauthorized');
    // } else {
    //   throw Exception('Can\'t not get posts');
    // }
    return 'this';
  }
}