import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/filter-todos/filter_todos_bloc.dart';
import 'package:todo_bloc/bloc/todos/todos_bloc.dart';
import 'package:todo_bloc/screens/home_screen.dart';

void main() {
  Bloc.observer = TodoAppBlocObsever();
  runApp(const TodoBlocApp());
}

class TodoBlocApp extends StatelessWidget {
  const TodoBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc()
            ..add(
              const LoadedTodoEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => FilterTodosBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          ),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Bloc App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class TodoAppBlocObsever extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('change on $change');

    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('error $error');
    super.onError(bloc, error, stackTrace);
  }
}
