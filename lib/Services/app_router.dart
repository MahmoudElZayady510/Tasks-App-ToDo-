import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/Screens/pending_tasks.dart';
import 'package:todo/Screens/recycle_bin.dart';

import '../Screens/tabs_screen.dart';

class AppRouter{
  Route? OnGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case TabsScreen.id:
        return MaterialPageRoute(builder: (builder) => TabsScreen());
      case RecycleBin.id:
        return MaterialPageRoute(builder: (builder) => RecycleBin());
      default:
        return null;
    }
  }
}