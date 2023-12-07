part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosLoadingState extends TodosState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class TodosLoadedState extends TodosState {
  final List<Todos> todos;

  const TodosLoadedState({this.todos = const <Todos>[]});

  @override
  List<Object> get props => [todos];
}
