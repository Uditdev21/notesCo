import 'package:flutter/material.dart';
import 'package:notesco/AppBar.dart';
import 'package:notesco/app_routes.dart';
import 'package:notesco/models/notes_model.dart';
import 'package:get/get.dart';
import 'package:notesco/theme/app_color.dart';

import '../services/notes_controller.dart';

class AddEditNotes extends StatefulWidget {
  AddEditNotes({super.key});

  @override
  State<AddEditNotes> createState() => _AddEditNotesState();
}

class _AddEditNotesState extends State<AddEditNotes> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool isAdd;
  late NotesModel note;

  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();

    isAdd = Get.arguments["isAdd"] ?? true;
    note = Get.arguments["note"];

    if (isAdd) {
      titleController = TextEditingController();
      contentController = TextEditingController();
      return;
    }

    titleController = TextEditingController(text: note.title);
    contentController = TextEditingController(text: note.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _submit() async{
    if (formKey.currentState!.validate()) {
      print("Title: ${titleController.text}");
      print("Content: ${contentController.text}");
      final NoteController noteController = Get.put(NoteController());

      if (isAdd) {
        await noteController.addNote(
            title: titleController.text, content: contentController.text);
        Get.offAllNamed(AppRoutes.home);
        return;}

      await noteController.updateNote(
          id: note.id!, title: titleController.text, content: contentController.text);
      Get.offAllNamed(AppRoutes.home);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GetAppBar(Title: isAdd ? "Add Note" : "Edit Notes"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter Title',
                      // labelText: 'Title',
                      fillColor: AppColors.card,
                      border: const OutlineInputBorder(

                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelStyle: TextStyle(color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                    ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
            TextFormField(
              controller: contentController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Enter Content',
                fillColor: AppColors.card,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),),
                border: const OutlineInputBorder(

                  borderRadius: BorderRadius.all(Radius.circular(10)),

                ),
              ),

            validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter some content';
                      }
                      return null;
                    },
                    maxLines: 5,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Obx(
                           () {
                            return Text(
                              'Cancel',
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: _submit,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Obx(
                           () {
                            return Text(
                              isAdd ? 'Add' : 'Update',
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
