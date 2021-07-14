import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/empty.dart';
import 'package:todo_app/shared/home/cubit.dart';

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
            itemBuilder: (context, index) => Dismissible(
              key: UniqueKey(),
              background: Container(
                  color: Colors.red,
                  child: const ListTile(
                      leading:
                          Icon(Icons.delete, color: Colors.white, size: 36.0))),
              onDismissed: (direction) async {
                await AppCupit.get(context)
                    .DeleteFromDataBase(maps[index]['id']);
              },
              child: Card(
                child: ListTile(
                  title: Text(maps[index]['title']),
                  tileColor: Colors.black12,
                  subtitle: Text(maps[index]['time']),
                ),
              ),
            ),
          );
  }
}
