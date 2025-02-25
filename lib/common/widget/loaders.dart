import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_task/image_task.dart';
class AppLoader extends StatelessWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoActivityIndicator()
        :  CircularProgressIndicator(backgroundColor: Colors.blue.shade300,color: Colors.blue.shade100,);
  }
}

class SmallLoader extends StatelessWidget {
  const SmallLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppLoader(),
    );
  }
}

class StackedLoader extends StatelessWidget {
  final Widget? child;
  final bool? loading;
  final double? height;

  const StackedLoader({Key? key, this.child, this.loading,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child ?? const SizedBox(),
        if (loading == true)
          Container(
            color: Colors.black.withOpacity(0.1),
            height: height ?? Get.height,
            width: Get.width,
            child: const Center(
              child: AppLoader(),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}

