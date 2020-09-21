import 'package:sqflite/sqflite.dart';

class WorkoutData {
  static Database _database;
  static List<Map> setsAndRepsList;
  static final List<String> powerAndStrength = [
    'Dumbell Cleans',
    'Push Press',
    'Dumbell Front Squats',
  ];
  static final List<String> hypertrophy = [
    'Dumbell Crush Press',
    'Bent Over Rows',
    'Reverse Lunge Left',
    'Reverse Lunge Right',
  ];
  static final List<String> core = [
    'Dumbell Snatch',
    'Farmer\'s Carry',
    'Get-Up Sit-Ups',
    'Renegade Rows',
  ];
  static final List<String> conditioning = [
    'Split Stance Hammer Curls',
    'Split Stance Shoulder Press',
    'Split Switch',
    'Squat Curl To Press',
  ];

  static setData() async {
    var path = await getDatabasesPath() + '/data.db';

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Data (id INTEGER PRIMARY KEY, name TEXT, sets INTEGER, reps INTEGER)');
    });

    await _database.transaction((txn) async {
      setsAndRepsList = await txn.rawQuery('SELECT * FROM Data');
      if (setsAndRepsList.isEmpty) {
        final List<List<String>> initialData = [
          [
            'Power and Strength',
            '5',
            '3',
          ],
          [
            'Hypertrophy',
            '4',
            '10',
          ],
          [
            'Core',
            '2',
            '10',
          ],
          [
            'Conditioning',
            '2',
            '10',
          ],
        ];

        initialData.forEach((element) async {
          await txn.rawInsert(
            'INSERT INTO Data(name, sets, reps) VALUES(?, ?, ?)',
            [
              element[0],
              int.parse(element[1]),
              int.parse(element[2]),
            ],
          );
        });
        setsAndRepsList = await txn.rawQuery('SELECT * FROM Data');
      }
    });
  }

  static updateData(List recivedList) async {
    _database.transaction((txn) async {
      for (var i = 0; i < 4; i++) {
        await txn.rawUpdate(
          'UPDATE Data SET sets = ?, reps = ? WHERE id = ?',
          ['${recivedList[2 * i]}', '${recivedList[2 * i + 1]}', '${i + 1}'],
        );
      }
      setsAndRepsList = await txn.rawQuery('SELECT * FROM Data');
    });
  }
}
