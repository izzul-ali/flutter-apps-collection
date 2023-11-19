import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:auth/screens/register_screen.dart';
import 'package:auth/widget/or.dart';
import 'package:auth/widget/text_input.dart';
import 'package:auth/widget/third_party_auth.dart';
import 'package:auth/screens/home_screen.dart';
import 'package:auth/widget/auth_icon.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SharedPreferences? prefs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void setPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    setPrefs();
    super.initState();
  }

  void onSubmit() async {
    print(
        'result: ${emailController.value.text} : ${passwordController.value.text}');

    http.Response resp = await http.post(
      Uri.parse(
          '${dotenv.env['API_URL']}/accounts:signInWithPassword?key=${dotenv.env['API_KEY']}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'email': emailController.value.text,
          'password': passwordController.value.text,
          'returnSecureToken': true
        },
      ),
    );

    if (resp.statusCode == 200) {
      var body = jsonDecode(resp.body);
      print('resp $body');

      if (body['idToken'] != null) {
        bool? isSuccessStoreToken = await prefs?.setString(
          'token',
          body['idToken'],
        );

        if (isSuccessStoreToken != null && isSuccessStoreToken) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) =>
                  HomeScreen(token: prefs?.getString('token') ?? 'kosong'),
            ),
          );

          return;
        }
        print('gagal menyimpan token');
        return;
      }
      print('token tidak ada');

      return;
    }

    var body = jsonDecode(resp.body);
    print('resp failed $body');
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthIcon(iconUrl: 'lib/assets/icons/claps.png'),
                const SizedBox(height: 20),
                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff2A4ECA),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'It was popularised in the 1960s with the release of Letraset sheetscontaining Lorem Ipsum.',
                  style: TextStyle(
                    color: Color(0xff61677D),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ThirdPartyAuth(
                      onTap: () {},
                      iconUrl: 'lib/assets/icons/facebook.png',
                      title: 'Facebook',
                    ),
                    ThirdPartyAuth(
                      onTap: () {},
                      iconUrl: 'lib/assets/icons/google.png',
                      title: 'Google',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const OrSeparate(),
                const SizedBox(height: 25),
                CustomTextInput(
                  usernameController: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textHint: 'Email',
                ),
                const SizedBox(height: 15),
                CustomTextInput(
                  usernameController: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textHint: 'Password',
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('forgot password');
                      },
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff61677D),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => onSubmit(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: const Color(0xff3461FD),
                        borderRadius: BorderRadius.circular(14)),
                    child: const Center(
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Color(0xff3B4054),
                        ),
                        text: 'Don\'t have an account? ',
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: const TextStyle(
                              color: Color(0xff3461FD),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
