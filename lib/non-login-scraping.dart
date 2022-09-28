import 'package:flutter/material.dart';
import 'package:sushi_memo_sns/login_page.dart';
import 'package:sushi_memo_sns/main.dart';
import 'package:sushi_memo_sns/result.dart';
import 'package:universal_html/driver.dart';
import 'dart:math';
import 'package:sushi_memo_sns/twitterShere.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Guestroulette2 extends StatefulWidget {
  Guestroulette2(this.appBarText, this.sushiKubun);
  String appBarText;
  String sushiKubun;


  @override
  State<Guestroulette2> createState() => _Guestroulette2State(appBarText, sushiKubun);
}

class _Guestroulette2State extends State<Guestroulette2> {
  _Guestroulette2State(this.appBarText, this.sushiKubun);
  String appBarText;
  String sushiKubun;

  List menuName = [];
  List menuPrice = [];
  List ateList = [];
  String replaceMenu = '';
  String replacePrice = '';
  late int RandomMenu =  Random().nextInt(menuName.length);

  Future sushiroSC() async {
    switch(sushiKubun){
      case '1':
        var url = 'https://www.akindo-sushiro.co.jp/menu/';
        final driver = new HtmlDriver();
        await driver.setDocumentFromUri(Uri.parse(url));
        setState(() {
          menuName = driver.document.querySelectorAll('span > .ttl');
          menuPrice = driver.document.querySelectorAll('span > .price');
          replaceMenu = menuName[RandomMenu].toString()
              .replaceAll('<span class="ttl">', '').replaceAll('</span>', '');
          replacePrice = menuPrice[RandomMenu].toString()
              .replaceAll('<span class="price">', '').replaceAll('</span>', '');
        });
        break;
      case '2':
        var url = 'https://www.kurasushi.co.jp/menu/?area=area0';
        final driver = new HtmlDriver();
        await driver.setDocumentFromUri(Uri.parse(url));

        setState(() {
          menuName = driver.document.querySelectorAll('.menu-name');
          // menuPrice = controller.window!.document.querySelectorAll('.menu-summary > li > p');
          replaceMenu = menuName[RandomMenu].toString()
              .replaceAll('<h4 class="menu-name">', '').replaceAll('</h4>', '');
          /* replacePrice = menuPrice[RandomMenu].toString()
                .replaceAll('<p>', '').replaceAll('</p>', '');

            */
        });
        break;
      case '3':
        var url = 'https://www.hama-sushi.co.jp/menu/';
        final driver = new HtmlDriver();
        await driver.setDocumentFromUri(Uri.parse(url));
        setState(() {
          menuName = driver.document.querySelectorAll('.men-products-item__text');
          // menuPrice = controller.window!.document.querySelectorAll('span > .price');
          replaceMenu = menuName[RandomMenu].toString()
              .replaceAll('<div class="men-products-item__text">', '').replaceAll('</div>', '')
              .replaceAll('<br>', ' ');
        });
        break;
      case '4':
        var url = 'https://www.kappasushi.jp/menu2';
        final driver = new HtmlDriver();
        await driver.setDocumentFromUri(Uri.parse(url));
        setState(() {
          menuName = driver.document.querySelectorAll('.menu .name');
          // menuPrice = controller.window!.document.querySelectorAll('span > .price');
          replaceMenu = menuName[RandomMenu].toString()
              .replaceAll('<div class="men-products-item__text">', '').replaceAll('</div>', '');
        });
        break;
    }

  }

  @override
  Widget build(BuildContext context) {
    sushiroSC();
    return Scaffold(
        appBar: AppBar(
        title: Text('お店：' + appBarText),
    ),
    body:  Center(
      child: SingleChildScrollView(
       child: Column(
      mainAxisSize: MainAxisSize.min,
    children: [
      Text('あなたが次に食べるのは・・・\n\n'),
      Text(replaceMenu),
      Text(replacePrice),
      Text('\n\n'),

    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          ateList.add(replaceMenu);
                          setState(() {
                            RandomMenu =  Random().nextInt(menuName.length);
                          });
                        },
                        child: Text('食べた')
                    ),
                    ElevatedButton(
                        onPressed: (){
                          setState(() {
                            RandomMenu =  Random().nextInt(menuName.length);
                          });
                        },
                        child: Text('食べてない')
                    ),

                  ],
                ),
                Text('\n\n\n'),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: Colors.amberAccent,
                  height: 50,
                  child: Text('食べたもの',
                      style: TextStyle(
                          fontSize: 20
                      )),
                ),
                for(int i = 0; i < ateList.length; i ++)
                  Text(ateList[i]),
                Text('\n\n\n'),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(
                            builder:(context) => GuestResult(appBarText, ateList.toString())
                        ));
                      },
                      child: Text('会計'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.pinkAccent
                      ),
                    ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TwitterShareWidget(
                    text: '今回' + appBarText + 'で食べたのは\n\n' + ateList.toString()
                          .replaceAll('[', '').replaceAll(']', '') + '\n\nです\n\n#すしめも\n'
                        '@kwsk_create より',
                    key: UniqueKey(),
                  )
                ),
    ]
       ),
    )
    )
    );
  }
}

class GuestResult extends StatelessWidget {
GuestResult(this.appBarText, this.ateList);
  String appBarText;
  String ateList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('食べた物集計'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text('今回' + appBarText + 'で食べたのは\n\n'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
              ),
              child: Text(ateList.replaceAll('[', '').replaceAll(']', ''),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Text('\n\n🍣です🍣\n\n'),
            ElevatedButton(
              child: Text('最初のページへ移動'),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(
                    builder:(context) => SushiMemo(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
