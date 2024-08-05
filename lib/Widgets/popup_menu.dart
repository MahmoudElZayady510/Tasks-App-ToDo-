import 'package:flutter/material.dart';
import 'package:todo/models/taskModel.dart';

class myPopup extends StatelessWidget {
  final VoidCallback cancelOrDelete;
  final VoidCallback favOrUnfav;
  final VoidCallback editTask;
  final VoidCallback restoreTask;
  final Task task;
  const myPopup({
    required this.task,
    required this.cancelOrDelete,
    required this.favOrUnfav,
    required this.editTask,
    required this.restoreTask,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: task.isDeleted == false ?
            (context) => [
          PopupMenuItem(
              onTap: editTask,
              child: TextButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.edit),
                  label: Text('Edit'))),
          PopupMenuItem(
              child: TextButton.icon(
                  onPressed: null,
                  icon: task.isFavorite! ? Icon(Icons.bookmark_remove) : Icon(Icons.bookmark_add) ,
                  label:  Text(task.isFavorite! ? 'Remove From\nBookmarks' : 'Add to\nBookmarks')),
              onTap: favOrUnfav,
          ),
          PopupMenuItem(
              child: TextButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.delete),
                  label: Text('Delete')),
              onTap: cancelOrDelete,
          ),
        ] :
        (context) => [
          PopupMenuItem(
              onTap: restoreTask,
              child: TextButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.restore),
                  label: Text('Restore'))),
          PopupMenuItem(
              onTap: cancelOrDelete,
              child: TextButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.delete_forever),
                  label: Text('Delete Forever'))),
        ]
    );
  }
}