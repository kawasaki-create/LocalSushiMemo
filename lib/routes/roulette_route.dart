import 'package:flutter/material.dart';

class Roulette extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ランダム選択"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(
                  builder:(context) => ChosenStore()
              ));
            },
            child: Text('お店選択')
        ),
      ),
    );
  }
}

class ChosenStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
