import 'dart:async';

import 'package:adminhala/Page/Ordar/OrdarDetals.dart';
import 'package:adminhala/models/SnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/FireBaseStatemant.dart';

class Ordar extends StatefulWidget {
  const Ordar({Key? key}) : super(key: key);
  @override
  State<Ordar> createState() => _OrdarState();
}
bool ShowOrdar=false;
bool Showaccipt=true;
class _OrdarState extends State<Ordar> {
  FireBase FireServices=FireBase();
  CollectionReference UserData = FirebaseFirestore.instance.collection('UserData');
  String? Name;
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        ShowOrdar=true;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    Showaccipt=true;
    return  Scaffold(
      appBar: AppBar(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/Images/logowelcome.png',height: 160,),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('Ordar')
                        .where('UidMarket',isEqualTo:FirebaseAuth.instance.currentUser!.uid).where('OrdarStates', isLessThan:2)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(),);
                      }
                      return ShowOrdar? SizedBox(
                        height: snapshot.data!.size*230,
                        child:ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            return  InkWell(
                              onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => OrdarDetals(
                                                Name: Name!,
                                                DataOrdar: data as Map<String, dynamic>,
                                                hight1: snapshot.data!.docs.length,
                                                DataOrdarDetals: data as Map<String, dynamic>),
                                          ));
                                    },
                              splashColor: Colors.teal,
                              borderRadius:BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(50.0),
                                topRight: Radius.circular(10.0),
                              ) ,
                              child:
                              Container(
                                  padding: EdgeInsets.all(7),
                                  width: double.infinity,
                                  margin: EdgeInsets.only(left: 33,right: 33,top: 15),
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(100.0),
                                        topRight: Radius.circular(5),
                                      ),
                                      //78/246/123
                                      //80/181/248
                                      color: Colors.black54
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(100.0),
                                              topRight: Radius.circular(5),
                                            ),
                                            //78/246/123
                                            //80/181/248
                                            color:Showaccipt? Colors.blue:Colors.green
                                        ),
                                        height: 200,
                                        width: 120,
                                        child: Showaccipt?Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text('قبول الطلب؟',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),

                                            ElevatedButton(onPressed: () async {
                                              setState(() {
                                                Showaccipt=false;
                                              });
                                              await FireServices.OrdarState(ordarid: data['orderID'],State:1);
                                              Navigator.push(context,  MaterialPageRoute(builder: (context) =>
                                                  OrdarDetals(Name: Name!,DataOrdar: data as  Map<String, dynamic>,hight1: snapshot.data!.docs.length,DataOrdarDetals: data as  Map<String, dynamic>),));
                                            }, child: Text('قبول',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),),
                                            ElevatedButton(onPressed: () async {
                                              showDialog(context: context, builder: (context) => AlertDialog(
                                                content: Container(
                                                  color: Colors.white,
                                                  height: 200,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Text('هل انت متاكد من الغاء الطلب؟',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          ElevatedButton(onPressed: () async{
                                                            await FireServices.TotalCancelUpdate(Prise: data['totalPrice']);
                                                            await FireServices.OrdarState(ordarid: data['orderID'],State:6);
                                                            await FireServices.OrdarCanceUpdate();
                                                            await FireServices.Ordarfailed(Prudact:data['items'], prise:data['totalPrice'], IdOrdar:data['orderID'], Uid:data['User']);
                                                            showSnackBar(context: context, text: 'تم الغاء الطلب', colors: Colors.red);
                                                            Navigator.pop(context);
                                                          }, child: Text('تأكيد',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),
                                                          ElevatedButton(onPressed: () {
                                                            Navigator.pop(context);
                                                          }, child: Text('تراجع',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),);
                                            }, child: Text('الغاء',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),
                                            SizedBox(height: 40,)
                                          ],
                                        ):
                                            Column(children: [
                                              Center(child: Text('تم قبول الطلب',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
                                              ElevatedButton(onPressed: () async {
                                                showDialog(context: context, builder: (context) => AlertDialog(
                                                  content: Container(
                                                    color: Colors.white,
                                                    height: 200,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text('هل انت متاكد من الغاء الطلب؟',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            ElevatedButton(onPressed: () async{
                                                              await FireServices.TotalCancelUpdate(Prise: data['totalPrice']);
                                                              await FireServices.OrdarState(ordarid: data['orderID'],State:6);
                                                              await FireServices.OrdarCanceUpdate();
                                                              await FireServices.Ordarfailed(Prudact:data['items'], prise:data['totalPrice'], IdOrdar:data['orderID'], Uid:data['User']);
                                                              showSnackBar(context: context, text: 'تم الغاء الطلب', colors: Colors.red);
                                                              Navigator.pop(context);
                                                            }, child: Text('تأكيد',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),
                                                            ElevatedButton(onPressed: () {
                                                              Navigator.pop(context);
                                                            }, child: Text('تراجع',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),);
                                              }, child: Text('رفض',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),
                                            ],)
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          FutureBuilder<DocumentSnapshot>(
                                            future: UserData.doc(data['User']).get(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<DocumentSnapshot>snapshot) {
                                              if (snapshot.hasError) {return Text("Something went wrong");}
                                              if (snapshot.hasData && !snapshot.data!.exists) {
                                                return Text("Document does not exist");}

                                              if (snapshot.connectionState == ConnectionState.done) {
                                                Map<String, dynamic> dataUser = snapshot.data!.data() as Map<String, dynamic>;
                                                Name=dataUser['Name'];
                                                return Text(dataUser['Name'],style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),);
                                              }

                                              return Text("loading");
                                            },
                                          ),
                                          Text('عدد المنتجات (${data['items'].length})',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                                          Text('السعر (${data['totalPrice']})',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),

                                        ],
                                      )
                                    ],
                                  )
                              ),
                            );
                          }).toList(),
                        ),
                      ):Container(color: Colors.white,child: Center(child: Container(height: 150,width: 150,child: CircularProgressIndicator(color: Colors.teal,backgroundColor: Colors.blue,)),),);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/* */