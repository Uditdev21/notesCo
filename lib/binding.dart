import 'package:get/get.dart';
import 'package:notesco/services/database_services.dart';
import 'package:notesco/theme/theme_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<DatabaseService>(() => DatabaseService().init());
    Get.put(ThemeController());
  }
}
