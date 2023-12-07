part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class LoadedTodoEvent extends TodosEvent {
  final List<Todos> todos;

  const LoadedTodoEvent({this.todos = const <Todos>[]});

  @override
  List<Object> get props => [todos];
}

class AddTodoEvent extends TodosEvent {
  final Todos todo;

  const AddTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class CheckTodoEvent extends TodosEvent {
  final Todos todo;

  const CheckTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class DeleteTodoEvent extends TodosEvent {
  final String todoId;

  const DeleteTodoEvent({required this.todoId});

  @override
  List<Object> get props => [todoId];
}
