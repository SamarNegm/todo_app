import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/shared/home/cubit.dart';
import 'package:todo_app/shared/home/states.dart';

class Home extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCupit()..createDatabase(),
      child: BlocConsumer<AppCupit, AppState>(
        listener: (context, AppState state) {},
        builder: (context, state) {
          var cubit = AppCupit.get(context);
          print(state.toString() + '<<<<<<<<<<<<<<<<<<');

          return Scaffold(
            key: scaffoldKey,
            body: cubit.pages[cubit.selectedPageIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (!cubit.addIcon) {
                  Navigator.pop(context);
                }
                if (cubit.addIcon) {
                  final controller = scaffoldKey.currentState.showBottomSheet(
                    (context) => Container(
                      height: MediaQuery.of(context).size.height * .5,
                      child: Column(
                        children: [
                          Text('New Task'),
                          Form(
                              child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Task Title',
                                    prefixIcon: Icon(Icons.title)),
                                onFieldSubmitted: (value) {
                                  cubit.model.title = value;
                                },
                              ),
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        MediaQuery.of(context).size * .1),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue)),
                                onPressed: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    print(value.toString());
                                    cubit.model.time = value.toString();
                                  });
                                },
                                label: Text('Task Time'),
                                icon: Icon(Icons.access_time),
                              ),
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        MediaQuery.of(context).size * .1),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue)),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2080),
                                  ).then((value) {
                                    // var date =
                                    //     DateFormat.yMMMd(value).toString();
                                    cubit.model.data = value.toString();
                                  });
                                },
                                label: Text('Task Date'),
                                icon: Icon(Icons.calendar_today),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    cubit.insertToDataBase();
                                  },
                                  child: Text('Done'))
                            ],
                          )),
                        ],
                      ),
                    ),
                  );
                  controller.closed.then((value) {
                    cubit.chanegeFloatingActionButtonIcon();
                  });
                }
                if (cubit.addIcon) cubit.chanegeFloatingActionButtonIcon();

                //   cubit.InsertToDataBase();
              },
              child: Icon(cubit.addIcon ? Icons.add : Icons.edit),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeButtomNavigationBar(index);
              },
              currentIndex: cubit.selectedPageIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archive'),
              ],
            ),
          );
        },
      ),
    );
  }
}
