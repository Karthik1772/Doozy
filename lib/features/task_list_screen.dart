import 'package:demo/core/models/task.dart';
import 'package:demo/core/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(elevation: 20, title: Text('Task Manager')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (ctx, index) {
                final task = taskProvider.tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration:
                            task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Created: ${task.createdAt.toLocal().toString().split('.')[0]}',
                          style: TextStyle(fontSize: 12),
                        ),
                        if (task.dueDate != null)
                          Text(
                            'Due: ${task.dueDate!.toLocal().toString().split('.')[0]}',
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                      ],
                    ),
                    trailing: Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) {
                        taskProvider.toggleTaskCompletion(task.id);
                      },
                    ),
                    onTap: () => _showEditTaskDialog(context, task),
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: Text('Delete Task'),
                              content: Text(
                                'Are you sure you want to delete this task?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    taskProvider.deleteTask(task.id);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  // Dialog to add a new task
  void _showAddTaskDialog(BuildContext context) {
    final taskTitleController = TextEditingController();
    DateTime? selectedDueDate;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              title: Text('Add Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: taskTitleController,
                    decoration: InputDecoration(labelText: 'Task Title'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        selectedDueDate == null
                            ? 'No Due Date'
                            : 'Due: ${selectedDueDate!.toLocal().toString().split('.')[0]}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setState(() {
                                selectedDueDate = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                              });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (taskTitleController.text.isNotEmpty) {
                      Provider.of<TaskProvider>(
                        context,
                        listen: false,
                      ).addTask(taskTitleController.text, selectedDueDate);
                      Navigator.of(ctx).pop();
                    }
                  },
                  child: Text('Add Task'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Dialog to edit an existing task
  void _showEditTaskDialog(BuildContext context, Task task) {
    final taskTitleController = TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: taskTitleController,
            decoration: InputDecoration(labelText: 'Task Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (taskTitleController.text.isNotEmpty) {
                  Provider.of<TaskProvider>(
                    context,
                    listen: false,
                  ).editTask(task.id, taskTitleController.text);
                  Navigator.of(ctx).pop();
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }
}
