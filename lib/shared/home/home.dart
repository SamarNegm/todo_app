import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/shared/home/cubit.dart';
import 'package:todo_app/shared/home/states.dart';
import 'package:todo_app/widgets/common.dart';

class Home extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
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
                  final controller = scaffoldKey.currentState
                      .showBottomSheet((context) => Container(
                          height: MediaQuery.of(context).size.height * .5,
                          child: Column(children: [
                            Text('New Task'),
                            Form(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultFormField(
                                    controller: titleController,
                                    type: TextInputType.text,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'title must not be empty';
                                      }

                                      return null;
                                    },
                                    label: 'Task Title',
                                    prefix: Icons.title,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                    controller: timeController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value.format(context).toString();
                                        print(value.format(context));
                                      });
                                    },
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'time must not be empty';
                                      }

                                      return null;
                                    },
                                    label: 'Task Time',
                                    prefix: Icons.watch_later_outlined,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                    controller: dateController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2080-05-03'),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value);
                                      });
                                    },
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'date must not be empty';
                                      }

                                      return null;
                                    },
                                    label: 'Task Date',
                                    prefix: Icons.calendar_today,
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  cubit.model = new taskModel(
                                      title: titleController.text,
                                      data: dateController.text,
                                      time: timeController.text,
                                      status: 'no');
                                  cubit.insertToDataBase();
                                },
                                child: Text('Save'))
                          ])));
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
