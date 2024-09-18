import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class EditTaskPage extends StatefulWidget {
  final Task? task; // This is the task being edited

  EditTaskPage({this.task}); // Constructor allows passing a task for editing

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final TaskController taskController = Get.find();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDueDate;
  int _priorityLevel = 1; // Default priority level

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      // If we're editing a task, pre-fill the fields
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description ?? '';
      _selectedDueDate = widget.task!.dueDate;
      _priorityLevel = widget.task!.priority;
    }
  }

  void _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDueDate) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  void _saveTask() {
    if (_titleController.text.isEmpty || _selectedDueDate == null) {
      Get.snackbar(
          'Error', 'Please provide a title and due date for the task.');
      return;
    }

    if (widget.task == null) {
      // Creating a new task
      Task newTask = Task(
        title: _titleController.text,
        description: _descriptionController.text,
        dueDate: _selectedDueDate!,
        priority: _priorityLevel,
        isCompleted: false,
        id: DateTime.now().millisecondsSinceEpoch,
      );
      taskController.addTask(newTask);
    } else {
      // Editing an existing task
      Task updatedTask = Task(
        id: widget.task!.id,
        title: _titleController.text,
        description: _descriptionController.text,
        dueDate: _selectedDueDate!,
        priority: _priorityLevel,
        isCompleted: widget.task!.isCompleted,
      );
      taskController.updateTask(updatedTask);
    }

    Get.back(); // Go back to the task list after saving
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
            title: Text(widget.task == null ? 'Create Task' : 'Edit Task'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: _saveTask, // Save the task when tapped
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Task Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(hintText: 'Task Description'),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(
                _selectedDueDate == null
                    ? 'Pick a Due Date'
                    : 'Due Date: ${DateFormat('yyyy-MM-dd').format(_selectedDueDate!)}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDueDate(context),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: _priorityLevel,
              decoration: const InputDecoration(labelText: 'Priority Level'),
              items: [1, 2, 3].map((level) {
                return DropdownMenuItem<int>(
                  value: level,
                  child: Text('Priority $level'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _priorityLevel = value ?? 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

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


