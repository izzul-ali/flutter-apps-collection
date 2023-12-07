import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/models/todos.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosLoadingState()) {
    on<LoadedTodoEvent>(_loadTodos);
    on<AddTodoEvent>(_addTodo);
    on<CheckTodoEvent>(_checkTodo);
    on<DeleteTodoEvent>(_deleteTodo);
  }

  void _loadTodos(LoadedTodoEvent event, Emitter<TodosState> emit) {
    emit(TodosLoadedState(todos: event.todos));
  }

  void _addTodo(AddTodoEvent event, Emitter<TodosState> emit) {
    print('add todo');

    final state = this.state;

    if (state is TodosLoadedState) {
      emit(
        TodosLoadedState(
          todos: List.from(state.todos)..add(event.todo),
        ),
      );
    }
  }

  void _checkTodo(CheckTodoEvent event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoadedState) {
      print('id ${event.todo.id} next ${event.todo.isComplete}');

      final List<Todos> currentTodos = state.todos.map((todo) {
        if (todo.id == event.todo.id) {
          return event.todo;
        }
        return todo;
      }).toList();

      emit(TodosLoadedState(todos: currentTodos));
    }
  }

  void _deleteTodo(DeleteTodoEvent event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoadedState) {
      final List<Todos> currentTodos = List.from(state.todos)
        ..removeWhere(
          (todo) {
            return todo.id == event.todoId;
          },
        );

      emit(
        TodosLoadedState(todos: currentTodos),
      );
    }
  }
}
