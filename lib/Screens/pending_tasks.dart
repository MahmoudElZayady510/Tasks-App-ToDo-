import 'package:flutter/material.dart';
import 'package:todo/Widgets/tasks_list.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/models/taskModel.dart';
class PendingTasksScreen extends StatelessWidget {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> Tasks = state.pendingTasks;
        return Column(
          children: [
            Center(
              child: Chip(
                //new widget
                label: Text('${state.pendingTasks.length} Pending | ${state.completedTasks.length} Completed'),
              ),
            ),
            tasksList(TasksList: Tasks),
          ],
        );
      },
    );
  }
}
