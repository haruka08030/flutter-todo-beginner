import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

const _uuid = Uuid();

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    required DateTime createdAt,
    @Default(false) bool completed,
  }) = _Todo;

  const Todo._();

  @override
  String toString() {
    return 'Todo(title: $title, completed: $completed, createdAt: $createdAt)';
  }
}

class TodoList extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => [
        Todo(id: 'todo-0', title: 'Buy cookies', createdAt: DateTime.now()),
      ];

  void add(String title) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        title: title,
        createdAt: DateTime.now(),
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            title: todo.title,
            createdAt: todo.createdAt,
          )
        else
          todo,
    ];
  }

  void edit({required String id, required String title}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(
            title: title,
            createdAt: DateTime.now(),
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
