import 'dart:convert';
import 'dart:math';

import '../bloc_exports.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/models/taskModel.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState()) {
    on<addTask>(_onAddTask);
    on<updateTask>(_onUpdateTask);
    on<deleteTask>(_onDeleteTask);
    on<removeTask>(_onRemoveTask);
    on<markFavUnfav>(_onMarkFavUnfav);
    on<editTask>(_onEditTask);
    on<restoreTask>(_onRestoreTask);
    on<cleanBin>(_onCleanBin);
    // on<clearAll>(_onClearAll);
  }

  void _onAddTask(addTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: state.removedTasks));
        // pendingTasks: [],
        // completedTasks: [],
        // favoriteTasks: [],
        // removedTasks: []
    // ));
  }

  void _onUpdateTask(updateTask event, Emitter<TasksState> emitter) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (task.isDone == false) {
      if (task.isFavorite == false) {
        completedTasks = List.from(state.completedTasks)
          ..insert(0, task.copyWith(isDone: true));
        pendingTasks = List.from(state.pendingTasks)..remove(task);
      } else {
        var taskIndex = favoriteTasks.indexOf(task);
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: true));
        completedTasks = List.from(state.completedTasks)
          ..insert(0, task.copyWith(isDone: true));
        pendingTasks = List.from(state.pendingTasks)..remove(task);
      }
    } else {
      if (task.isFavorite == false) {
        completedTasks = List.from(state.completedTasks)..remove(task);
        pendingTasks = List.from(state.pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
      } else {
        var taskIndex = favoriteTasks.indexOf(task);
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: false));
        completedTasks = List.from(state.completedTasks)..remove(task);
        pendingTasks = List.from(state.pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
      }
    }
    // task.isDone == false
    //     ? {
    //         completedTasks = List.from(state.completedTasks)
    //           ..insert(0, task.copyWith(isDone: true)),
    //         pendingTasks = List.from(state.pendingTasks)..remove(task)
    //       }
    //     : {
    //         completedTasks = List.from(state.completedTasks)..remove(task),
    //         pendingTasks = List.from(state.pendingTasks)
    //           ..insert(0, task.copyWith(isDone: false))
    //       };
    emit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks));
  }

  void _onDeleteTask(deleteTask event, Emitter<TasksState> emitter) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task)));
  }

  void _onRemoveTask(removeTask event, Emitter<TasksState> emitter) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isDeleted: true))));
  }

  void _onMarkFavUnfav(markFavUnfav event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
        print(event.task.isFavorite);
        print(event.task.title);
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
        print(event.task.isFavorite);
        print(event.task.title);
      }
    } else {
      if (event.task.isFavorite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
        print(event.task.isFavorite);
        print(event.task.title);
      } else {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
        print(event.task.isFavorite);
        print(event.task.title);
      }
    }
    emit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks));
  }

  void _onEditTask(editTask event, Emitter<TasksState> emitter) {
    final state = this.state;
    List<Task> favoriteTask = state.favoriteTasks;
    if (event.oldTask == true) {
      favoriteTask = List.from(favoriteTask)
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTasks: List.from(state.completedTasks)..remove(event.oldTask),
        favoriteTasks: favoriteTask,
        removedTasks: state.removedTasks));
  }

  void _onRestoreTask(restoreTask event, Emitter<TasksState> emitter) {
    final state = this.state;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.task.isFavorite == true) {
      favoriteTasks = List.from(favoriteTasks)..add(event.task);
    }
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..insert(0, event.task),
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        completedTasks: state.completedTasks,
        favoriteTasks: favoriteTasks));
  }
  void _onCleanBin (cleanBin event, Emitter<TasksState> emitter){
    final state = this.state;
    emit(TasksState(
      pendingTasks: state.pendingTasks,
      removedTasks: [],
      favoriteTasks: state.favoriteTasks,
      completedTasks: state.completedTasks
    ));
  }

  // void _onClearAll(restoreTask event, Emitter<TasksState> emitter){
  //   emit(TasksState(
  //     pendingTasks: [],
  //     favoriteTasks: [],
  //
  //   ))
  // }
  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
