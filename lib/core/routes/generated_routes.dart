import 'package:Doozy/features/task_list_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case "/home":
        return MaterialPageRoute(builder: (context) => TaskListScreen());
      case "/splash":
      // return MaterialPageRoute(builder: (context) => Splash());
    }
    return null;
  }
}
