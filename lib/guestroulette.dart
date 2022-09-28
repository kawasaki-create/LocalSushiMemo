import 'package:flutter/material.dart';
import 'package:sushi_memo_sns/routes/home_route.dart';
import 'non-login-scraping.dart';

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
                            builder:(context) => Guestroulette2(appBarText, sushiKubun.toString())
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
                            builder:(context) => Guestroulette2(appBarText, sushiKubun.toString())
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
                            builder:(context) => Guestroulette2(appBarText, sushiKubun.toString())
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
            /*　ここはAppleからなんか指摘が入ったら書き足す、ゲスト版の投稿ページ
            Text('\n\n'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
            ),
            Text('\n\n'),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(
                      builder:(context) => nonLoginHome()
                  ));
                },
                child: Text('つぶやいてみる'),
              ),
            ),

             */
          ],
        ),
      ),
    );
  }
}

class nonLoginHome extends StatefulWidget {

  @override
  State<nonLoginHome> createState() => _NonLoginHomeState();
}

class _NonLoginHomeState extends State<nonLoginHome> {

  String messageText = '';
  List postList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('つぶやき(ゲスト版)'),
      ),
      body: Center(
        child: Card(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                width: 300,
                //childおたす
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          showModalBottomSheet(
            //モーダルの背景の色、透過
            backgroundColor: Colors.transparent,
            //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context){
              return Container(
                margin: EdgeInsets.only(top: 64),
                decoration: BoxDecoration(
                  //モーダル自体の色
                  color: Colors.white,
                  //角丸にする
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: '投稿メッセージ'),
                        // 複数行のテキスト入力
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        // 最大140字
                        maxLength: 140,
                        onChanged: (String value) {
                          setState(() {
                            messageText = value;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('投稿'),
                          onPressed: () async {
                            final date =
                            DateTime.now().toLocal().toIso8601String(); // 現在の日時
                            // 投稿メッセージ用ドキュメント作成
                            if(messageText != "") {

                            }
                            // 1つ前の画面に戻る
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



