import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/empty.dart';
import 'package:todo_app/shared/home/cubit.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    Key key,
    @required this.maps,
  }) : super(key: key);
  final List<Map> maps;

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return (widget.maps == null)
        ? empty()
        : ListView.builder(
            itemCount: widget.maps.length,
            itemBuilder: (context, index) => Dismissible(
              key: UniqueKey(),
              background: Container(
                  color: Colors.red,
                  child: const ListTile(
                      leading:
                          Icon(Icons.delete, color: Colors.white, size: 36.0))),
              onDismissed: (direction) async {
                await AppCupit.get(context)
                    .DeleteFromDataBase(widget.maps[index]['id']);
              },
              child: Card(
                child: ListTile(
                  title: Text(widget.maps[index]['title']),
                ),
              ),
            ),
          );
  }
}
