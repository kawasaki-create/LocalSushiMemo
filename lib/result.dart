import 'package:flutter/material.dart';
import 'package:sushi_memo_sns/root.dart';
import 'package:sushi_memo_sns/routes/roulette_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
class casherResult extends StatefulWidget {
  casherResult(this.ateList);
  List ateList;


  @override
  _casherResultState createState() => _casherResultState(ateList);
}

class _casherResultState extends State<casherResult> {
  _casherResultState(this.ateList);
  List ateList;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('お会計・集計'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text('お会計'),
            ),
            Container(
              child: Text('あなたが食べたのは・・・\n\n'),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
              ),
              child: Text(ateList.length.toString() + '  皿',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Text('\n\n'),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.amberAccent,
              child: Text('今回の獲得ポイント'),
            ),
            Text('\n今回は\n\n'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
              ),
              child: Text('${ateList.length * 2}  ポイント',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Text('\n\n付与しました\n\n'),
            ElevatedButton(
              child: Text('最初のページへ移動'),
              onPressed: () async{
                final user = FirebaseAuth.instance
                .currentUser;
                Navigator.push(context,MaterialPageRoute(
                    builder:(context) => RootWidget(user!)
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
