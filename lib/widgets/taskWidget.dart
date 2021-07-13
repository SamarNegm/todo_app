import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key key,
    @required this.maps,
  }) : super(key: key);
  final List<Map> maps;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: maps.length,
      itemBuilder: (context, index) => ListTile(
        title: maps[index]['title'],
      ),
    );
  }
}
