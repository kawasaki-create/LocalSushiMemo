import 'package:flutter/material.dart';

class Game extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SushiGame"),
      ),
      body: Center(child: Text("ゲーム")
      ),
    );
  }
}