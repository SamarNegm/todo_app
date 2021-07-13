import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/DataBase/database.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/archived.dart';
import 'package:todo_app/screens/done.dart';
import 'package:todo_app/screens/task.dart';
import 'package:todo_app/shared/home/states.dart';

class AppCupit extends Cubit<AppState> {
  AppCupit() : super(InitialState());
  static AppCupit get(context) => BlocProvider.of(context);
  List pages = [Task(), Done(), Archived()];
  bool addIcon = true;
  int selectedPageIndex = 0;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  taskModel model = taskModel(title: '', data: '', time: '', status: '');
  MyDatabase myDB = MyDatabase();

  int changeButtomNavigationBar(int index) {
    selectedPageIndex = index;

    emit(ChngeAppBar());
    return selectedPageIndex;
  }

  void chanegeFloatingActionButtonIcon() {
    addIcon = !addIcon;
    emit(chanegeFloatingActionButtonIconState());
  }

  void createDatabase() {
    myDB.createDatabase().then((value) {
      emit(CreateDataBaseState());
      getFromDataBase();
    });
  }

  void InsertToDataBase() {
    myDB.InsertToDatabase(model);
    //getFromDataBase();
    emit(InsertToDataBaseState());
    getFromDataBase();
  }

  List<Map> getFromDataBase() {
    emit(AppGetDatabaseLoadingState());
    print('loading');
    myDB.GetDaTaFromDataBase().then((value) => newTasks = value);
    print('done');

    emit(AppGetDatabaseingState());
    // for (int i = 0; i < maps.length; i++) {
    //   print(taskModel.fromMap(maps[i]).title + '<<<<<');
    // }

    return newTasks;
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
