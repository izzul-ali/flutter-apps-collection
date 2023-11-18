import 'package:auth/screens/login_screen.dart';
import 'package:auth/widget/auth_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // clear input from memory
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void onSubmit() {
    print(
        'result: ${usernameController.value.text} : ${emailController.value.text} : ${passwordController.value.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuthIcon(iconUrl: 'lib/assets/icons/wave.png'),
              const SizedBox(height: 20),
              const Text(
                'Sign Up',
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
              TextField(
                controller: usernameController,
                keyboardType: TextInputType.name,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xffF5F9FE),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xff2A4ECA),
                    ),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xff7C8BA0),
                  ),
                  hintText: 'Username',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xffF5F9FE),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xff2A4ECA),
                    ),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xff7C8BA0),
                  ),
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xffF5F9FE),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xff2A4ECA),
                    ),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xff7C8BA0),
                  ),
                  hintText: 'Password',
                ),
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
                      'Create Account',
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
                          text: 'Sign In',
                          style: const TextStyle(
                            color: Color(0xff3461FD),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
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
    );
  }
}
