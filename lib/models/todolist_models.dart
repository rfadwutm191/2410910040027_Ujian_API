import 'dart:convert';

class TodosModel {
  final int id;
  final String todo;
  final bool completed;
  final int userId;
  TodosModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  TodosModel copyWith({
    int? id,
    String? todo,
    bool? completed,
    int? userId,
  }) {
    return TodosModel(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  factory TodosModel.fromMap(Map<String, dynamic> map) {
    return TodosModel(
      id: map['id']?.toInt() ?? 0,
      todo: map['todo'] ?? '',
      completed: map['completed'] ?? false,
      userId: map['userId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodosModel.fromJson(String source) => TodosModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodosModel(id: $id, todo: $todo, completed: $completed, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TodosModel &&
      other.id == id &&
      other.todo == todo &&
      other.completed == completed &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      todo.hashCode ^
      completed.hashCode ^
      userId.hashCode;
  }
}