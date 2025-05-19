import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'todo.dart';

final todosRef =
    FirebaseFirestore.instance.collection('todos').withConverter<Todo>(
          fromFirestore: (snap, _) => Todo.fromJson(snap.data()!),
          toFirestore: (todo, _) => todo.toJson(),
        );

final todosStreamProvider = StreamProvider.autoDispose<List<Todo>>((ref) {
  return todosRef
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => doc.data()).toList();
  });
});

Future<void> addTodo(String title) async {
  final documentReference =
      FirebaseFirestore.instance.collection('todos').doc();

  final newTodo = Todo(
    id: documentReference.id,
    title: title,
    completed: false,
    createdAt: DateTime.now(),
  );

  await todosRef.doc(newTodo.id).set(newTodo);
}

Future<void> updateTodo(Todo todo) async {
  await todosRef.doc(todo.id).set(todo);
}

Future<void> deleteTodo(String id) async {
  await todosRef.doc(id).delete();
}
