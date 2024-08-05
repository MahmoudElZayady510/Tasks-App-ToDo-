import 'package:flutter/material.dart';
import '../blocs/bloc_exports.dart';
import '../Widgets/tasks_list.dart';
import 'drawer.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});

  static const id = 'recycle_bin';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Bin'),
            actions: [
              PopupMenuButton(itemBuilder: (context) => [
                PopupMenuItem(
                    child: TextButton.icon(
                    onPressed: null, 
                    icon: Icon(Icons.delete_sweep_sharp), 
                    label: Text('Delete All')),
                  onTap: () => context.read<TasksBloc>().add(cleanBin()),
                ),
              ])
            ],
          ),
          drawer: myDrawer(),
          body: Column(
            children: [
              Center(
                child: Chip( //new widget
                  label: Text('${state.removedTasks.length} Tasks'),
                ),
              ),
              tasksList(TasksList: state.removedTasks),
            ],
          ),
        );
      },
    );
  }
}
