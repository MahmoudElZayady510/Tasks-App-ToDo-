import 'package:flutter/material.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/models/taskModel.dart';

import 'task_tile.dart';

class tasksList extends StatelessWidget {
  const tasksList({
    super.key,
    required this.TasksList,
  });

  final List<Task> TasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: TasksList.map((task) => ExpansionPanelRadio(
              value: task.id,
              headerBuilder: (context, isOpen) => TaskTile(
                    task: task,
                  ),
              body: ListTile(
                title: SelectableText.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Title\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: task.title),
                  TextSpan(
                      text: '\n\nDescription\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${task.description}\n'),
                ])),
              ))).toList(),
        ),
      ),
    );
    // return Expanded(
    //   child: ListView.builder(
    //       itemCount: TasksList.length,
    //       itemBuilder: (context , index){
    //         var task = TasksList[index];
    //         return TaskTile(task: task);
    //       }
    //   ),
    // );
  }
}
