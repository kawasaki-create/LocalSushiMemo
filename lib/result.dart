import 'package:flutter/material.dart';
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
              child: Text(ateList.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
