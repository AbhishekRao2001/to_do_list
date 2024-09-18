import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import 'edit_task_page.dart'; // Page for editing tasks
import '../utils/permission_service.dart'; // Import the permission service

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TaskController taskController = Get.find();

  @override
  void initState() {
    super.initState();
    requestNotificationPermission(); // Request notification permission
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Set AppBar height
        child: ClipPath(
          clipper: CustomAppBarClipper(), // Apply custom clipper
          child: AppBar(
            backgroundColor: Colors.amber.shade400,
            title: const Text('To-Do List'),
            centerTitle: true,
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  // Update sorting criteria based on user selection
                  taskController.updateSortCriteria(value);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'priority',
                    child: Text('Sort by Priority'),
                  ),
                  const PopupMenuItem(
                    value: 'dueDate',
                    child: Text('Sort by Due Date'),
                  ),
                  const PopupMenuItem(
                    value: 'creationDate',
                    child: Text('Sort by Creation Date'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Tasks',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Update the search query in TaskController
                taskController.searchQuery.value = value;
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              // Display filtered and sorted tasks
              if (taskController.filteredTasks.isEmpty) {
                return const Center(child: Text('No tasks available.'));
              }

              return ListView.builder(
                itemCount: taskController.filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = taskController.filteredTasks[index];
                  return Card(
                    margin: const EdgeInsets.all(12),
                    color: Colors.grey.shade200,
                    elevation: 5,
                    shadowColor: Colors.amberAccent.shade100,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (task.description != null &&
                              task.description!.isNotEmpty)
                            Text(
                              task.description!,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          Text('Due: ${task.dueDate}'),
                        ],
                      ),
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (bool? newValue) {
                          // Update task completion status
                          taskController.updateTaskCompletion(
                              task, newValue ?? false);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          // Delete task action
                          bool? confirm = await Get.dialog(
                            AlertDialog(
                              title: const Text('Delete Task'),
                              content: const Text(
                                  'Are you sure you want to delete this task?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(result: false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Get.back(result: true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            taskController.deleteTask(task);
                          }
                        },
                      ),
                      onTap: () {
                        // Navigate to task edit page
                        Get.to(EditTaskPage(task: task));
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade400,
        onPressed: () {
          Get.to(EditTaskPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Custom Clipper for Rounded Bottom AppBar
class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30); // Start at bottom left
    path.quadraticBezierTo(
      size.width / 2, size.height, // Control point (center)
      size.width, size.height - 30, // End at bottom right
    );
    path.lineTo(size.width, 0); // Go to top right
    path.close(); // Complete the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
