import 'package:flutter/material.dart';
import 'package:flutter_workout/screens/home_screen.dart';
import 'package:flutter_workout/screens/settings_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(HomeScreen.routeName),
          ),
          Divider(),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(SettingsScreen.routeName),
          ),
        ],
      ),
    );
  }
}
