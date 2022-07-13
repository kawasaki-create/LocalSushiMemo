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
    return Scaffold(
      appBar: AppBar(
        title: Text('お店選択'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: (){},
                    child: Text('スシロー')
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: Text('くら寿司')
                ),
              ],
            ),
            Row(
              children: [
                Text('\n\n'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: (){},
                    child: Text('はま寿司')
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: Text('かっぱ寿司')
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
