import 'package:adminhala/models/SnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../models/FireBaseStatemant.dart';

class Discount extends StatefulWidget {
  const Discount({Key? key}) : super(key: key);

  @override
  State<Discount> createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  final DiscountValue=TextEditingController();
  final DiscountNum =TextEditingController();
  final DiscountCode=TextEditingController();
  String generateRandomCode() {
    const String chars = 'abcdef0123456789ghijklmnopq0123456789rstuv0123456789wxyz0123456789';
    final Random random = Random();
    String code = '';

    for (int i = 0; i < 7; i++) {
      final int randomIndex = random.nextInt(chars.length);
      code += chars[randomIndex];
    }

    return code;
  }

  @override
  Widget build(BuildContext context) {
    FireBase DataBase=FireBase();
    return Scaffold(
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
      body: Column(
        children: [
          Center(child: Image.asset('assets/Images/logowelcome.png',height: 120,)),
          Container(
            margin: EdgeInsets.only(left: 40,right: 40,bottom: 10),
            child: Column(
              children: [
                TextField(
                  controller:DiscountValue,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black45),
                  maxLength: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(50.0),
                      topRight: Radius.circular(10.0),
                    ),),
                    hintText: 'قيمة الخصم',
                  ),
                ),
                TextField(
                  controller: DiscountNum,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black45),
                  maxLength: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(50.0),
                      topRight: Radius.circular(10.0),
                    ),),
                    hintText: 'عدد الاشخاص المستفيدين',
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

    //Text('عشوائي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    InkWell(
                      onTap: (){DiscountCode.text=generateRandomCode();},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            colors: [Colors.tealAccent,Colors.blue]
                          )
                        ),
                        child: Row(
                          children: [
                            Text('كود عشوائي',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            Icon(Icons.confirmation_number_outlined),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: DiscountCode,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black45),
                        maxLength: 7,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(50.0),
                            topRight: Radius.circular(10.0),
                          ),),
                          hintText: 'رمز الخصم',
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(onPressed: (){
                  showDialog(context: context, builder: (context) => AlertDialog(
                    backgroundColor:Colors.white,
                    content: Container(
                      height: 180,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('هل انت متأكد من إضافة الكود؟'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("${DiscountValue.text}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.red),),
                              Text(":قيمة الخصم ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("${DiscountNum.text}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.red),),
                              Text(":مرات الاستخدام ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("${DiscountCode.text}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.red),),
                              Text(":كود الخصم ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 45,right: 45),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(onPressed: () async {
                                DataBase.DiscountUpdate(Prise: int.parse(DiscountNum.text)*int.parse(DiscountValue.text));
                                await DataBase.CodeSet(DiscountCode:DiscountCode.text,DiscountNum:DiscountNum.text,DiscountValue:DiscountValue.text ,Uid: FirebaseAuth.instance.currentUser!.uid);

                                Navigator.pop(context);
                                showSnackBar(context: context, text: 'تم إضافة الكود بنجاح', colors: Colors.green);
                              }, child: Text('نعم'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),),
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                                DiscountCode.text='';
                                DiscountNum.text='';
                                DiscountValue.text='';
                              }, child: Text('لا'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange)),)
                            ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),);

                }, child: Text('إضافة',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                fixedSize:MaterialStateProperty.all(Size(200, 35)),
                ),
                ),
                SizedBox(height: 30),
                TextButton(onPressed: (){
                  showDialog(context: context, builder: (context) =>
                   Container(
                     decoration: BoxDecoration(gradient: LinearGradient(
                       begin: Alignment.bottomRight,end: Alignment.topLeft,
                         colors: [
                           Color.fromRGBO(0, 218, 174, 150),
                           Color.fromRGBO(0, 218, 0, 150),
                         ]
                     )),
                    height: 500,
                    width: 500,
                    margin: EdgeInsets.all(50),
                    child: Center(
                      child: Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('Discount').where('Uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator(color: Colors.red,);
                              }

                              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                return Text('لا يوجد أكواد',style: TextStyle(color: Colors.white),);
                              }

                              return SizedBox(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 15,right: 15),
                                          margin: EdgeInsets.only(left: 5,right: 5,top: 15),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white,),
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(index.toString(),style: TextStyle(fontSize: 18,color: Colors.black),),
                                              Text(snapshot.data!.docs[index]['DiscountCode'],style: TextStyle(fontSize: 18,color: Colors.black),),
                                              ElevatedButton(onPressed: (){
                                                showDialog(context: context, builder: (context) => AlertDialog(
                                                  content: Container(
                                                    height: 150,
                                                    color: Colors.white,
                                                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text(snapshot.data!.docs[index]['DiscountCode'],style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),),
                                                            Text('الكود',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text(snapshot.data!.docs[index]['DiscountNum'].toString(),style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),),
                                                            Text('مرات الخصم المتبقية',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text(snapshot.data!.docs[index]['DiscountValue'].toString(),style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),),
                                                            Text('قيمة الخصم',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                                                          ],
                                                        ),
                                                        ElevatedButton(onPressed: (){
                                                          Navigator.pop(context);
                                                          showDialog(context: context, builder: (context) => AlertDialog(
                                                            content: Container(
                                                              padding: EdgeInsets.all(15),
                                                              height: 150,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text("هل انت متأكد؟"),
                                                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      ElevatedButton(onPressed: () async {
                                                                        DataBase.DiscountUpdate(Prise:snapshot.data!.docs[index]['DiscountValue']*snapshot.data!.docs[index]['DiscountNum']*-1);
                                                                        await DataBase.RemoveCode(Code: snapshot.data!.docs[index]['DiscountCode'], context: context,);
                                                                       Navigator.pop(context);
                                                                      }, child: Text("نعم"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),
                                                                      ElevatedButton(onPressed: (){
                                                                        Navigator.pop(context);
                                                                      }, child: Text("لا"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),)
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),);
                                                        }, child: Text("حذف الكود"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),)
                                                      ],
                                                    ),
                                                  ),
                                                ),);
                                              }, child: Text("تفاصيل"))
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  itemCount: snapshot.data!.docs.length,
                                ),
                              );
                            },
                          ),

                        ],
                      ),
                    ),
                  ));
                }, child: Text('الكوبونات السابقة',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),



              ],
            ),
          )
        ],
      ),
    );
  }
}
