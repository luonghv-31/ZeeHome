import 'dart:io';

import 'package:eventsource/eventsource.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const String progressUrl = 'http://103.162.20.167/api/progress';
const String postFileUrl = 'https://huydt.online/api/file/';

class UploadFileRequest {

  static Future<void> fetchUploadFile(String access_token, String fileType, file, final ValueSetter<int> myValueSetter, final ValueSetter<String> getImageKey) async {
    EventSource eventSource = await EventSource.connect(progressUrl, headers: {
      'Authorization': 'Bearer $access_token',
    });

    debugPrint('start uploading');

    eventSource.listen((event) async {
      if(event.event == 'GUID') {
        myValueSetter(0);
        final GUID = event.data;
        debugPrint(GUID);


        var request = http.MultipartRequest("POST", Uri.parse(postFileUrl));
        request.headers.addAll({
          "Accept": "application/json",
          "Authorization": "Bearer $access_token",
        });
        request.fields['file_type'] = 'image';
        request.fields['GUID'] = GUID!;
        request.files.add( await http.MultipartFile.fromPath('file', file.path! ));

        final responseStream = await request.send();

        final response = await http.Response.fromStream(responseStream);

        debugPrint(response.body.toString());
        getImageKey(response.body.toString());
      }
      if(event.event == 'progress') {
        debugPrint(event.data);
        myValueSetter(int.parse(event.data!));
      }
      if(event.event == 'complete') {
        myValueSetter(100);
      }
    });
  }

}