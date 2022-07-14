import 'package:flutter/material.dart';

class Roulette extends StatefulWidget {
  @override
  _RouletteState createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  String appBarText = 'お店選択';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () async{
                      setState(() {
                        appBarText = 'お店：スシロー';
                      });
                    },
                    child: Text('スシロー')
                ),
                ElevatedButton(
                    onPressed: () async{
                      setState(() {
                        appBarText = 'お店：くら寿司';
                      });
                    },
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
                    onPressed: () async{
                      setState(() {
                        appBarText = 'お店：はま寿司';
                      });
                    },
                    child: Text('はま寿司')
                ),
                ElevatedButton(
                    onPressed: () async{
                      setState(() {
                        appBarText = 'お店：かっぱ寿司';
                      });
                    },
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