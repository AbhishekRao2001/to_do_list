import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';

class HiveDatabaseViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade400,
        title: const Text('Hive Database Viewer'),
      ),
      body: FutureBuilder<List<Task>>(
        future: _loadTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  elevation: 4, // Elevation for shadow effect
                  margin: const EdgeInsets.all(8.0), // Margin around the card
                  child: Padding(
                    padding:
                        const EdgeInsets.all(16.0), // Padding inside the card
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                            height: 8.0), // Space between title and subtitle
                        Text('Due: ${task.dueDate}'),
                        Text('Priority: ${task.priority}'),
                        const SizedBox(height: 8.0), // Space before checkbox
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              task.isCompleted ? 'Completed' : 'Pending',
                              style: TextStyle(
                                color: task.isCompleted
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            Checkbox(
                              value: task.isCompleted,
                              onChanged: null, // Disable checkbox for view-only
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No tasks found.'));
          }
        },
      ),
    );
  }

  // Load tasks from the Hive box
  Future<List<Task>> _loadTasks() async {
    final box = Hive.isBoxOpen('tasksBox')
        ? Hive.box<Task>('tasksBox')
        : await Hive.openBox<Task>(
            'tasksBox'); // Ensure box is opened with Task type

    // Get the values directly without needing to map them
    return box.values.toList();
  }
}
