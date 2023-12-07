part of 'filter_todos_bloc.dart';

sealed class FilterTodosEvent extends Equatable {
  const FilterTodosEvent();

  @override
  List<Object> get props => [];
}

class FilterTodosUpdateEvent extends FilterTodosEvent {
  @override
  List<Object> get props => [];
}

class UpdateTodosFilterEvent extends FilterTodosEvent {
  final TodosFilter todosFilter;

  const UpdateTodosFilterEvent({this.todosFilter = TodosFilter.pending});

  @override
  List<Object> get props => [todosFilter];
}
