import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code/bloc/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController? _email;
  late TextEditingController? _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _email?.dispose();
    _password?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Sign In',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _email,
                    validator: (value) {
                      // value == null => not validate if input text is empty
                      if (value!.isEmpty) {
                        return 'Email is required';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'example@gmail.com',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 17,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _password,
                    validator: (value) {
                      // value == null => not validate if input text is empty
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }

                      // if (value.length < 7) {
                      //   return 'Password must be greater than 7';
                      // }

                      return null;
                    },
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      hintText: '*******',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 17,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthStateError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 2),
                              content: Text(state.error),
                            ),
                          );
                        }

                        if (state is AuthStateLogin) {
                          context.go('/');
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state == AuthStateLoading()
                              ? null
                              : () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if ((_formKey.currentState?.validate() ??
                                          false) ==
                                      true) {
                                    context.read<AuthBloc>().add(
                                          AuthEventLogin(
                                            email: _email!.text,
                                            password: _password!.text,
                                          ),
                                        );
                                  }
                                },
                          child: Text(
                            state == AuthStateLoading() ? 'LOADING' : 'LOGIN',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
