import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo2/models/task.dart';

final taskProvider =
    StateNotifierProvider<TaskNotifier, List<Task>>((ref) => TaskNotifier());

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([
    Task(title: "Design sign up flow", description: "By the time a prospect arrives at your signup page, in most cases, they've already ...", date: DateTime.now()),
    Task(title: "Design use case page", description: "", date: DateTime.now().subtract(Duration(days: 1))),
    Task(title: "Test Wireframe", description: "", date: DateTime.now().subtract(Duration(days: 1))),
    Task(title: "Create new task UI flow", description: "", date: DateTime(2025, 10, 8)),
    Task(title: "Collect project assets", description: "", date: DateTime(2025, 10, 8)),
  ]);


  void toggleTaskCompletion(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Task(
              title: state[i].title,
              description: state[i].description,
              isCompleted: !state[i].isCompleted,
              date: state[i].date)
        else
          state[i]
    ];
  }
}
