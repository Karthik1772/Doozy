class Task {
  String id;
  String title;
  bool isCompleted;
  DateTime createdAt;
  DateTime? dueDate;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.dueDate,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
