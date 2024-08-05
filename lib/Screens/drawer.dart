import 'package:flutter/material.dart';
import 'package:todo/Screens/pending_tasks.dart';
import 'package:todo/Screens/recycle_bin.dart';
import 'package:todo/Screens/tabs_screen.dart';

import '../blocs/bloc_exports.dart';

class myDrawer extends StatelessWidget {
  const myDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              width: double.infinity,
              color: Colors.grey,
              child: Text(
                'Task Drawer',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(
                          TabsScreen.id),
                  child: ListTile(
                    leading: Icon(Icons.folder_special),
                    title: Text('My Tasks'),
                    trailing: Text('${state.pendingTasks.length} | ${state.completedTasks.length} '),
                  ),
                );
              },
            ),
            Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(RecycleBin.id),
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Bin'),
                    trailing: Text('${state.removedTasks.length} Tasks'),
                  ),
                );
              },
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Switch(value: state.switchValue,
                    onChanged: (newValue) {
                  newValue ? context.read<SwitchBloc>().add(SwitchOn())
                      :
                      context.read<SwitchBloc>().add(SwitchOff());
                    }
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
