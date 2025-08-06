import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final String uid;
  const DashboardPage({super.key, required this.uid});
  
  get username => null;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:Text('Dashboard'),
      ),


      body: Column(
        children: [
          Text('Welcome $username')
        ],
      ),
    );
  }
}