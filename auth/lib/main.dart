import 'package:auth/screens/home_screen.dart';
import 'package:auth/screens/login_screen.dart';
import 'package:auth/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(AuthApp(token: prefs.getString('token') ?? ''));
}

class AuthApp extends StatelessWidget {
  final String token;
  const AuthApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth App',
      theme: ThemeData(
        fontFamily: 'Plus Jakarta Sans',
      ),
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          return token != '' ? HomeScreen(token: token) : const LoginScreen();
        },
      ),
    );
  }
}
