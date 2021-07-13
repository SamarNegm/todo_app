import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/empty.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key key,
    @required this.maps,
  }) : super(key: key);
  final List<Map> maps;
  @override
  Widget build(BuildContext context) {
    return (maps == null)
        ? empty()
        : ListView.builder(
            itemCount: maps.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(maps[index]['title']),
            ),
          );
  }
}
