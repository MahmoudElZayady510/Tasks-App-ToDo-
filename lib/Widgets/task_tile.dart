import 'package:flutter/material.dart';
import 'package:todo/Screens/edit_task_screen.dart';
import 'package:todo/Widgets/popup_menu.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/models/taskModel.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  void _removeOrdeleteTask(BuildContext context, Task task) {
    task.isDeleted!
        ? context.read<TasksBloc>().add(deleteTask(task: task))
        : context.read<TasksBloc>().add(removeTask(task: task));
  }
  void _editTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, //trick
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: editTaskScreen(oldTask: task,),
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite! ? Icon(Icons.star_outlined , color: Colors.yellowAccent,) : Icon(Icons.star_outline) ,
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      Text(
                        DateFormat().add_yMMMd().add_Hms().format(DateTime.parse(task.date)),
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted!
                    ? null
                    : (value) =>
                        context.read<TasksBloc>().add(updateTask(task: task)),
              ),
              myPopup(
                cancelOrDelete: () => _removeOrdeleteTask(context, task),
                task: task,
                favOrUnfav: () => context.read<TasksBloc>().add(markFavUnfav(task: task)),
                editTask: () => _editTask(context),
                restoreTask: () => context.read<TasksBloc>().add(restoreTask(task: task)),
              ),
            ],
          )
        ],
      ),
    );
  }
}


// ListTile(
// title: Text(
// task.title,
// overflow: TextOverflow.ellipsis,
// style: TextStyle(
// decoration: task.isDone! ? TextDecoration.lineThrough : null,
// ),
// ),
// trailing: Checkbox(
// value: task.isDone,
// onChanged: task.isDeleted!
// ? null
//     : (value) => context.read<TasksBloc>().add(updateTask(task: task)),
// ),
// onLongPress: () => _removeOrdeleteTask(context, task),
// )
