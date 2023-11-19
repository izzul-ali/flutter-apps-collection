import 'package:auth/screens/home_screen.dart';
import 'package:auth/screens/login_screen.dart';
import 'package:auth/screens/onboarding_screen.dart';
import 'package:auth/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await dotenv.load(fileName: '.env');

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    AuthApp(
      token: prefs.getString('token') ?? '',
      hasOpenedApp: prefs.getBool('hasOpenedApp') ?? false,
    ),
  );
}

class AuthApp extends StatelessWidget {
  final String token;
  final bool hasOpenedApp;
  const AuthApp({super.key, required this.token, required this.hasOpenedApp});

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

          return token != ''
              ? HomeScreen(token: token)
              : hasOpenedApp
                  ? const LoginScreen()
                  : const OnBoardingScreen();
        },
      ),
    );
  }
}
