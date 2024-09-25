import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: Text('Task Manager'),
      ),
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
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null, // Strikethrough for completed tasks
                      ),
                    ),
                    trailing: Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) {
                        taskProvider.toggleTaskCompletion(task.id);
                      },
                    ),
                    onTap: () => _showEditTaskDialog(context, task),
                    onLongPress: () => taskProvider.deleteTask(task.id),
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

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Add Task'),
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
                  Provider.of<TaskProvider>(context, listen: false)
                      .addTask(taskTitleController.text);
                  Navigator.of(ctx).pop();
                }
              },
              child: Text('Add Task'),
            ),
          ],
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
                  Provider.of<TaskProvider>(context, listen: false)
                      .editTask(task.id, taskTitleController.text);
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
