import 'dart:io';

import 'package:image_task/image_task.dart';
import 'package:http/http.dart' as http;

class HomeApi {



  static Future<List<String>> detectFaces(File image) async {
    var request = http.MultipartRequest('POST', Uri.parse(EndPoints.detectApi));
    request.fields['api_key'] = Constants.apiKey;
    request.fields['api_secret'] = Constants.apiSecret;
    request.files.add(
      await http.MultipartFile.fromPath('image_file', image.path),
    );

    var response = await request.send();
    print("response=>${response.statusCode}");
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var faces = json.decode(responseData);
      return faces['faces'].map<String>((face) => face['face_token'] as String).toList();
    } else {
      print('Error detecting faces: ${response.statusCode}');
      print('Response body: ${await response.stream.bytesToString()}');
      return [];
    }
  }

  static  Future<Map<String, dynamic>> verifyFaces(String faceToken1, String faceToken2) async {
    var request = http.MultipartRequest('POST', Uri.parse(EndPoints.compareApi));
    request.fields['api_key'] = Constants.apiKey;
    request.fields['api_secret'] = Constants.apiSecret;
    request.fields['face_token1'] = faceToken1;
    request.fields['face_token2'] = faceToken2;

    var response = await request.send();
    print("verifyFaces=>${response.statusCode}");

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var result = json.decode(responseData);
      return {
        'isIdentical': result['confidence'] > 80,
        'confidence': result['confidence'],
      };
    } else {
      print('Error verifying faces: ${response.statusCode}');
      print('Response body: ${await response.stream.bytesToString()}');
      return {'isIdentical': false, 'confidence': 0};
    }
  }
}