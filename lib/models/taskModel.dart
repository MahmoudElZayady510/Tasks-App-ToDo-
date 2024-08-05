import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String title;
  final String id;
  final String date;

  String? description;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;

  Task({
    required this.title,
    required this.date,
    this.description,
    required this.id,
    this.isDone,
    this.isDeleted,
    this.isFavorite,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavorite = isFavorite ?? false;
    description = description ?? '';
  }

  Task copyWith({
    String? title,
    String? date,
    String? description,
    String? id,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return Task(
      title: title ?? this.title,
      date: title ?? this.date,
      description: title ?? this.description,
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'date': this.date,
      'description': this.description,
      'id': this.id,
      'isDone': this.isDone,
      'isDeleted': this.isDeleted,
      'isFavorite': this.isFavorite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      description: map['description'] ?? '',
      id: map['id'] ?? '',
      isDone: map['isDone'] ?? '',
      isDeleted: map['isDeleted'] ?? '',
      isFavorite: map['isFavorite'] ?? '',
      // title: map['title'] as String,
      // isDone: map['isDone'] as bool,
      // isDeleted: map['isDeleted'] as bool,
    );
  }

  @override
  List<Object?> get props => [title,date ,description, id ,isDone , isDeleted,isFavorite ];
}
