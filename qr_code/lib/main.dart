import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes/route.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/products/products_bloc.dart';
import 'helpers/theme.dart';
import 'helpers/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
          BlocProvider<ProductsBloc>(create: (context) => ProductsBloc()),
        ],
        child: MaterialApp.router(
          title: 'Flutter Qr-Code',
          debugShowCheckedModeBanner: false,
          theme: theme,
          routerConfig: router,
        ),
      ),
    );
  }
}
