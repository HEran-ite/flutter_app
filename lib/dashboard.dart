import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final String uid;
  DashboardPage({super.key, required this.uid});

  Future<String> getUserName() async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection("users")
            .doc('test_user')
            .get();
    return snapshot.data()?['Name'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final username = getUserName();

    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),

      body: Column(
        children: [
          Text('Welcome $username'),
          ElevatedButton(onPressed: () {}, child: Text('update')),
        ],
      ),
    );
  }
}
