import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesco/AppBar.dart';
import 'package:notesco/app_routes.dart';
import 'package:notesco/models/notes_model.dart';
import 'package:notesco/theme/app_color.dart';


class ViewNote extends StatefulWidget {
  const ViewNote({super.key});

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  final NotesModel Note=Get.arguments["note"];
  // final notes=

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GetAppBar( Title: 'View',),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Note.title,
              style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Container(
              // padding: EdgeInsets.all(10),
              child: Text(
                Note.content,
              ),
            ),
            Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.AddNotes,arguments: {
                    "isAdd":false,
                    "note":Note
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 5,bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Obx(
                       () {
                        return Center(child: Text("Edit",
                          style: TextStyle(fontSize: 20,
                              color: AppColors.text),));
                      }
                    )),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
