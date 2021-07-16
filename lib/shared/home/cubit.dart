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
    getFromDataBase();

    emit(ChngeAppBar());
    return selectedPageIndex;
  }

  void chanegeFloatingActionButtonIcon() {
    addIcon = !addIcon;
    emit(chanegeFloatingActionButtonIconState());
  }

  void createDatabase() {
    myDB.createDatabase().then((value) {
      getFromDataBase();
      emit(CreateDataBaseState());
      print('nooo');
    });
  }

  void insertToDataBase() {
    myDB.InsertToDatabase(model);
    //getFromDataBase();
    emit(InsertToDataBaseState());
    getFromDataBase();
  }

  Future<List<Map>> getFromDataBase() async {
    emit(AppGetDatabaseLoadingState());
    await myDB.GetDaTaFromDataBase('no').then((value) {
      newTasks = value;
    }).catchError((Error) {
      print(Error);
    });
    await myDB.GetDaTaFromDataBase('done').then((value) {
      doneTasks = value;
    });
    await myDB.GetDaTaFromDataBase('archive').then((value) {
      archivedTasks = value;
    });
    emit(AppGetDatabaseingState());

    return newTasks;
  }

  Future<void> DeleteFromDataBase(int id) async {
    await myDB.DeleteFromDataBase(id);
    emit(AppGetDatabaseLoadingState());
    getFromDataBase();
    emit(DeleteDataBaseState());
  }

  Future<void> updateDataBase({String state, int id}) async {
    print(state);
    await myDB.UpDateDataBase(state: state, id: id);
    getFromDataBase();
    emit(UpdateDataBaseState());
  }
}
