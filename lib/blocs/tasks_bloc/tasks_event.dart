part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();
}
class addTask extends TasksEvent{
  final Task task;
  const addTask({
    required this.task,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class updateTask extends TasksEvent{
  final Task task;
  const updateTask({
    required this.task,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class removeTask extends TasksEvent {
  final Task task;
  const removeTask({
    required this.task,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class deleteTask extends TasksEvent{
  final Task task;
  const deleteTask({
    required this.task,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}
class markFavUnfav extends TasksEvent{
  final Task task;
  const markFavUnfav({
    required this.task,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}
class editTask extends TasksEvent{
  final Task newTask;
  final Task oldTask;
  const editTask({
    required this.newTask,
    required this.oldTask,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [newTask, oldTask];
}
class restoreTask extends TasksEvent{
  final Task task;
  const restoreTask({
    required this.task,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}
class cleanBin extends TasksEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}