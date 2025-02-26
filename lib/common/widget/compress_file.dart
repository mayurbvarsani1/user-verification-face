
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> compressImage(File? file) async {
  if (file == null) {
    return null;
  }
  Directory directory = await getTemporaryDirectory();
  var byte = await FlutterImageCompress.compressWithList(
    file.absolute.readAsBytesSync(),
    quality: 70,
    rotate: 0,
  );
  File result = File("${directory.path}/${DateTime.now().microsecondsSinceEpoch}.jpg")
    ..writeAsBytesSync(byte);

  final size = result.lengthSync();

  if (size > (1024*1024)) {
    return await compressImage(result);
  } else {
    return result;
  }
}