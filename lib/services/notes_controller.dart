import 'package:get/get.dart';
import 'package:notesco/models/notes_model.dart';

import 'database_services.dart';

class NoteController extends GetxController {
  final DatabaseService _databaseService = Get.find<DatabaseService>();

  RxList<NotesModel> notes = <NotesModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    isLoading.value = true;
    notes.value = await _databaseService.getNotes();
    isLoading.value = false;
  }

  Future<void> searchNotes(String text)async{
    isLoading.value = true;
    notes.value = await _databaseService.searchNotesByTitle(text);
    isLoading.value = false;
  }

  Future<void> addNote({
    required String title,
    required String content,
  }) async {
    final now = DateTime.now().toIso8601String();
    final note = NotesModel(
      title: title,
      content: content,
      createdAt: now,
      updatedAt: now,
    );
    await _databaseService.insertNote(note);
    await fetchNotes();
  }

  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
  }) async {
    final existing = await _databaseService.getNote(id);
    if (existing != null) {
      final updated = NotesModel(
        id: id,
        title: title,
        content: content,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now().toIso8601String(),
      );
      await _databaseService.updateNote(updated);
      await fetchNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    await _databaseService.deleteNote(id);
    await fetchNotes();
  }

  NotesModel? getNoteById(int id) {
    return notes.firstWhereOrNull((note) => note.id == id);
  }
}
