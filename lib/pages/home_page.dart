import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notesco/AppBar.dart';
import 'package:notesco/app_routes.dart';
import 'package:notesco/models/notes_model.dart';
import '../services/database_services.dart';
import '../services/notes_controller.dart';
import '../theme/app_color.dart';
import '../theme/theme_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final DatabaseService _databaseService = Get.put(DatabaseService());
  final NoteController noteController = Get.put(NoteController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  //

  final themeController = Get.find<ThemeController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GetAppBar(Title: 'Notes',),
      body: Obx(() {
        if (noteController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search notes...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)
                  )
                ),
                onChanged: (query) {
                  noteController.searchNotes(query); // Ensure this is implemented
                },
              ),
            ),
            Expanded(
              child: noteController.notes.isEmpty
                  ? const Center(child: Text('No notes found. Add some!'))
                  : ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: noteController.notes.length,
                separatorBuilder: (_, __) => const SizedBox(height: 5),
                itemBuilder: (context, index) {
                  final note = noteController.notes[index];
                  return Slidable(
                    key: ValueKey(note.id),
                    startActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          onPressed: (_) async {
                            final confirm = await Get.dialog<bool>(
                              AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text('Are you sure you want to delete this note?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(result: false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Get.back(result: true),
                                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              await noteController.deleteNote(note.id!);
                            }
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => Get.toNamed(AppRoutes.viewNotes, arguments: {"note": note}),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.note, color: AppColors.text),
                            ),
                            const SizedBox(width: 10),
                            Expanded( // Ensures text does not overflow
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    note.content.length > 20
                                        ? "${note.content.substring(0, 20)}..."
                                        : note.content,
                                    overflow: TextOverflow.ellipsis,
                                  )

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  );

                },
              ),
            ),
          ],
        );
      }),


      floatingActionButton: Obx(
        () {
          return FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () => Get.toNamed(
                AppRoutes.AddNotes,
                arguments:
                {"isAdd":true,
                  "note":NotesModel(title: '',
                    content: '',
                    createdAt: '',
                    updatedAt: '',)}),
            child: Icon(Icons.add,color: AppColors.text,),
          );
        }
      ),
    );
  }
}
