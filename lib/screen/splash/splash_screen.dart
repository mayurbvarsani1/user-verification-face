

import 'package:image_task/image_task.dart';


bool _isActivityStart = false;

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  init() async {
    Future.delayed(const Duration(milliseconds: 3100), () async {
      Get.to(() => HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isActivityStart == false) {
      _isActivityStart = true;
      init();
    }
    return Scaffold(
      backgroundColor: const Color(0XFFEFF3FD),
      // body: Center(
      //   child: Icon(Icons.image,),
      // ),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/images/img.png",
            height:45.w,
            width: 45.w,
            fit: BoxFit.cover,
            gaplessPlayback: true,
          ),
        ),

    ),
    );
  }
}
