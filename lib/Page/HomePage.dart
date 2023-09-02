import 'dart:async';
import 'package:adminhala/AdsPage/Ads.dart';
import 'package:adminhala/Page/AuthPages/LogInPage.dart';
import 'package:adminhala/Page/PrudactsPages/CollectionPage.dart';
import 'package:adminhala/Page/DiscountPage.dart';
import 'package:adminhala/Page/PrudactsPages/Market/mainCollectionMarket.dart';
import 'package:adminhala/Page/Sales/sales.dart';
import 'package:adminhala/SupportPage/SupportOrdar.dart';
import 'package:adminhala/models/_H_W.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AuthPages/AuthFireBase.dart';
import 'Ordar/Ordars.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
AuthMethods auth = AuthMethods();
SizeFix sizeq=SizeFix();
class _HomePageState extends State<HomePage> {
  bool DataGet=true;
  int? numOfDocs;
  Map<String, dynamic> ? dataUser;
  static Map<String, dynamic> Data = {};
  String UidUser=FirebaseAuth.instance.currentUser!.uid;
  GetDataAdmin() async {
   await FirebaseFirestore.instance.collection('AdminData')
        .doc('$UidUser').get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        dataUser= snapshot.data()! as Map<String, dynamic>;
        Data=dataUser!;
        Timer(Duration(seconds: 1), () {
          setState(() {
            DataGet=false;
          });
        });
      } else {
        print("Document does not exist");
      }
    })
        .catchError((error) {
      print("Error retrieving data: $error");
    });
  }
  @override
  void initState() {
    GetDataAdmin();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return DataGet?Container(
      color: Colors.white,
      child: Center(child: Container(
          color: Colors.white,
          height: 150,
          width: 150,
          child: CircularProgressIndicator(
            backgroundColor: Colors.yellow,
            color: Colors.tealAccent,
          )),),
    )


        :
    Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.logout,color: Colors.white54,),onPressed: () {
            auth.signOut(context);
            Timer.periodic(Duration(seconds: 3), (timer) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn(),));
              timer.cancel();
            });
          },)
        ],
        title: Image.asset('assets/Images/logowelcome.png'),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(56, 95, 172, 1),
                Color.fromRGBO(1, 183, 168, 1)
              ]
          )),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height:  FirebaseAuth.instance.currentUser!.uid=='C1zSXr7C9DW3MHN9tsbBiNRSu3g2'?h*1.6:h*1.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Image.network(Data['ProfileImage'],height: sizeq.H(context: context)*0.1,),
                        Text(Data['Name'],style: TextStyle(fontSize: h*0.03,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      dataUser!['Uid']=='C1zSXr7C9DW3MHN9tsbBiNRSu3g2'?
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CollectionPage(),))
                          :
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Main_Collection_Market(),));
                    },
                    splashColor: Colors.teal,
                    borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(w/6),
                      bottomLeft: Radius.circular(w/10),
                      bottomRight: Radius.circular(w/6),
                      topRight: Radius.circular(w/10),
                    ) ,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: w/15,right: w/15),
                      height: h/7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(w/6),
                            bottomLeft: Radius.circular(w/10),
                            bottomRight: Radius.circular(w/6),
                            topRight: Radius.circular(w/10),
                          ),
                        gradient: LinearGradient(begin:Alignment.topLeft ,end:Alignment.bottomRight ,colors: [
                          Color.fromRGBO(78, 246, 123, 10),
                          Color.fromRGBO(80, 181, 248, 10)
                        ])
                      ),
                      child: Center(child: Text('تعديل وإضافة',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SupportChat(),));
                    },
                    splashColor: Colors.teal,
                    borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(w/6),
                      bottomLeft: Radius.circular(w/10),
                      bottomRight: Radius.circular(w/6),
                      topRight: Radius.circular(w/10),
                    ) ,
                    child: Container(
                      width: double.infinity,
                        margin: EdgeInsets.only(left: w/15,right: w/15),
                        height: h/7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(w/6),
                            bottomLeft: Radius.circular(w/10),
                            bottomRight: Radius.circular(w/6),
                            topRight: Radius.circular(w/10),
                          ),
                          //78/246/123
                          //80/181/248
                          gradient: LinearGradient(begin:Alignment.topLeft ,end:Alignment.bottomRight ,colors: [
                            Color.fromRGBO(78, 100, 123, 10),
                            Color.fromRGBO(80, 150, 248, 10)
                          ])
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: w/7,),
                          Center(child: Text('طلبات الدعم',style: TextStyle(color: Colors.white,fontSize: w/12,fontWeight: FontWeight.bold),)),
                          SizedBox(width: w/10,),
                          StreamBuilder<QuerySnapshot>(
                            stream:  FirebaseFirestore.instance.collection('SupportData').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('0');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }

                              return Container(
                                height: h/15,width: w/7,
                                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white38),
                                child: Center(child: Text(snapshot.data!.size.toString(),style: TextStyle(fontSize: w/15,fontWeight: FontWeight.bold,color: Colors.black54),)),
                              );
                            },
                          ),
                        ],
                      )

                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => sales(),));
                    },
                    splashColor: Colors.teal,
                    borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(w/6),
                      bottomLeft: Radius.circular(w/10),
                      bottomRight: Radius.circular(w/6),
                      topRight: Radius.circular(w/10),
                    ) ,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 33,right: 33),
                      height: h/7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(w/6),
                            bottomLeft: Radius.circular(w/10),
                            bottomRight: Radius.circular(w/6),
                            topRight: Radius.circular(w/10),
                          ),
                          //78/246/123
                          //80/181/248
                          gradient: LinearGradient(begin:Alignment.topLeft ,end:Alignment.bottomRight ,colors: [
                            Color.fromRGBO(78, 246, 123, 10),
                            Color.fromRGBO(80, 181, 248, 10)
                          ])
                      ),
                      child: Center(child: Text('المبيعات',style: TextStyle(color: Colors.white,fontSize: w/13,fontWeight: FontWeight.bold),)),

                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Discount(),));
                    },
                    splashColor: Colors.teal,
                    borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(w/6),
                      bottomLeft: Radius.circular(w/10),
                      bottomRight: Radius.circular(w/6),
                      topRight: Radius.circular(w/10),
                    ) ,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: w/10,right: w/10),
                      height: h/7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(w/6),
                            bottomLeft: Radius.circular(w/10),
                            bottomRight: Radius.circular(w/6),
                            topRight: Radius.circular(w/10),
                          ),
                          //78/246/123
                          //80/181/248
                          gradient: LinearGradient(begin:Alignment.topLeft ,end:Alignment.bottomRight ,colors: [
                            Color.fromRGBO(78, 246, 123, 10),
                            Color.fromRGBO(80, 181, 248, 10)
                          ])
                      ),
                      child: Center(child: Text('الخصومات',style: TextStyle(color: Colors.white,fontSize: w/13,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                  FirebaseAuth.instance.currentUser!.uid=='C1zSXr7C9DW3MHN9tsbBiNRSu3g2'?
                  InkWell(
                    onTap: (){
                      Navigator.
                      push(context, MaterialPageRoute(builder: (context) => AdsPage(),));
                    },
                    splashColor: Colors.teal,
                    borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(w/6),
                      bottomLeft: Radius.circular(w/10),
                      bottomRight: Radius.circular(w/6),
                      topRight: Radius.circular(w/10),
                    ) ,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 33,right: 33),
                      height: h/7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(w/6),
                            bottomLeft: Radius.circular(w/10),
                            bottomRight: Radius.circular(w/6),
                            topRight: Radius.circular(w/10),
                          ),
                          //78/246/123
                          //80/181/248
                          gradient: LinearGradient(begin:Alignment.topLeft ,end:Alignment.bottomRight ,colors: [
                            Color.fromRGBO(78, 246, 123, 10),
                            Color.fromRGBO(80, 181, 248, 10)
                          ])
                      ),
                      child: Center(child: Text('Hala Ads',style: TextStyle(color: Colors.white,fontSize: w/15,fontWeight: FontWeight.bold),)),

                    ),
                  )
                      :
                  Container(width:1,height: 1,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Ordar(),));
                    },
                    splashColor: Colors.teal,
                    borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(w/6),
                      bottomLeft: Radius.circular(w/10),
                      bottomRight: Radius.circular(w/6),
                      topRight: Radius.circular(w/10),
                    ) ,
                    child: Container(
                      padding: EdgeInsets.all(7),
                      width: 369,
                      margin: EdgeInsets.only(left: 33,right: 33),
                      height: h/7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(w/6),
                            bottomLeft: Radius.circular(w/10),
                            bottomRight: Radius.circular(w/6),
                            topRight: Radius.circular(w/10),
                          ),
                          //78/246/123
                          //80/181/248
                          color: Colors.red
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: w/10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('الطلبات',style: TextStyle(color: Colors.white,fontSize: w/13,fontWeight: FontWeight.bold),),
                            Container(height: 50,width: 50,decoration: BoxDecoration(shape: BoxShape.circle,
                              color: Colors.white70,),
                            child: Center(
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('Ordar').where('UidMarket',isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('OrdarStates',isLessThanOrEqualTo: 2).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {if (snapshot.hasError) {
                                        return Text('0');
                                      }
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator(),);
                                      }
                                      numOfDocs= snapshot.data!.docs.length;
                                      return numOfDocs==null?
                                      CircularProgressIndicator()
                                          :
                                      Text(numOfDocs.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),);
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
