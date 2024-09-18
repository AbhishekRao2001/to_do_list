class Task {
  int id;
  String title;
  String? description;
  DateTime dueDate;
  int priority;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.dueDate,
    this.priority = 1, // Default priority level
    this.isCompleted = false, // Default is false, meaning task is not completed
  });

  // Convert a Task object into a Map object (for saving to database or storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority,
      'isCompleted': isCompleted ? 1 : 0, // Store as 1 or 0 in the database
    };
  }

  // Convert a Map object back into a Task object (for loading from database or storage)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      priority: map['priority'],
      isCompleted: map['isCompleted'] == 1, // Convert 1 or 0 to bool
    );
  }
}
