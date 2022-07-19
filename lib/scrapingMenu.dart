import 'package:flutter/material.dart';
import 'package:universal_html/controller.dart';

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
                         builder:(context) => ListBody(sushiroMenuPicStr)
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
  class ListBody extends StatelessWidget {
  List listText = ['りんご','ばなな','みかん','さーもん'];
  List  sushiroMenuPic = [];

  ListBody(this.sushiroMenuPicStr);
  late String sushiroMenuPicStr = sushiroMenuPicStr.replaceAll('<img src=', '').replaceAll('width="200" height="200" alt="">', '');

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('yobidasisaki'),
        ),
        body: Column(
          children: [
            Card(
              child: ListView.builder(
                  itemCount: sushiroMenuPicStr.length,
                  itemBuilder: (context, index){
                    sushiroMenuPic = sushiroMenuPicStr as List;
                    final item = sushiroMenuPic[index];
                    return ;
                  }
              ),
            ),
            Text(sushiroMenuPicStr)
          ],
        ),
         


      );
    }
  }


