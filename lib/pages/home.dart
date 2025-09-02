import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.blue,
        title: Text('Home Page'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text(
                'sign out',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
