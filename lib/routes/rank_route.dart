import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Ranking extends StatefulWidget {

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
//  List<DocumentSnapshot> pointList = [];

  final  Stream<QuerySnapshot<Map<String, dynamic>>> rankStream =
      FirebaseFirestore.instance
        .collection('users')
        .orderBy('totalPoint', descending: true)
        .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ランキング"),
      ),
      body: StreamBuilder(
        stream: rankStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
         return Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black
                          ),
                        ),
                        child: Text('獲得ポイントランキング',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text('\n'),
                  Column(
                    children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document){
                      return Card(
                        child:
                          Text('${document['userID']}・・・${document['totalPoint']} ポイント'),
                      );
                      }).toList(),
                  ),
                  
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
