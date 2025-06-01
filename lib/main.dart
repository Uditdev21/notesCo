import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesco/app_routes.dart';
import 'package:notesco/binding.dart';  // your InitialBinding
import 'package:get_storage/get_storage.dart';
import 'package:notesco/theme/theme_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  final themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeController.themeMode.value,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,  // <-- add this line
    );
  }
}
