part of 'filter_todos_bloc.dart';

sealed class FilterTodosState extends Equatable {
  const FilterTodosState();

  @override
  List<Object> get props => [];
}

final class FilterTodosLoadingState extends FilterTodosState {
  @override
  List<Object> get props => [];
}

final class TodosFilterLoadedState extends FilterTodosState {
  final List<Todos> todos;
  final TodosFilter todosFilter;

  const TodosFilterLoadedState({
    required this.todos,
    required this.todosFilter,
  });

  @override
  List<Object> get props => [todos, todosFilter];
}
