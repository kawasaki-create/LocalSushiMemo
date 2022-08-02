import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Notice extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通知"),
      ),
      body: Center(child: Text("Coming Soon")
      ),
    );
  }
}