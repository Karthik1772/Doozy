import 'package:Doozy/core/common/add_task.dart';
import 'package:Doozy/core/common/custom_buttons.dart';
import 'package:Doozy/core/common/edit_task.dart';
import 'package:Doozy/core/providers/task_provider.dart';
import 'package:Doozy/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Task Manager', style: GoogleFonts.varelaRound()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(90)),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (ctx, index) {
                  final task = taskProvider.tasks[index];
                  return Card(
                    color: AppColors.white,
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: ListTile(
                      title: Text(
                        task.title,
                        style: GoogleFonts.workSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blue,
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
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppColors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          if (task.dueDate != null)
                            Text(
                              'Due: ${DateFormat('yyyy-MM-dd    HH:mm').format(task.dueDate!)}',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppColors.red,
                              ),
                            ),
                        ],
                      ),
                      trailing: Checkbox(
                        activeColor: AppColors.blue,
                        checkColor: AppColors.yellow,
                        side: BorderSide(color: AppColors.blue, width: 2),
                        value: task.isCompleted,
                        onChanged: (_) {
                          taskProvider.toggleTaskCompletion(task.id);
                        },
                      ),
                      onTap: () => showEditTaskDialog(context, task),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              backgroundColor: AppColors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: Text(
                                'Delete Task',
                                style: GoogleFonts.varelaRound(
                                  color: AppColors.yellow,
                                  fontSize: 20,
                                ),
                              ),
                              content: Text(
                                'Are you sure you want to delete this task?',
                                style: GoogleFonts.poppins(
                                  color: AppColors.white,
                                  fontSize: 15,
                                ),
                              ),
                              actionsPadding: EdgeInsets.only(bottom: 10),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomButtons(
                                      textSize: 13,
                                      text: "Cancel",
                                      width: 91,
                                      onpressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                    ),
                                    CustomButtons(
                                      text: 'Delete',
                                      width: 91,
                                      textSize: 13,
                                      onpressed: () {
                                        Provider.of<TaskProvider>(
                                          context,
                                          listen: false,
                                        ).deleteTask(task.id);
                                        Navigator.of(ctx).pop();
                                      },
                                    ),
                                    SizedBox(height: 50),
                                  ],
                                ),
                              ],
                            );
                          },
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
          backgroundColor: AppColors.blue,
          onPressed: () => showAddTaskDialog(context),
          child: Icon(Icons.add, color: AppColors.yellow, size: 30),
        ),
      ),
    );
  }
}
