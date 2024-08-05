import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../blocs/bloc_exports.dart';
import '../models/taskModel.dart';

var uuid = Uuid();

class addTaskScreen extends StatelessWidget {
  const addTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Add Task',
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
                  var task = Task(
                      title: titleController.text,
                      description: descriptionController.text,
                      id: uuid.v4(),
                      date: DateTime.now().toString(),
                  );
                  context.read<TasksBloc>().add(addTask(task: task));
                  Navigator.pop(context);
                },
                child: Text('Add'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
