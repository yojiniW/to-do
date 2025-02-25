import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo2/viewmodel/providers/taskProvider.dart';

class Search extends ConsumerStatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = " ";

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);
    final searchResults = tasks
        .where((task) =>
            task.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

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
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                hintText: "Search task",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            searchQuery = " ";
                            searchController.clear();
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            SizedBox(height: 20),
            searchResults.isEmpty
                ? Column(
                    children: [
                      Icon(Icons.insert_drive_file,
                          size: 80, color: Colors.blue.shade200),
                      const Text("No result found.",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final task = searchResults[index];
                        return ListTile(
                          title: Text(task.title),
                          subtitle: Text(task.description.isNotEmpty
                              ? task.description
                              : "No description"),
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
