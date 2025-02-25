class Task {
  final String title;

  final String description;

  bool isCompleted;

  final DateTime date;

  Task(
      {required this.title,
      required this.description,
      this.isCompleted = false,
      required this.date});

  Task copyWith({bool? isCompleted}) {
    return Task(
        title: title,
        description: description,
        isCompleted: isCompleted ?? this.isCompleted,
        date: date);
  }
}
