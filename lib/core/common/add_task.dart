import 'package:Doozy/core/common/custom_buttons.dart';
import 'package:Doozy/core/common/custom_textfield.dart';
import 'package:Doozy/core/providers/task_provider.dart';
import 'package:Doozy/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> showAddTaskDialog(BuildContext context) async {
  final taskTitleController = TextEditingController();
  DateTime? selectedDueDate;

  showDialog(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return AlertDialog(
            backgroundColor: AppColors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Add Task',
              style: GoogleFonts.varelaRound(
                color: AppColors.yellow,
                fontSize: 20,
              ),
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      controller: taskTitleController,
                      hint: 'Task Title',
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          selectedDueDate == null
                              ? 'No Due Date'
                              : 'Due: ${selectedDueDate!.toLocal().toString().split('.')[0]}',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.yellow,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: AppColors.yellow,
                          ),
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: AppColors.blue,
                                      onPrimary: AppColors.yellow,
                                      onSurface: AppColors.blue,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppColors.yellow,
                                        backgroundColor: AppColors.blue,
                                      ),
                                    ),
                                    dialogBackgroundColor: AppColors.blue,
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (pickedDate != null) {
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: AppColors.blue,
                                        onPrimary: AppColors.yellow,
                                        onSurface: AppColors.yellow,
                                        surface: AppColors.blue,
                                        secondary: AppColors.yellow,
                                        onSecondary: AppColors.yellow,
                                        tertiary: AppColors.yellow,
                                        onTertiary: AppColors.yellow,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: AppColors.yellow,
                                          backgroundColor: AppColors.blue,
                                        ),
                                      ),
                                      dialogBackgroundColor: AppColors.blue,
                                      timePickerTheme: TimePickerThemeData(
                                        backgroundColor: AppColors.blue,
                                        // These are for the dial mode
                                        hourMinuteTextColor: AppColors.yellow,
                                        hourMinuteColor: AppColors.blue
                                            .withOpacity(0.3),
                                        dayPeriodTextColor: AppColors.yellow,
                                        dayPeriodColor: AppColors.blue
                                            .withOpacity(0.3),
                                        dialHandColor: AppColors.yellow,
                                        dialBackgroundColor: AppColors.blue
                                            .withOpacity(0.3),
                                        dialTextColor: AppColors.yellow,
                                        entryModeIconColor: AppColors.yellow,
                                        // For the input mode text fields
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                              fillColor: AppColors.blue,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.yellow,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.yellow,
                                                ),
                                              ),
                                              labelStyle: TextStyle(
                                                color: AppColors.yellow,
                                              ),
                                              hintStyle: TextStyle(
                                                color: AppColors.yellow,
                                              ),
                                            ),
                                        // Add these to specifically target hour/minute input text
                                        hourMinuteTextStyle: TextStyle(
                                          color: AppColors.yellow,
                                          fontSize: 30,
                                        ),
                                        dayPeriodTextStyle: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                      ),
                                      // This helps override the default text styles
                                      textSelectionTheme:
                                          TextSelectionThemeData(
                                            cursorColor: AppColors.yellow,
                                            selectionColor: AppColors.yellow
                                                .withOpacity(0.3),
                                            selectionHandleColor:
                                                AppColors.yellow,
                                          ),
                                      textTheme: TextTheme(
                                        // Override ALL text styles to ensure everything is yellow
                                        displayLarge: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        displayMedium: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        displaySmall: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        headlineLarge: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        headlineMedium: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        headlineSmall: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        titleLarge: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        titleMedium: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        titleSmall: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        bodyLarge: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        bodyMedium: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        bodySmall: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        labelLarge: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        labelMedium: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                        labelSmall: TextStyle(
                                          color: AppColors.yellow,
                                        ),
                                      ),
                                      // Add this to override the input decoration globally
                                      inputDecorationTheme:
                                          InputDecorationTheme(
                                            filled: true,
                                            fillColor: AppColors.blue,
                                            hoverColor: AppColors.blue,
                                            labelStyle: TextStyle(
                                              color: AppColors.yellow,
                                            ),
                                            hintStyle: TextStyle(
                                              color: AppColors.yellow
                                                  .withOpacity(0.7),
                                            ),
                                            helperStyle: TextStyle(
                                              color: AppColors.yellow,
                                            ),
                                            suffixStyle: TextStyle(
                                              color: AppColors.yellow,
                                            ),
                                            prefixStyle: TextStyle(
                                              color: AppColors.yellow,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.yellow,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.yellow,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                    ),
                                    child: child!,
                                  );
                                },
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
                    text: 'Add Task',
                    width: 136,
                    textSize: 13,
                    onpressed: () {
                      if (taskTitleController.text.isNotEmpty) {
                        Provider.of<TaskProvider>(
                          context,
                          listen: false,
                        ).addTask(taskTitleController.text, selectedDueDate);
                        Navigator.of(ctx).pop();
                      }
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
  );
}
