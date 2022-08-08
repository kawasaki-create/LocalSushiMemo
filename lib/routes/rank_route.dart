import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Ranking extends StatefulWidget {

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  List<DocumentSnapshot> pointList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ランキング"),
      ),
      body: Container(
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
                    child: Text('デイリー',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black
                      ),
                    ),
                    child: Text('マンスリー',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Text('\n'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black
                      ),
                    ),
                    child: Text('デイリー',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black
                      ),
                    ),
                    child: Text('マンスリー',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async{
                    /*
                     final snapshot =  FirebaseFirestore.instance
                          .collection('Points')
                          .orderBy("totalPoint", descending: true)
                          .get();
                     setState(() {
                       pointList = snapshot.docs;
                     });

                     */
                    },
                  child: Text('更新'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
