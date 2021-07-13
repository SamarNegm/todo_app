import 'package:flutter/material.dart';
import 'package:todo_app/shared/home/cubit.dart';
import 'package:todo_app/shared/home/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/widgets/taskWidget.dart';

class Task extends StatelessWidget {
  const Task({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCupit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var tasks = AppCupit.get(context).newTasks;

        return state == AppGetDatabaseLoadingState()
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TaskWidget(maps: tasks);
      },
    );
  }
}
