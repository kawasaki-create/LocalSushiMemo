import 'package:flutter/material.dart';

class Guestroulette extends StatefulWidget {
  const Guestroulette({Key? key}) : super(key: key);

  @override
  State<Guestroulette> createState() => _GuestrouletteState();
}

class _GuestrouletteState extends State<Guestroulette> {
  String appBarText = '';
  int sushiKubun = 0;

  @override
  Widget build(BuildContext context) {
    appBarText = 'お店選択';
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
                        sushiKubun = 1;
                        appBarText = 'スシロー';
                        Navigator.push(context,MaterialPageRoute(
                            builder:(context) => Guestroulette(appBarText, sushiKubun.toString())
                        ));
                      });
                    },
                    child: Text('スシロー')
                ),
                ElevatedButton(
                    onPressed: () async{
                      setState(() {
                        sushiKubun = 2;
                        appBarText = 'くら寿司';
                        Navigator.push(context,MaterialPageRoute(
                            builder:(context) => Guestroulette(appBarText, sushiKubun.toString())
                        ));
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
                        sushiKubun = 3;
                        appBarText = 'はま寿司';
                        Navigator.push(context,MaterialPageRoute(
                            builder:(context) => Guestroulette(appBarText, sushiKubun.toString())
                        ));
                      });
                    },
                    child: Text('はま寿司')
                ),
               /* ElevatedButton(
                    onPressed: () async{
                      setState(() {
                        sushiKubun = 4;
                        appBarText = 'かっぱ寿司';
                        Navigator.push(context,MaterialPageRoute(
                            builder:(context) => Guestroulette(appBarText, sushiKubun.toString())
                        ));
                      });
                    },
                    child: Text('かっぱ寿司')
                ),

                */
              ],
            ),
          ],
        ),
      ),
    );
  }
}
