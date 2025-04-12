import 'package:Doozy/core/common/custom_buttons.dart';
import 'package:Doozy/core/common/custom_textfield.dart';
import 'package:Doozy/core/models/task.dart';
import 'package:Doozy/core/providers/task_provider.dart';
import 'package:Doozy/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> showEditTaskDialog(BuildContext context, Task task) async {
  final taskTitleController = TextEditingController(text: task.title);

  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: AppColors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Edit Task',
          style: GoogleFonts.varelaRound(color: AppColors.yellow),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: CustomTextField(
              controller: taskTitleController,
              hint: 'Task Title',
              keyboardType: TextInputType.name,
            ),
          ),
        ),
        actionsPadding: EdgeInsets.only(bottom: 10),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                text: 'Save Changes',
                width: 136,
                onpressed: () {
                  if (taskTitleController.text.isNotEmpty) {
                    Provider.of<TaskProvider>(
                      context,
                      listen: false,
                    ).editTask(task.id, taskTitleController.text);
                    Navigator.of(ctx).pop();
                  }
                },
                textSize: 13,
              ),
              SizedBox(height: 50),
            ],
          ),
        ],
      );
    },
  );
}