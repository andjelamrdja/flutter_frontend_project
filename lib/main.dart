import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/views/entrypoint.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget defaultHome = MainScreen();
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  
  // Inicijalizujte Firebase sa vašom konfiguracijom
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC465tBv-bieXhR_RIzmEzFvNOxuz9-YUw",
      authDomain: "foodly-flutter-992a8.firebaseapp.com",
      projectId: "foodly-flutter-992a8",
      storageBucket: "foodly-flutter-992a8.firebasestorage.app",
      messagingSenderId: "303389567997",
      appId: "1:303389567997:web:df6704b502f348268bc794",
      measurementId: "G-ZYR77J4JQK",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Foodly',
          theme: ThemeData(
              scaffoldBackgroundColor: kOffWhite,
              iconTheme: const IconThemeData(color: kDark),
              primarySwatch: Colors.grey),
          home: defaultHome,
        );
      },
    );
  }
}
