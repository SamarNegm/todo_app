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
    print(index);
    if (index == 0) getFromDataBase('no');
    if (index == 1) getFromDataBase('done');
    if (index == 2) getFromDataBase('archive');

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
      print('nooo');
      getFromDataBase('no');
    });
  }

  void insertToDataBase() {
    myDB.InsertToDatabase(model);
    //getFromDataBase();
    emit(InsertToDataBaseState());
    getFromDataBase(model.status);
  }

  List<Map> getFromDataBase(String state) {
    emit(AppGetDatabaseLoadingState());
    print('loading>>' + state);
    myDB.GetDaTaFromDataBase(state).then((value) {
      if (state == 'no')
        newTasks = value;
      else if (state == 'done')
        doneTasks = value;
      else if (state == 'archive') archivedTasks = value;
    });
    print('done');

    emit(AppGetDatabaseingState());
    // for (int i = 0; i < maps.length; i++) {
    //   print(taskModel.fromMap(maps[i]).title + '<<<<<');
    // }

    return newTasks;
  }

  Future<void> DeleteFromDataBase(int id) async {
    newTasks = await myDB.DeleteFromDataBase(id);
    emit(DeleteDataBaseState());
  }

  void UpdateDataBase({String state, int id}) {
    myDB.UpDateDataBase(state: state, id: id);
    emit(UpdateDataBaseState());
  }
}
