import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/bloc/todos/todos_bloc.dart';
import 'package:todo_bloc/models/todos.dart';
import 'package:todo_bloc/models/todos_filter.dart';

part 'filter_todos_event.dart';
part 'filter_todos_state.dart';

class FilterTodosBloc extends Bloc<FilterTodosEvent, FilterTodosState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todoSubscription;

  FilterTodosBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(FilterTodosLoadingState()) {
    on<UpdateTodosFilterEvent>(_updateTodos);
    on<FilterTodosUpdateEvent>(_filterTodos);

    _todoSubscription = todosBloc.stream.listen(
      (event) {
        add(FilterTodosUpdateEvent());
      },
    );
  }

  void _filterTodos(
    FilterTodosUpdateEvent event,
    Emitter<FilterTodosState> emit,
  ) {
    final state = this.state;

    if (state is FilterTodosLoadingState) {
      add(const UpdateTodosFilterEvent(todosFilter: TodosFilter.pending));
    }

    if (state is TodosFilterLoadedState) {
      add(UpdateTodosFilterEvent(todosFilter: state.todosFilter));
    }
  }

  void _updateTodos(
      UpdateTodosFilterEvent event, Emitter<FilterTodosState> emit) {
    final state = _todosBloc.state;

    print('event ${event.todosFilter}');

    if (state is TodosLoadedState) {
      final List<Todos> filteredTodos = state.todos.where((todo) {
        switch (event.todosFilter) {
          case TodosFilter.pending:
            return todo.isComplete == false;
          case TodosFilter.complete:
            return todo.isComplete == true;
        }
      }).toList();

      emit(TodosFilterLoadedState(
        todos: filteredTodos,
        todosFilter: event.todosFilter,
      ));
    }
  }
}
