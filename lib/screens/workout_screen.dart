import 'package:flutter/material.dart';
import 'package:flutter_workout/data/data.dart';
import 'package:flutter_workout/screens/home_screen.dart';

class WorkoutScreen extends StatefulWidget {
  static const routeName = '/workout';

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  String name;
  int id, sets, reps, index = 0;
  List repsList = [];

  List<String> getWorkout() {
    sets = WorkoutData.setsAndRepsList[id]['sets'];
    reps = WorkoutData.setsAndRepsList[id]['reps'];
    switch (id) {
      case 0:
        name = 'Power and Strength';
        return WorkoutData.powerAndStrength;
      case 1:
        name = 'Hypertrophy';
        return WorkoutData.hypertrophy;
      case 2:
        name = 'Core';
        return WorkoutData.core;
      case 3:
        name = 'Conditioning';
        return WorkoutData.conditioning;
      default:
        return [];
    }
  }

  List<Widget> renderList() {
    List<Widget> list = [];
    for (var i = 0; i < sets; i++) {
      repsList.add({
        'isHighlighted': i == 0 ? true : false,
      });
      list.add(Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              repsList[i]['isHighlighted'] ? Colors.amberAccent : Colors.white,
        ),
        child: Center(
          child: Text(
            '${i + 1}',
            textAlign: TextAlign.center,
            style: TextStyle(
                color:
                    repsList[i]['isHighlighted'] ? Colors.white : Colors.black),
          ),
        ),
      ));
    }
    list.add(
      IconButton(
        icon: Icon(
          Icons.chevron_right,
        ),
        onPressed: () {
          setState(() {
            if (index < (sets - 1)) {
              repsList[index]['isHighlighted'] = false;
              repsList[index + 1]['isHighlighted'] = true;
              index += 1;
            } else if (id < 3) {
              Navigator.of(context).popAndPushNamed(
                WorkoutScreen.routeName,
                arguments: {'id': (id + 1)},
              );
            } else {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            }
          });
        },
      ),
    );
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    id = (args['id']);
    List<String> workouts = getWorkout();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$name Complex',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(workouts[index]),
                        Text('x ${reps.toString()}'),
                      ],
                    ),
                  ),
                );
              },
              itemCount: workouts.length,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: renderList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
