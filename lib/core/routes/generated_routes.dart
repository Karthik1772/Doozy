import 'package:Doozy/features/homepage.dart';
import 'package:Doozy/features/splash/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case "/home":
        return MaterialPageRoute(builder: (context) => HomePage());
      case "/splash":
      return MaterialPageRoute(builder: (context) => SplashScreen());
    }
    return null;
  }
}
