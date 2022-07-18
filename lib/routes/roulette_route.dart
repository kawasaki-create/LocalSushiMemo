import 'package:flutter/material.dart';
import 'package:sushi_memo_sns/scrapingMenu.dart';

class Roulette extends StatefulWidget {
  @override
  _RouletteState createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  String appBarText = 'お店選択';
  int sushiKubun = 0;


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
                        sushiKubun = 1;
                        Navigator.push(context,MaterialPageRoute(
                            builder:(context) => AllorOnly(sushiKubun)
                        ));
                      });
                    },
                    child: Text('スシロー')
                ),
                ElevatedButton(
                    onPressed: () async{
                      setState(() {
                        sushiKubun = 2;
                        Navigator.push(context,MaterialPageRoute(
                            builder:(context) => AllorOnly(sushiKubun)
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
                        Navigator.push(context,MaterialPageRoute(
                            builder:(context) => AllorOnly(sushiKubun)
                        ));
                      });
                    },
                    child: Text('はま寿司')
                ),
                ElevatedButton(
                    onPressed: () async{
                      setState(() {
                        sushiKubun = 4;
                        Navigator.push(context,MaterialPageRoute(
                            builder:(context) => AllorOnly(sushiKubun)
                        ));
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

class AllorOnly extends StatelessWidget {

  AllorOnly(this.sushiKubun);
   int sushiKubun;

   String appBarText = 'お店選択';

  @override
  Widget build(BuildContext context) {
    switch(sushiKubun){
      case 0:
          appBarText = '条件が正しくありません';
          break;
      case 1:
         appBarText = 'お店：スシロー';
         break;
      case 2:
         appBarText = 'お店：くら寿司';
         break;
      case 3:
         appBarText = 'お店：はま寿司';
         break;
      case 4:
         appBarText = 'お店：かっぱ寿司';
         break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(
                      builder:(context) => scraping()
                  ));
                },
                child: Text('寿司オンリー'),
            ),
            Text('\n'),
            ElevatedButton(
              onPressed: (){},
              child: Text('全メニュー'),
            ),
          ],
        ),
      ),
    );
  }
}
