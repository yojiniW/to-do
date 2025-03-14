//add tasks to existing tasks
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo2/viewmodel/providers/taskProvider.dart';
import 'package:todo2/models/task.dart';

class Createnew extends ConsumerStatefulWidget {
  @override
  _Createnew createState() => _Createnew();
}

class _Createnew extends ConsumerState<Createnew> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  void _addTask() {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();

    if (title.isNotEmpty) {
      final newTask = Task(title: title, description: note, isCompleted: false, date:);
      ref.read(taskProvider.notifier).addTask(newTask);
      Navigator.pop(context); // Close screen after adding task
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Task",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_box, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      "Taski",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(''), // Profile image
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Welcome, John.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("You've got ${tasks.length} tasks to do."),
            const SizedBox(height: 16),

            // Recent Tasks (Preview)
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    color: task.isCompleted ? Colors.grey[200] : Colors.white,
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
                          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      subtitle: task.description.isNotEmpty ? Text(task.description) : null,
                    ),
                  );
                },
              ),
            ),

            // New Task Input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100],
              ),
              child: Row(
                children: [
                  Checkbox(value: false, onChanged: (value) {}),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "What's in your mind?",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Note Input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100],
              ),
              child: Row(
                children: [
                  const Icon(Icons.edit, color: Colors.blue),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _noteController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add a note..",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Create Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _addTask,
                child: const Text(
                  "Create",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
