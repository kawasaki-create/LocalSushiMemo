import 'package:flutter/material.dart';

class Game extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ランキング"),
      ),
      body: Center(child: Text("ランキング")
      ),
    );
  }
}