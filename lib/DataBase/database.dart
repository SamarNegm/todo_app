import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task_model.dart';

class MyDatabase {
  Database db;
  Future<void> createDatabase() async {
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
        print('database opened^ getede');
      },
    );
  }

  void InsertToDatabase(taskModel model) {
    db.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES ("${model.title}","${model.data}","${model.time}","${model.status}")')
          .then((value) {
        print('inserted ' +
            value.toString() +
            '  ' +
            model.title +
            ' ' +
            model.data +
            ' ' +
            model.time +
            '  ' +
            model.status);
      }).catchError((error) {
        print(error.toString());
      });
    });
  }

  Future<List<Map>> GetDaTaFromDataBase(String state) async {
    print('getting data>>' + state);
    List<Map> list;
    var value =
        await db.rawQuery('SELECT * FROM tasks WHERE status =? ', [state]);
    print('doneeeeee 1>>>' + value.toString());

    list = value;

    print('data ' + list.toString());
    return list;
  }

  Future<void> UpDateDataBase({String state, int id}) async {
    await db.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [state, id]);
  }

  Future<List<Map>> DeleteFromDataBase(int id) async {
    await db.rawDelete('DELETE FROM tasks WHERE id = ?', [id]);
    List<Map> list = await db.rawQuery('SELECT * FROM tasks');
    return list;
  }
}
