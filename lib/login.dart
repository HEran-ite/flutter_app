import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    String error = '';
    login() async {
      try {
        var isLoggedIn = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.toString().trim(),
          password: passwordController.toString().trim(),
        );
        Navigator.pushNamed(context, '/dashboard');
      } catch (e) {
        error = e.toString();
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Login')),

      body: Center(
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(label: Text('email')),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(label: Text('password')),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: login, child: Text('login')),
            error.isNotEmpty ? Text(error) : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
