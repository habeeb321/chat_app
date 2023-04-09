import 'dart:developer';

import 'package:chat_app/core/constants.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/view/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              kHeight10,
              ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    // Implement your authentication logic here
                    signIn();
                  }
                },
              ),
              kHeight10,
              RichText(
                text: TextSpan(
                  text: 'No Account? ',
                  style: const TextStyle(color: kBlackcolor),
                  children: [
                    TextSpan(
                      text: 'Register Now',
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => nextScreen(context, const SignUpPage()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}