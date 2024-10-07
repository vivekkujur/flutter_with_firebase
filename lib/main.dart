import 'package:android_fb_flutter/view/firestore_home_screen.dart';
import 'package:android_fb_flutter/view/hive/hive_home_screen.dart';
import 'package:android_fb_flutter/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // init hive path
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Firebase realtime / Firestore  ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
          primarySwatch: Colors.deepPurple

      ),
        home: const HiveHomeScreen(),
    );
  }
}
