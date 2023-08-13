import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class sales extends StatefulWidget {
  const sales({Key? key}) : super(key: key);

  @override
  State<sales> createState() => _salesState();
}
Map<String, dynamic>? datasales;
class _salesState extends State<sales> {
  GetDataFromDataBase() async {
    try{DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('SalesData').doc('SalesData').get();
      datasales!= snapshot.data()!;
    print('done');
    }
    catch(e){print(e);}
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GetDataFromDataBase();
  }
  CollectionReference DataSales = FirebaseFirestore.instance.collection('SalesData');

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<DocumentSnapshot>(
        future: DataSales.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 77,
                  padding: EdgeInsets.only(left: 25,right: 25),
                  margin: EdgeInsets.only(right: 104,left: 104),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(39),
                      border: Border.all(color: Color.fromRGBO(0, 245, 214, 10),width: 3)),
                  child: Text('المبيعات',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      color: Color.fromRGBO(0, 245, 214, 10)),),
                ),
                Container(
                  height: 370,
                  margin: EdgeInsets.only(left: 21,right: 21),
                  padding: EdgeInsets.only(top:14 ,bottom:14 ),
                  decoration:BoxDecoration(border: Border.all(color: Color.fromRGBO(0, 245, 214, 10),width: 3),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(data['OrdarDone'].toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                          Text('الطلبات المكتملة',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: Color.fromRGBO(0, 245, 214, 10),
                        margin: EdgeInsets.only(left:33 ,right:33 ,bottom: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(data['OrdarCancel'].toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                          Text('الطلبات غير مكتملة',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: Color.fromRGBO(0, 245, 214, 10),
                        margin: EdgeInsets.only(left:33 ,right:33 ,bottom: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${data['TotalPrifit']} ₪',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                          Text('اجمالي الايرادات',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: Color.fromRGBO(0, 245, 214, 10),
                        margin: EdgeInsets.only(left:33 ,right:33 ,bottom: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${data['TotalCnceldPrice']} ₪',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                          Text('مجمل سعر الطلبات غير مكتملة',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: Color.fromRGBO(0, 245, 214, 10),
                        margin: EdgeInsets.only(left:33 ,right:33 ,bottom: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${data['TotalDiscount']} ₪',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                          Text('اجمالي الخصومات',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ],
            );;
          }

          return Text("loading");
        },
      )

    );
  }
}

