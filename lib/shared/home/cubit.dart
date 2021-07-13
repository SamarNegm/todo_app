import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/DataBase/database.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/archived.dart';
import 'package:todo_app/screens/done.dart';
import 'package:todo_app/screens/task.dart';
import 'package:todo_app/shared/home/states.dart';

class AppCupit extends Cubit<AppState> {
  AppCupit() : super(InitialState()) {
    myDB.createDatabase();
  }
  static AppCupit get(context) => BlocProvider.of(context);
  List pages = [Task(), Done(), Archived()];
  bool addIcon = true;
  int selectedPageIndex = 0;
  taskModel model = taskModel(title: '', data: '', time: '', status: '');
  MyDatabase myDB = MyDatabase();

  int changeButtomNavigationBar(int index) {
    selectedPageIndex = index;
    if (index == 0) {
      getFromDataBase();
    }
    emit(ChngeAppBar());
    return selectedPageIndex;
  }

  void chanegeFloatingActionButtonIcon() {
    addIcon = !addIcon;
    emit(chanegeFloatingActionButtonIconState());
  }

  void InsertToDataBase() {
    print(model.title +
        ' ' +
        model.data +
        ' ' +
        model.time +
        '&&&&&&&&&&&&&&&&&&');
    myDB.InsertToDatabase(model);
    emit(InsertToDataBaseState());
  }

  Future<taskModel> getFromDataBase() async {
    List<Map> maps = await myDB.GetDaTaFromDataBase();
    for (int i = 0; i < maps.length; i++) {
      print(taskModel.fromMap(maps[i]).title + '<<<<<');
    }
    if (maps.length > 0) {
      return taskModel.fromMap(maps.first);
    }
    return null;
  }

  void DeleteFromDataBase() {
    myDB.InsertToDatabase(model);
    emit(InsertToDataBaseState());
  }

  void UpdateDataBase() {
    myDB.InsertToDatabase(model);
    emit(InsertToDataBaseState());
  }
}
