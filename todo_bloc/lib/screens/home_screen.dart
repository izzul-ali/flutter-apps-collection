import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/filter-todos/filter_todos_bloc.dart';
import 'package:todo_bloc/bloc/todos/todos_bloc.dart';
import 'package:todo_bloc/models/todos.dart';
import 'package:todo_bloc/models/todos_filter.dart';
import 'package:todo_bloc/screens/add_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bloc Todo App'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddTodoScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add_circle_outline_sharp,
                size: 30,
              ),
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            onTap: (tabIndex) {
              switch (tabIndex) {
                case 0:
                  context.read<FilterTodosBloc>().add(
                        const UpdateTodosFilterEvent(
                          todosFilter: TodosFilter.pending,
                        ),
                      );
                  break;
                case 1:
                  context.read<FilterTodosBloc>().add(
                        const UpdateTodosFilterEvent(
                          todosFilter: TodosFilter.complete,
                        ),
                      );
                  break;
              }
            },
            tabs: const [
              Tab(
                icon: Icon(Icons.pending_actions),
              ),
              Tab(
                icon: Icon(Icons.check_box),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _tab1(),
            _tab2(),
          ],
        ),
      ),
    );
  }

  Widget _tab1() {
    return BlocBuilder<FilterTodosBloc, FilterTodosState>(
      builder: (context, state) {
        if ((state is FilterTodosLoadingState)) {
          return _addTodo(context);
        }

        if (state is TodosFilterLoadedState) {
          if (state.todos.isEmpty) {
            return _addTodo(context);
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            children: state.todos.map((todo) => _todoItem(todo)).toList(),
          );
        }

        return const Center(
          child: Text('Something Went Wrong'),
        );
      },
    );
  }

  Widget _tab2() {
    return BlocBuilder<FilterTodosBloc, FilterTodosState>(
      builder: (context, state) {
        if (state is FilterTodosLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is TodosFilterLoadedState) {
          if (state.todos.isEmpty) {
            return const Center(
              child: Text('Opps, you dont have completed todos rignt now..'),
            );
          }
          return ListView(
            padding: const EdgeInsets.only(bottom: 20),
            children: state.todos.map((todo) => _todoItem(todo)).toList(),
          );
        }

        return const Center(
          child: Text('Something went wrong!'),
        );
      },
    );
  }

  Widget _todoItem(Todos todo) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      title: Text(
        todo.name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: todo.notes != null
          ? Text(
              todo.notes!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              context.read<TodosBloc>().add(
                    CheckTodoEvent(
                      todo: todo.copyWith(isComplete: !todo.isComplete),
                    ),
                  );
            },
            icon: Icon(
                todo.isComplete ? Icons.check_box : Icons.check_box_outlined),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () {
              context.read<TodosBloc>().add(DeleteTodoEvent(todoId: todo.id));
            },
            icon: const Icon(
              Icons.delete_sweep_outlined,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Center _addTodo(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTodoScreen(),
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Add Todo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
