import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/empty.dart';
import 'package:todo_app/shared/home/cubit.dart';
import 'package:todo_app/widgets/common.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key key,
    @required this.maps,
  });
  final List<Map> maps;

  Widget build(BuildContext context) {
    return (maps == null)
        ? empty()
        : ListView.builder(
            itemCount: maps.length,
            itemBuilder: (context, index) =>
                buildTaskItem(maps[index], context));
  }
}
