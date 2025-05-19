import 'package:freezed_annotation/freezed_annotation.dart';
import 'date_time_timestamp_converter.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    @Default(false) bool completed,
    @DateTimeTimestampConverter() required DateTime createdAt,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
