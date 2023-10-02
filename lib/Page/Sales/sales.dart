import 'package:adminhala/Page/Sales/DetalsModelsPage.dart';
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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Images/logowelcome.png'),
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
      body: FutureBuilder<DocumentSnapshot>(
        future: DataSales.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: h/35,bottom: h/35),
                    height: h/12,
                    width: w/2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w/10),
                        border: Border.all(color: Colors.black,width: 1)),
                    child: Center(
                      child: Text('المبيعات',style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: w/13,
                          color: Colors.black),),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(top: h/20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => salesDetales(NumModel: 0),));
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: w/35),
                              height: h/9,width: w/2.5,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.red,
                                    Colors.purple
                                  ]
                                ),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Align(alignment: Alignment.center,child: Text("طلبات غير مكتملة",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: w/20),)),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => salesDetales(NumModel: 1),));

                            },
                            child: Container(
                              margin: EdgeInsets.only(right: w/35),
                              height: h/9,width: w/2.5,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.greenAccent,
                                        Colors.teal
                                      ]
                                  ),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Align(alignment: Alignment.center,child: Text("الطلبات المكتملة",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: w/20),)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: h/10,),
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => salesDetales(NumModel: 2),));

                        },
                        child: Container(
                          height: h/9,width: w*0.95,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.greenAccent,
                                    Colors.teal
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Align(alignment: Alignment.center,child: Text("اجمالي المبيعات",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: w/20),)),
                        ),
                      ),
                      SizedBox(height: h/10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => salesDetales(NumModel: 3),));

                            },
                            child: Container(
                              margin: EdgeInsets.only(left: w/35),
                              height: h/9,width: w/2.5,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.greenAccent,
                                        Colors.teal
                                      ]
                                  ),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Align(alignment: Alignment.center,child: Text("الأكثر طلباً",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: w/20),)),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => salesDetales(NumModel: 4),));

                            },
                            child: Container(
                              margin: EdgeInsets.only(right: w/35),
                              height: h/9,width: w/2.5,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.greenAccent,
                                        Colors.teal
                                      ]
                                  ),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Align(alignment: Alignment.center,child: Text("التقيم",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: w/20),)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                /*  Container(
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
                  ),*/
                ],
              ),
            );
          }

          return const Text("loading");
        },
      )

    );
  }
}

