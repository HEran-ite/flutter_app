import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DashboardPage extends StatefulWidget {
  final String uid;

  const DashboardPage({super.key, required this.uid});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<String>? _usernameFuture;

  @override
  void initState() {
    super.initState();
    _usernameFuture = getUserName();
  }

  Future<String> getUserName() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection("users")
              .doc('test_user')
              .get();
      return snapshot.data()?['Name '];
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiKey = dotenv.env['apiKey'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: _usernameFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final username = snapshot.data;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome, $username!'),
                const SizedBox(height: 16),
                Text('API Key: $apiKey'),
              ],
            ),
          );
        },
      ),
    );
  }
}
