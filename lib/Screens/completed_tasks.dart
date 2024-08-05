import 'package:flutter/material.dart';
import 'package:todo/Widgets/tasks_list.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/models/taskModel.dart';

class CompletedTasksScreen extends StatelessWidget {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> Tasks = state.completedTasks;
        return Column(
          children: [
            Center(
              child: Chip(
                //new widget
                label: Text('${state.completedTasks.length} Tasks'),
              ),
            ),
            tasksList(TasksList: Tasks),
          ],
        );
      },
    );
  }
}
