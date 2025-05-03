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
    @Default(false) bool completed,
  }) = _Todo;

  const Todo._();

  @override
  String toString() {
    return 'Todo(title: $title, completed: $completed)';
  }
}

class TodoList extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => [
        const Todo(id: 'todo-0', title: 'Buy cookies'),
        const Todo(id: 'todo-1', title: 'Star Riverpod'),
        const Todo(id: 'todo-2', title: 'Have a walk'),
      ];

  void add(String title) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        title: title,
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
          )
        else
          todo,
    ];
  }

  void edit({required String id, required String title}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: todo.completed,
            title: title,
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
