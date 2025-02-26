import 'dart:io';

import 'package:image_task/image_task.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeController  controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Face Recognition'),
        centerTitle: true,
        leading: SizedBox(),
        backgroundColor: Colors.blue,
        actions: [
          GetBuilder<HomeController>(
              id: "home_loader",
              builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(right:10),
                child: inkWell(onTap: () {
                  controller.init();
                  controller.homeLoader = false;
                  controller.update(["home_loader"]);
                },child: Icon(Icons.refresh)),
              );
            }
          )
        ],
      ),
      body: GetBuilder<HomeController>(
          id: "home_loader",
          builder: (controller) {
          return StackedLoader(
              loading: controller.homeLoader,

            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AppButton(
                    borderRadius: 5,
                    buttonName: "Upload Individual Image",
                    textColor: Colors.white,
                    onButtonTap: () {
                      controller.uploadIndividualImage(context);
                    },
                  ),
                  appSizedBox(height: 2.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                          controller.individuals.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                children: [
                                  Image.file(controller.individuals[index]['image'] as File, height: 100),
                                  Text(controller.individuals[index]['name']  ?? "",style: TextStyle(color: Colors.black),),
                                ],
                              ),
                            );
                          },
                        )),
                  ),
                  appSizedBox(height: 2.h),
                  if (controller.individuals.isNotEmpty)
                    AppButton(
                      buttonName: "Upload Group Image",
                      textColor: Colors.white,
                      borderRadius: 5,
                      onButtonTap: () {
                        controller.uploadGroupImage();
                      },
                    ),
                  appSizedBox(height: 2.h),

                  if (controller.groupImage != null)
                    Image.file(
                      controller.groupImage!,
                      width: 200,
                      height: 200,
                    ),
                  appSizedBox(height: 1.h),
                  if (controller.present.isNotEmpty )
                    Text('Present: ${controller.present.join(', ')}',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                  appSizedBox(height: 0.50.h),

                  if (controller.missing.isNotEmpty )
                    Text('Missing: ${controller.missing.join(', ')}',
                        style: TextStyle(fontSize: 18,color: Colors.black)),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

}
