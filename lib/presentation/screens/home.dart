import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo2/viewmodel/providers/taskProvider.dart';

import '../../models/task.dart';

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.check_box, color: Colors.blue),
                SizedBox(width: 8),
                Text("Taski",
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(''),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: tasks.isEmpty ? _buildEmptyState() : _buildTaskList(tasks, ref),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Todo"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "create"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: "Done"),
        ],
      ),
    );

  }
}
Widget _buildEmptyState() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text(
        "Welcome, John.",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      const Text(
        "Create tasks to achieve more.",
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16),
      Image.asset(
        'assets/empty_tasks.png', // Add an empty state illustration
        height: 100,
      ),
      const SizedBox(height: 16),
      const Text("You have no task listed."),
      const SizedBox(height: 16),
      ElevatedButton.icon(
        onPressed: () {
          // Navigate to task creation screen
        },
        icon: const Icon(Icons.add),
        label: const Text("Create task"),
      ),
    ],
  );
}
Widget _buildTaskList(List<Task> tasks, WidgetRef ref) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Welcome, John.",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Text("You've got ${tasks.length} tasks to do."),
      const SizedBox(height: 16),
      Expanded(
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              child: ListTile(
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    ref.read(taskProvider.notifier).toggleTaskCompletion(index);
                  },
                ),
                title: Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                subtitle: task.description.isNotEmpty ? Text(task.description) : null,
              ),
            );
          },
        ),
      ),
    ],
  );
}

