import 'package:flutter/material.dart';
import 'package:universal_html/controller.dart';

class scraping extends StatefulWidget {

  @override
  _scrapingState createState() => _scrapingState();
}

class _scrapingState extends State<scraping> {
  dynamic sushiroMenuName = '';
  dynamic  sushiroMenuPrice = '';
  dynamic  sushiroMenuPic = '';

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
       sushiroMenuPic = controller.window!.document
           .querySelectorAll(".item-list  img");
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
            children: [
              ElevatedButton(
                onPressed: (){
                  sushiroSC();
                  appBarText = '今ボタン押しましたね';
                },
                child: Text('絶対押すなよ！'),
              ),
             // Text(sushiroMenuName.replaceAll('<span class="ttl">', '').replaceAll('</span>', '')),
             // Text(sushiroMenuPrice.replaceAll('<span class="price">', '').replaceAll('</span>', '')),
             sushiroMenuPic = sushiroMenuPic.replaceAll('<img src=', '').replaceAll('width="200" height="200" alt="">', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''),
              // Text(sushiroMenuPic),
              ListView.builder(
                  itemBuilder: (BuildContext context, int index){
                    return sushiroMenuPic;
                  }
              )
            ],
          ),
        ),
      ),
    );
    }
  }

