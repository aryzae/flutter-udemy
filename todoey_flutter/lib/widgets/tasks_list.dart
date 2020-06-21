import 'package:flutter/material.dart';
import 'package:todoeyflutter/models/task.dart';
import 'package:todoeyflutter/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  TasksList({this.tasks, this.checkboxCallback});

  final List<Task> tasks;
  final Function checkboxCallback;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskTile(
          taskTitle: tasks[index].name,
          isChecked: tasks[index].isDone,
          checkboxCallback: (newValue) {
            checkboxCallback(index);
          },
        );
      },
    );
  }
}
