import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sushi_memo_sns/result.dart';
import 'package:sushi_memo_sns/root.dart';
import 'package:universal_html/controller.dart';
import 'package:sushi_memo_sns/routes/roulette_route.dart';
import 'dart:math';
import 'package:sushi_memo_sns/twitterShere.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sushi_memo_sns/post_page.dart';
import 'dart:io';

class scraping extends StatefulWidget {

  @override
  _scrapingState createState() => _scrapingState();
}

class _scrapingState extends State<scraping> {
  List sushiroMenuName = [];
  List  sushiroMenuPrice = [];

  String sushiroMenuPicStr = '';

    sushiroSC() async {
    final controller = WindowController();
    await controller.openHttp(
      uri: Uri.parse('https://www.akindo-sushiro.co.jp/menu/'),
    );
    setState(() {
       sushiroMenuName = controller.window!.document
           .querySelectorAll(".ttl");
       sushiroMenuPrice = controller.window!.document
           .querySelectorAll(".price");
       sushiroMenuPicStr = controller.window!.document
           .querySelectorAll(".item-list  img").toString();
       sushiroMenuName = ["夏だ！スタミナうなぎづくし", "ローストビーフマウンテン", "えび天マウンテン", "天然インド鮪中落ちてんこ盛り", "うなきゅう巻", "大切り煮穴子", "大切りびんちょう", "大盛りねぎまぐろ", "てんこ盛りしらす軍艦", "大切りうなぎ", "うざく包み", "う巻きにぎり", "天然インド鮪7貫食べ比べ", "海南鶏飯ロール", "鹿児島県産タマクエ", "大切り甘鯛の天ぷら", "塩筋子にぎり", "しまあじ", "とろかつお", "いか梅しそにぎり", "まぐろビッグカツ", "天然ぶり胡麻醤油漬け", "トロあじ", "まぐろ・たまご", "サーモン・えび", "コーン・ツナ", "赤貝", "白とり貝バジルレモン", "ビーフ100％ハンバーグ", "ピリ辛イカキムチ軍艦", "梅きゅう巻", "季節のいなり（枝豆・ひじき）", "宮崎牛使用 特製肉うどん", "釜玉うどん", "もずくとあおさの赤だし", "もずくとあおさの味噌汁", "三重県産カタクチいわし唐揚げ", "マーメイドパフェ ～ハワイアンブルー味～", "まぐろ", "漬けまぐろ", "サーモン", "オニオンサーモン", "焼とろサーモン", "おろし焼とろサーモン", "ジャンボとろサーモン", "サーモンちーず", "炙りサーモンバジルチーズ", "はまち", "焼き鯖", "〆真さば", "〆真さば(ごまネギ)", "〆いわし(ネギ・生姜)", "こはだ", "赤えび", "生えび", "えび", "えびチーズ", "えびバジルチーズ", "えびアボカド", "甘えび", "いか", "いか塩レモン", "煮あなご", "かにカマ天にぎり", "たまご", "豚塩カルビ", "生ハム", "黒門伊勢屋のわさびなす", "特ネタ中とろ", "びんとろ", "生サーモン", "サーモンバジルモッツァレラ", "たい", "漬けごま真鯛", "大えび", "ほたて貝柱", "大つぶ貝", "たこ", "うなぎの蒲焼き", "生ハムバジルモッツァレラ", "特ネタ大とろ", "特ネタ大とろ焦がし醤油", "大切りあわび2貫", "軍艦ねぎまぐろ", "まぐろ山かけ", "まぐろユッケ(卵黄醤油)", "まぐたく", "かにみそ", "軍艦甘えび", "とびこ軍艦", "たらマヨ", "たらこ", "コーン", "ツナサラダ", "シーサラダ", "カニ風サラダ", "いかオクラめかぶ", "めかぶ長芋納豆軍艦", "小粒納豆", "きゅうり巻", "新香巻", "海老フライアボカドロール", "いくら", "軍艦馬刺しねぎとろ", "鉄火巻", "コク旨まぐろ醤油ラーメン", "鯛だし塩ラーメン", "濃厚えび味噌ワンタンメン", "わかめうどん", "かけうどん", "魚のアラの赤だし", "あさりの赤だし", "あさりの味噌汁", "茶碗蒸し", "たこの唐揚げ", "なんこつ唐揚げ", "フライドポテト", "かぼちゃの天ぷら", "店内仕込の海鮮ポテサラ(ガリ入)", "生ビール　ジョッキ", "生ビール　グラス", "大吟醸", "生貯蔵酒", "角ハイボール", "こだわり酒場のレモンサワー", "オールフリー（ﾉﾝｱﾙｺｰﾙﾋﾞｰﾙ）", "りんごジュース　国産100％果汁", "アイスコーヒー", "ホットコーヒー", "アイスカフェラテ", "ホットカフェラテ", "練乳いちごパフェ", "北海道ミルクレープメルバ", "カタラーナアイスブリュレ", "ショコラケーキリッチ", "北海道ミルクレープ", "クラシックプリン", "わらび餅と大学芋どっちも盛り", "大学いも", "京都峯嵐堂のわらびもち", "フローズンマンゴー", "懐かしのメロンシャーベット", "北海道バニラアイス"];
       sushiroMenuPrice = ["580円（税込638円）　362kcal", "300円（税込330円）　132kcal", "300円（税込330円）　383kcal", "150円（税込165円）　73kcal", "150円(税込165円)　199kcal", "150円（税込165円）　66kcal", "100円（税込110円）　97kcal", "100円（税込110円）　126kcal", "100円（税込110円）　84kcal", "100円（税込110円）　73kcal", "100円（税込110円）　78kcal", "100円（税込110円）　103kcal", "980円（税込1,078円）　415kcal", "150円（税込165円）　130kcal", "300円（税込330円）　95kcal", "150円（税込165円）　142kcal", "150円（税込165円）　71kcal", "150円（税込165円）　51kcal", "150円（税込165円）　99kcal", "150円（税込165円）　72kcal", "100円（税込110円）　151kcal", "100円（税込110円）　112kcal", "100円（税込110円）　104kcal", "100円(税込110円)　98kcal", "100円(税込110円)　84kcal", "100円(税込110円)　135kcal", "100円（税込110円）　63kcal", "100円（税込110円）　83kcal", "100円（税込110円）　135kcal", "100円（税込110円）　78kcal", "100円（税込110円）　151kcal", "100円（税込110円）　158kcal", "330円（税込363円）　344kcal", "300円（税込330円）　283kcal", "200円（税込220円）　47kcal", "200円（税込220円）　40kcal", "120円（税込132円）　160kcal", "280円（税込308円）　189kcal", "100円（税込110円）　78kcal", "100円（税込110円）　81kcal", "100円（税込110円）　95kcal", "100円（税込110円）　124kcal", "100円（税込110円）　95kcal", "100円（税込110円）　96kcal", "100円（税込110円）　67kcal", "100円（税込110円）　133kcal", "100円（税込110円）　137kcal", "100円（税込110円）　111kcal", "100円（税込110円）　189kcal", "100円（税込110円）　115kcal", "100円（税込110円）　117kcal", "100円（税込110円）　103kcal", "100円（税込110円）　80kcal", "100円（税込110円）　40kcal", "100円（税込110円）　70kcal", "100円（税込110円）　72kcal", "100円（税込110円）　106kcal", "100円（税込110円）　110kcal", "100円（税込110円）　116kcal", "100円（税込110円）　65kcal", "100円（税込110円）　68kcal", "100円（税込110円）　69kcal", "100円（税込110円）　97kcal", "100円（税込110円）　163kcal", "100円（税込110円）　117kcal", "100円（税込110円）　116kcal", "100円（税込110円）　112kcal", "100円（税込110円）　69kcal", "150円（税込165円）　91kcal", "150円（税込165円）　90kcal", "150円（税込165円）　72kcal", "150円（税込165円）　132kcal", "150円（税込165円）　93kcal", "150円（税込165円）　107kcal", "150円（税込165円）　45kcal", "150円（税込165円）　76kcal", "150円（税込165円）　66kcal", "150円（税込165円）　72kcal", "150円（税込165円）　103kcal", "150円（税込165円）　97kcal", "300円（税込330円）　79kcal", "300円（税込330円）　80kcal", "300円（税込330円）　70kcal", "100円（税込110円）　119kcal", "100円（税込110円）　94kcal", "100円（税込110円）　115kcal", "100円（税込110円）　112kcal", "100円（税込110円）　94kcal", "100円（税込110円）　100kcal", "100円（税込110円）　79kcal", "100円（税込110円）　142kcal", "100円（税込110円）　88kcal", "100円（税込110円）　119kcal", "100円（税込110円）　150kcal", "100円（税込110円）　119kcal", "100円（税込110円）　127kcal", "100円（税込110円）　72kcal", "100円（税込110円）　91kcal", "100円（税込110円）　97kcal", "100円（税込110円）　139kcal", "100円（税込110円）　160kcal", "100円（税込110円）　131kcal", "150円（税込165円）　82kcal", "150円（税込165円）　95kcal", "150円（税込165円）　169kcal", "350円（税込385円）　328kcal", "350円（税込385円）　236kcal", "350円（税込385円）　346kcal", "300円（税込330円）　199kcal", "150円（税込165円）　177kcal", "180円（税込198円）　113kcal", "180円（税込198円）　73kcal", "180円（税込198円）　66kcal", "200円（税込220円）　76kcal", "280円（税込308円）　249kcal", "150円（税込165円）　239kcal", "120円（税込132円）　189kcal", "120円（税込132円）　74kcal", "120円（税込132円）　169kcal", "480円（税込528円）　100gあたり47kcal", "350円（税込385円）　100gあたり47kcal", "580円（税込638円）　100gあたり108kcal", "380円（税込418円）　100gあたり88kcal", "350円（税込385円）　100gあたり55kcal", "350円（税込385円）　100gあたり48kcal", "350円（税込385円）　0kcal", "150円（税込165円）　80kcal", "150円（税込165円）　砂糖なしの場合 4kcal", "150円（税込165円）　砂糖なしの場合 7kcal", "180円（税込198円）　砂糖なしの場合 64kcal", "180円（税込198円）　砂糖なしの場合 81kcal", "300円（税込330円）　293kcal", "230円（税込253円）　203kcal", "200円（税込220円）　201kcal", "200円（税込220円）　199kcal", "200円（税込220円）　211kcal", "150円（税込165円）　191kcal", "180円（税込198円）　197kcal", "120円（税込132円）　156kcal", "120円（税込132円）　97kcal", "120円（税込132円）　54kcal", "120円（税込132円）　97kcal", "120円（税込132円）　60kcal"];

    });
  }

  String appBarText = '上のやつ';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: (){
                  sushiroSC();
                  appBarText = '今ボタン押しましたね';
                },
                child: Text('絶対押すなよ！'),
              ),
             // Text(sushiroMenuName.replaceAll('<span class="ttl">', '').replaceAll('</span>', '')),
             // Text(sushiroMenuPrice.replaceAll('<span class="price">', '').replaceAll('</span>', '')),
            /* sushiroMenuPic = sushiroMenuPic.replaceAll('<img src=', '').replaceAll('width="200" height="200" alt="">', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''),

             */
               ElevatedButton(
                   onPressed: (){
                     Navigator.push(context,MaterialPageRoute(
                         builder:(context) => ListBody()
                     ));
                    /*

                     */
                   },
                   child: Text('リストが開きます')
               ),
              ElevatedButton(
                onPressed: (){
                  Text(sushiroMenuPicStr);
                },
                child: Text(''),
              ),
            ],
          ),
        ),
      ),
    );
    }
  }

  class ListBox extends StatefulWidget {
    ListBox(this.appBarText, this.sushiKubun);
    String appBarText;
    String sushiKubun;

    @override
    _ListBoxState createState() => _ListBoxState(appBarText, sushiKubun);
  }

  class _ListBoxState extends State<ListBox> {
    _ListBoxState(this.appBarText, this.sushiKubun);
    String appBarText;
    String sushiKubun;
    int addPoint = 0;
    int totalPoint = 0;
    List sushiroMenuName = [];
    List sushiroMenuPrice = [];
    List ateList = [];
   late int RandomSushiroMenu =  Random().nextInt(sushiroMenuPrice.length);

    sushiroSC() async {
      var url = 'https://www.akindo-sushiro.co.jp/menu/';
      final controller = WindowController();
      await controller.openHttp(uri: Uri.parse(url));

      setState(() {
        sushiroMenuName = controller.window!.document.querySelectorAll('span > .ttl');
        sushiroMenuPrice = controller.window!.document.querySelectorAll('span > .price');
      });
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
                  Text(sushiroMenuName[RandomSushiroMenu].toString()
                      .replaceAll('<span class="ttl">', '').replaceAll('</span>', '')),
                  Text(sushiroMenuPrice[RandomSushiroMenu].toString()
                      .replaceAll('<span class="price">', '').replaceAll('</span>', '')),
                  Text('\n\n'),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          ateList.add(sushiroMenuName[RandomSushiroMenu].toString()
                              .replaceAll('<span class="ttl">', '').replaceAll('</span>', ''));
                          setState(() {
                            RandomSushiroMenu =  Random().nextInt(sushiroMenuPrice.length);
                          });
                        },
                        child: Text('食べた')
                    ),
                    ElevatedButton(
                        onPressed: (){
                          setState(() {
                            RandomSushiroMenu =  Random().nextInt(sushiroMenuPrice.length);
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
                      onPressed: () async{
                        final date =
                        DateTime.now().toLocal().toIso8601String(); // 現在の日時
                        final user =  await FirebaseAuth.instance
                          .currentUser;
                        final email = user?.email;

                        //食べたものリストの追記
                         await FirebaseFirestore.instance
                          .collection('eats')
                          .doc()
                          .set({
                            'date' : date,
                            'ate' :  ateList.toString(),
                            'email' : email
                          });

                         //もしデータがあれば合計ポイントを取得する。なければ新設

                        await FirebaseFirestore.instance
                         .collection('Points')
                         .doc(email)
                         .get()
                         .then((snapshot){
                           if(snapshot.exists) {
                             totalPoint = snapshot.get('totalPoint');
                           }
                        });

                        //合計ポイントに今回ポイントを追加する
                        addPoint = ateList.length * 2;
                        totalPoint += addPoint;
                         await FirebaseFirestore.instance
                        .collection('Points')
                         .doc(email)
                         .set({
                           'totalPoint': totalPoint
                         });
                       /* setState(() {
                          ateList = [];
                        });

                        */
                        Navigator.push(context,MaterialPageRoute(
                            builder:(context) => casherResult(ateList)
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
              ],
            ),
          ),

        ),
      );
    }
  }