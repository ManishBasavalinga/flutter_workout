import 'package:flutter/material.dart';
import 'package:flutter_workout/data/data.dart';
import 'package:flutter_workout/screens/workout_screen.dart';
import 'package:flutter_workout/widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget customizedButton(BuildContext context, String name, int id) {
    return Container(
      padding: EdgeInsets.all(
        10.0,
      ),
      width: double.infinity,
      height: 69,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30.0,
          ),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () => Navigator.of(context).pushNamed(
          WorkoutScreen.routeName,
          arguments: {'id': id},
        ),
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    WorkoutData.setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Workout',
        ),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customizedButton(context, 'Power and Strength', 0),
            customizedButton(context, 'Hypertrophy', 1),
            customizedButton(context, 'Core', 2),
            customizedButton(context, 'Conditioning', 3),
          ],
        ),
      ),
    );
  }
}
