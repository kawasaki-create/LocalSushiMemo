import 'package:flutter/material.dart';
import 'package:sushi_memo_sns/root.dart';
import 'package:sushi_memo_sns/scrapingMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Roulette extends StatefulWidget {
  get user => RootWidget(user);
  @override
  _RouletteState createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  String appBarText = '';
  int sushiKubun = 0;

late final User user;

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
                            builder:(context) => ListBox(appBarText, sushiKubun.toString())
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
                            builder:(context) => ListBox(appBarText, sushiKubun.toString())
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
                            builder:(context) => ListBox(appBarText, sushiKubun.toString())
                        ));
                      });
                    },
                    child: Text('はま寿司')
                ),
                ElevatedButton(
                    onPressed: () async{
                      setState(() {
                        sushiKubun = 4;
                        appBarText = 'かっぱ寿司';
                        Navigator.push(context,MaterialPageRoute(
                            builder:(context) => ListBox(appBarText, sushiKubun.toString())
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

/*  class AllorOnly extends StatelessWidget {

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
         appBarText = 'スシロー';
         break;
      case 2:
         appBarText = 'くら寿司';
         break;
      case 3:
         appBarText = 'はま寿司';
         break;
      case 4:
         appBarText = 'かっぱ寿司';
         break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('お店：' + appBarText),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
                onPressed: (){

                },
                child: Text('寿司オンリー'),
            ),
            Text('\n'),
            ElevatedButton(
              onPressed: () async{
                Navigator.push(context,MaterialPageRoute(
                    builder:(context) => ListBox(appBarText, sushiKubun.toString())
                ));
              },
              child: Text('全メニュー'),
            ),
          ],
        ),
      ),
    );
  }
}

 */
