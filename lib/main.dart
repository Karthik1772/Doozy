import 'package:Doozy/core/providers/task_provider.dart';
import 'package:Doozy/core/routes/generated_routes.dart';
import 'package:Doozy/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => TaskProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.lightTheme,
        onGenerateRoute: Routes.onGenerate,
        initialRoute: "/home",
      ),
    );
  }
}
