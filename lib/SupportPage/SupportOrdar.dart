import 'package:adminhala/SupportPage/ChatePage.dart';
import 'package:adminhala/SupportPage/FireBaseStatment.dart';
import 'package:adminhala/models/FireBaseStatemant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SupportChat extends StatefulWidget {
  const SupportChat({Key? key}) : super(key: key);

  @override
  State<SupportChat> createState() => _SupportChatState();
}
FireBaseChat DataBase=FireBaseChat();
class _SupportChatState extends State<SupportChat> {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Images/logowelcome.png',),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(56, 95, 172, 1),
                Color.fromRGBO(1, 183, 168, 1)
              ]
          )),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        StreamBuilder<QuerySnapshot>(
        stream:  FirebaseFirestore.instance.collection('SupportData').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
           return ListView.builder(
                itemCount: snapshot.data!.size,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                  Center(
                    child: InkWell(
                      onTap: () {
                        DataBase.ChateOpen(DocumantName: snapshot.data!.docs[index]['Uid']);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(DocumantName: snapshot.data!.docs[index]['Uid']),));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        margin: EdgeInsets.only(top: 15,bottom: 15),
                        decoration: BoxDecoration(borderRadius:  BorderRadius.circular(15),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color.fromRGBO(141, 0, 210, 1),
                                  Color.fromRGBO(255, 97, 38, 1)
                                ]
                            )
                        ),
                        height: _h/10,
                        width: _w*0.9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snapshot.data!.docs[index]['Name'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),),
                              ],
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child:Text(snapshot.data!.docs[index]['Time'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                );
        },
      )
        ],
      ),
    );
  }
}
/*
*/