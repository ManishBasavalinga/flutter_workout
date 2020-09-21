import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_workout/screens/home_screen.dart';
import 'package:flutter_workout/screens/settings_screen.dart';
import 'package:flutter_workout/screens/workout_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
        WorkoutScreen.routeName: (context) => WorkoutScreen(),
      },
    );
  }
}
