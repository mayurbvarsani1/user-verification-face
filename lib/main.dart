import 'package:image_task/image_task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'image task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark().copyWith(
        ),
        useMaterial3: true,
      ),
      navigatorKey: navigationKey,
      home: const SplashScreen(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
