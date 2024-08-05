import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';
import '../blocs/bloc_exports.dart';
import '../models/taskModel.dart';

// var uuid = Uuid();

class editTaskScreen extends StatelessWidget {
  final Task oldTask;
  const editTaskScreen({
    required this.oldTask,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController( text: oldTask.title);
    TextEditingController descriptionController = TextEditingController(text: oldTask.description);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Edit Task',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: titleController,
            autofocus: true,
            decoration: InputDecoration(
                label: Text('Title'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: descriptionController,
            autofocus: true,
            minLines: 3,
            maxLines: 5,
            decoration: InputDecoration(
                label: Text('Description'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  var editedTask = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    id: oldTask.id,
                    isDone: false,
                    isFavorite: oldTask.isFavorite,
                    date: DateTime.now().toString(),
                  );
                  context.read<TasksBloc>().add(editTask(oldTask: oldTask ,newTask: editedTask));
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
