class NotesModel {
  final int? id;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;

  NotesModel({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a NotesModel to a Map (for SQLite)
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = { // Explicitly type 'map' here
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
    if (id != null) {
      map['id'] = id; // Now this is fine, as 'map' accepts dynamic values
    }
    return map;
  }

  // Create a NotesModel from a Map (from SQLite)
  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'] as int?, // It's good practice to cast, though often dynamic works
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }
}