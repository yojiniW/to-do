import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo2/viewmodel/providers/taskProvider.dart';
import 'package:todo2/models/task.dart';

class Completetask extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedTasks = ref.watch(taskProvider).where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Tasks", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with "Delete All" option
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.check_box, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      "Taski",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const CircleAvatar(
                  backgroundImage: NetworkImage(''), // Profile image placeholder
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Title and Delete All Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Completed Tasks",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                if (completedTasks.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      ref.read(taskProvider.notifier).clearCompletedTasks();
                    },
                    child: const Text(
                      "Delete all",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // List of Completed Tasks
            Expanded(
              child: completedTasks.isEmpty
                  ? const Center(child: Text("No completed tasks yet."))
                  : ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  final task = completedTasks[index];
                  return Card(
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Checkbox(
                        value: true,
                        onChanged: (_) {
                          ref.read(taskProvider.notifier).toggleTaskCompletion(index);
                        },
                      ),
                      title: Text(
                        task.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          ref.read(taskProvider.notifier).removeTask(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
