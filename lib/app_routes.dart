import 'package:get/get.dart';
import 'package:notesco/pages/add_edit_notes.dart';
import 'package:notesco/pages/home_page.dart';
import 'package:notesco/pages/view_note.dart';

class AppRoutes {
  static const home = '/';
  static const viewNotes="/viewNotes";
  static const AddNotes="/addNotes";

  static final routes = [
    GetPage(
      name: home,
      page: () => HomePage(),
    ),
    GetPage(
      name:viewNotes,
      page: () => ViewNote(),
    ),

    GetPage(name: AddNotes ,
        page:()=> AddEditNotes())

  ];
}
