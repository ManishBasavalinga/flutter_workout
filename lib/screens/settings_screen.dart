import 'package:flutter/material.dart';
import 'package:flutter_workout/data/data.dart';
import 'package:flutter_workout/widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List setsAndRepsList;
  List finalSetsAndRepsList;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    setsAndRepsList = WorkoutData.setsAndRepsList;
    super.initState();
  }

  Widget customizedTextFormField(String value, String tag) {
    return Flexible(
      child: Container(
        width: 100,
        child: TextFormField(
          initialValue: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: tag,
          ),
          keyboardType: TextInputType.number,
          onSaved: (String value) {
            finalSetsAndRepsList.add(value);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            setsAndRepsList[index]['name'],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            customizedTextFormField(
                              setsAndRepsList[index]['sets'].toString(),
                              'Sets',
                            ),
                            customizedTextFormField(
                              setsAndRepsList[index]['reps'].toString(),
                              'Reps',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: setsAndRepsList.length,
              ),
              RaisedButton(
                onPressed: () {
                  finalSetsAndRepsList = [];
                  _formKey.currentState.save();
                  WorkoutData.updateData(finalSetsAndRepsList);
                  setsAndRepsList = finalSetsAndRepsList;
                  final snackBar = SnackBar(
                    content: Text('Changes Updated'),
                  );
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
