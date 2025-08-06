import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dashboard.dart';

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
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.toString().trim(),
          password: passwordController.toString().trim(),
        );
        final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage(uid: uid)),
        );
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
            error.isNotEmpty ? Text(error) : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
