import 'dart:io';

import 'package:image_task/common/widget/compress_file.dart';
import 'package:image_task/image_task.dart';

class HomeController extends GetxController {
  init() {
    individuals = [];

    groupImage = null;
    present = [];
    missing = [];
  }

  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> individuals = [];
  File? groupImage;
  List<String> present = [];
  List<String> missing = [];
  bool homeLoader = false;

  Future<void> uploadIndividualImage(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File? compFile = await compressImage(File(image.path));
      String? name = await showDialog(
        context: context,
        builder: (context) {
          String name = '';
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Enter Name',
              style: TextStyle(color: Colors.black),
            ),
            content: CommonTextFiled(
              hintText: "Enter name",
              heading: "Name",
              onChanged: (value) => name = value,
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      onButtonTap: () {
                        Get.back();
                      },
                      buttonName: "Cancel",
                      textColor: Colors.white,
                    ),
                  ),
                  appSizedBox(width: 2.w),
                  Expanded(
                    child: AppButton(
                      onButtonTap: () => Navigator.pop(context, name),
                      buttonName: "Save",
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );

      individuals.add({'name': name, 'image': File(compFile?.path ?? "")});
      update(["home_loader"]);
    }
  }

  Future<void> uploadGroupImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      File? compFile = await compressImage(File(image.path));
      groupImage = File(compFile?.path ?? "");
      print("groupImage=>${groupImage}");
      update(["home_loader"]);

      await callAzureFaceAPI();
    }

  }

  Future<void> callAzureFaceAPI() async {
    if (groupImage == null || individuals.isEmpty) return;

    homeLoader = true;
    update(["home_loader"]);

    var groupFaceIds = await HomeApi.detectFaces(groupImage!);
    print("groupFaceIds=>${groupFaceIds}");
    if (groupFaceIds.isEmpty) {
      print('No faces detected in the group image');

      homeLoader = false; // Stop loading
      update(["home_loader"]);

      return;
    }

    Map<String, String> individualFaceIds = {};
    for (var individual in individuals) {
      var faceIds = await HomeApi.detectFaces(individual['image']);
      if (faceIds.isNotEmpty) {
        individualFaceIds[individual['name']] = faceIds.first;
      }
    }

    present.clear();
    missing.clear();
    for (var name in individualFaceIds.keys) {
      var result = await HomeApi.verifyFaces(individualFaceIds[name]!, groupFaceIds.first);
      if (result['isIdentical']) {
        present.add(name);
      } else {
        missing.add(name);
      }
    }

    homeLoader = false;
    update(["home_loader"]);
  }
}
