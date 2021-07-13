import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task_model.dart';

class MyDatabase {
  Database db;
  createDatabase() async {
    db = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        print('database created');
        db
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT, status TEXT)')
            .then((value) => print('table created'))
            .onError((error, stackTrace) => print(error.toString()));
      },
      onOpen: (db) {
        print('database opened');
      },
    );
  }

  void InsertToDatabase(taskModel model) {
    db.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES ("${model.title}","${model.data}","${model.time}","done")')
          .then((value) {
        print('inserted ' +
            value.toString() +
            '  ' +
            model.title +
            ' ' +
            model.data +
            ' ' +
            model.time);
      }).catchError((error) {
        print(error.toString());
      });
    });
  }

  List<Map> GetDaTaFromDataBase() {
    List<Map> list;
    db.rawQuery('SELECT * FROM tasks').then((value) {
      list = value;
    });
    return list;
  }

  void UpDateDataBase() {}
  void DeleteFromDataBase() {}
}
