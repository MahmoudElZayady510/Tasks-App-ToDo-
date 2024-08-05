import 'package:flutter/material.dart';
import 'package:todo/Screens/completed_tasks.dart';
import 'package:todo/Screens/favorite_tasks.dart';
import 'package:todo/Screens/pending_tasks.dart';
import 'package:todo/Screens/drawer.dart';

import 'Add_Tasks_Screen.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({super.key});

  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': PendingTasksScreen(), 'title': 'Pending Tasks'},
    {'pageName': CompletedTasksScreen(), 'title': 'Completed Tasks'},
    {'pageName': FavoriteTasksScreen(), 'title': 'Favorite Tasks'},
  ];

  var _selectedPage = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, //trick
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: addTaskScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetails[_selectedPage]['title']),
        actions: [
          IconButton(onPressed: () => _addTask(context), icon: Icon(Icons.add))
        ],
      ),
      body: _pageDetails[_selectedPage]['pageName'],
      drawer: myDrawer(),
      floatingActionButton: _selectedPage == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle), label: 'Pending Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all), label: 'Completed Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite Tasks'),
        ],
      ),
    );
  }
}
