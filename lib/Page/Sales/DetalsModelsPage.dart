import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class salesDetales extends StatefulWidget {
  int NumModel;
  salesDetales({required this.NumModel,Key? key}) : super(key: key);

  @override
  State<salesDetales> createState() => _salesDetalesState();
}

class _salesDetalesState extends State<salesDetales> {
  String DataTybeCollection='';
  String DataTybeDocumant='';
  Color ccc=Colors.red;

  @override
  void initState() {

    if(widget.NumModel==0){DataTybeCollection='Ordarfailed';}
    else if(widget.NumModel==1){DataTybeCollection='OrdarDone';}
    else if(widget.NumModel==2){DataTybeCollection='SalesData';}
    else if(widget.NumModel==3){DataTybeCollection='Prudacts';}
    else if(widget.NumModel==4){DataTybeCollection='AdminData';}
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
   if(widget.NumModel==0){
     return Scaffold(
       body: Container(
         child: FutureBuilder(
           future:widget.NumModel==0? FirebaseFirestore.instance.collection(DataTybeCollection).where('AdminUid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get():
           FirebaseFirestore.instance.collection(DataTybeCollection).doc(DataTybeDocumant).get(),
           builder:
               (BuildContext context, AsyncSnapshot snapshot) {

             if (snapshot.hasError) {
               return Text("Something went wrong");
             }

             if (snapshot.connectionState == ConnectionState.done) {
               return SizedBox(
                 child: ListView.builder(
                   shrinkWrap: true,
                   itemCount: snapshot.data!.size,
                   itemBuilder: (context, index) =>
                       InkWell(
                         onTap: () {
                           showBottomSheet(context: context, builder: (context) =>
                               Container(
                                 height: h*0.8,
                                 color: Colors.black54,
                                 child: Column(
                                   children: [
                                     //NameUser
                                     Text('الاسم'+' : ${snapshot.data.docs[index]['NameUser']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/18,color: Colors.white),),
                                     Text('رقم الطلب'+' : ${snapshot.data.docs[index]['orderID']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/18,color: Colors.white),),
                                     ListView.builder(
                                       physics: NeverScrollableScrollPhysics(),
                                       shrinkWrap: true,
                                       itemCount:snapshot.data.docs[index]['items'].length,
                                       itemBuilder: (context, index1) =>
                                           Container(
                                             child: Container(
                                                 decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.circular(15),
                                                     border: Border.all(color: Colors.white,width: 2)
                                                 ),
                                                 margin: EdgeInsets.only(top: h/50,bottom: h/50,left: w/30,right: w/30),
                                                 child:Center(child: Text(snapshot.data.docs[index]['items'][index1]['Name'],style: TextStyle(fontSize: w/30,color: Colors.white,fontWeight: FontWeight.bold),))
                                             ),
                                           )
                                       ,),
                                     Text('السعر الاجمالي'+' : ${snapshot.data.docs[index]['totalPrice'].toString().replaceAll(' ₪', '')}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/18,color: Colors.white),),
                                   ],
                                 ),
                               ),);
                         },
                         child: Container(
                           margin: EdgeInsets.only(top: h/35,left: w/15,right: w/15),
                           padding: EdgeInsets.only(top: h/30,bottom: h/30,left: w/20,right: w/20),
                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                               gradient: LinearGradient(
                                   begin: Alignment.topRight,
                                   end: Alignment.bottomLeft,
                                   colors: [
                                     Colors.red,
                                     Colors.purpleAccent,
                                   ]
                               )),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(snapshot.data!.docs[index]['NameUser'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
                                 fontSize: w/20,),),
                               Text((snapshot.data!.docs[index]['totalPrice']).toString().replaceAll(' ₪', ''),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
                                 fontSize: w/20,),),
                             ],
                           ),
                         ),
                       ),),
               );
             }

             return CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.black,);
           },
         ),
       ),
     );
   }
   else if(widget.NumModel==1){
     return Scaffold(
       body: Container(
         child: FutureBuilder(
           future:FirebaseFirestore.instance.collection(DataTybeCollection).where('AdminUid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
           builder:
               (BuildContext context, AsyncSnapshot snapshot) {

             if (snapshot.hasError) {
               return Text("Something went wrong");
             }

             if (snapshot.connectionState == ConnectionState.done) {
               return SizedBox(
                 child: ListView.builder(
                   shrinkWrap: true,
                   itemCount: snapshot.data!.size,
                   itemBuilder: (context, index) =>
                       InkWell(
                         onTap: () {
                           showBottomSheet(context: context, builder: (context) =>
                               Container(
                                 height: h*0.9,
                                 color: Colors.black54,
                                 child: SingleChildScrollView(
                                   child: Column(
                                     children: [
                                       //NameUser
                                       Text('الاسم'+' : ${snapshot.data.docs[index]['NameUser']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/18,color: Colors.white),),
                                       Text('رقم الطلب'+' : ${snapshot.data.docs[index]['orderID']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/18,color: Colors.white),),
                                       ListView.builder(
                                         physics: NeverScrollableScrollPhysics(),
                                         shrinkWrap: true,
                                         itemCount:snapshot.data.docs[index]['items'].length,
                                         itemBuilder: (context, index1) =>
                                             Container(
                                               child: Container(
                                                 padding: EdgeInsets.symmetric(vertical: h/100),
                                                   decoration: BoxDecoration(
                                                       borderRadius: BorderRadius.circular(15),
                                                       border: Border.all(color: Colors.white,width: 2)
                                                   ),
                                                   margin: EdgeInsets.only(top: h/50,left: w/30,right: w/30),
                                                   child:Center(child: Text(snapshot.data.docs[index]['items'][index1]['Name'],style: TextStyle(fontSize: w/30,color: Colors.white,fontWeight: FontWeight.bold),))
                                               ),
                                             )
                                         ,),
                                       Text('السعر الاجمالي'+' : ${snapshot.data.docs[index]['totalPrice'].toString().replaceAll(' ₪', '')}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/18,color: Colors.white),),
                                     ],
                                   ),
                                 ),
                               ),);
                         },
                         child: Container(
                           margin: EdgeInsets.only(top: h/35,left: w/15,right: w/15),
                           padding: EdgeInsets.only(top: h/30,bottom: h/30,left: w/20,right: w/20),
                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                               gradient: LinearGradient(
                                   begin: Alignment.topRight,
                                   end: Alignment.bottomLeft,
                                   colors: [
                                     Colors.green,
                                     Colors.blue,
                                   ]
                               )),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(snapshot.data!.docs[index]['NameUser'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
                                 fontSize: w/20,),),
                               Text((snapshot.data!.docs[index]['totalPrice']).toString().replaceAll(' ₪', ''),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
                                 fontSize: w/20,),),
                             ],
                           ),
                         ),
                       ),),
               );
             }

             return CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.black,);
           },
         ),
       ),
     );
   }
   else if(widget.NumModel==2){
     return Scaffold(
       body: Container(
         child: FutureBuilder(
           future:FirebaseFirestore.instance.collection(DataTybeCollection).where('Uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
           builder:
               (BuildContext context, AsyncSnapshot snapshot) {

             if (snapshot.hasError) {
               return Text("Something went wrong");
             }

             if (snapshot.connectionState == ConnectionState.done) {
               return SizedBox(
                 child: ListView.builder(
                   shrinkWrap: true,
                   itemCount: snapshot.data!.size,
                   itemBuilder: (context, index) =>
                      Container(
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(top: h*0.25,bottom: h*0.25),
                            height: h/2,
                            width: w/1.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(width: 2,color: Colors.black)
                            ),
                            child: Stack(
                              children:[
                                Column(
                                children: [
                                  Text('جدول المبيعات',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/15),),
                                  Container(height: 1,width: double.infinity,color: Colors.black,),
                                  Container(height: h/2.34,width:1,color: Colors.black,),
                                ],
                              ),
                                Positioned(
                                    top: h/15,
                                    right: 2,
                                    child: Align(child: Text('اجمالي المبيعات',style: TextStyle(fontSize: w/22,fontWeight: FontWeight.bold),)
                                      ,alignment: Alignment.topLeft,)),
                                Positioned(
                                    top: h/15,
                                    left: w/20,
                                    child: Align(child: Text(snapshot.data.docs[index]['TotalPrifit'].toString(),
                                      style: TextStyle(fontSize: w/15,fontWeight: FontWeight.bold),)
                                      ,alignment: Alignment.topLeft,)),
                                Positioned(
                                    top: h/7.5,
                                    child: Container(color: Colors.black,width: w*0.8,height: 1,)),
                                Positioned(
                                    top: h/7,
                                    right: 2,
                                    child: Align(child: Text('اجمالي سعر الطلبات \n غير ناجحة',style: TextStyle(fontSize: w/22,fontWeight: FontWeight.bold),)
                                      ,alignment: Alignment.centerRight,)),
                                Positioned(
                                    top: h/6.5,
                                    left: w/20,
                                    child: Align(child: Text(snapshot.data.docs[index]['TotalCnceldPrice'].toString(),
                                      style: TextStyle(fontSize: w/15,fontWeight: FontWeight.bold),)
                                      ,alignment: Alignment.topLeft,)),
                                Positioned(
                                    top: h/4.5,
                                    child: Container(color: Colors.black,width: w*0.8,height: 1,)),
                                Positioned(
                                    top: h/3.9,
                                    right: 2,
                                    child: Align(child: Text('اجمالي الخصومات',style: TextStyle(fontSize: w/22,fontWeight: FontWeight.bold),)
                                      ,alignment: Alignment.topLeft,)),
                                Positioned(
                                    top: h/3.9,
                                    left: w/20,
                                    child: Align(child: Text(snapshot.data.docs[index]['TotalDiscount'].toString(),
                                      style: TextStyle(fontSize: w/15,fontWeight: FontWeight.bold),)
                                      ,alignment: Alignment.topLeft,)),
                                Positioned(
                                    top: h/3.2,
                                    child: Container(color: Colors.black,width: w*0.8,height: 1,)),
                                Positioned(
                                    top: h/3,
                                    right: 2,
                                    child: Align(child: Text('عدد الطلبات الناجحة',style: TextStyle(fontSize: w/22,fontWeight: FontWeight.bold),)
                                      ,alignment: Alignment.topLeft,)),
                                Positioned(
                                    top: h/3,
                                    left: w/20,
                                    child: Align(child: Text(snapshot.data.docs[index]['OrdarDone'].toString(),
                                      style: TextStyle(fontSize: w/15,fontWeight: FontWeight.bold),)
                                      ,alignment: Alignment.topLeft,)),
                                Positioned(
                                    top: h/2.5,
                                    child: Container(color: Colors.black,width: w*0.8,height: 1,)),
                                Positioned(
                                    top: h/2.45,
                                    right: 2,
                                    child: Align(child: Text('عدد الطلبات \n غير ناجحة',style: TextStyle(fontSize: w/22,fontWeight: FontWeight.bold),)
                                      ,alignment: Alignment.topLeft,)),
                                Positioned(
                                    top: h/2.35,
                                    left: w/20,
                                    child: Align(child: Text(snapshot.data.docs[index]['OrdarCancel'].toString(),
                                      style: TextStyle(fontSize: w/15,fontWeight: FontWeight.bold),)
                                      ,alignment: Alignment.topLeft,)),
                              ]
                            ),
                          ),
                        ),
                      )
                 ),
               );
             }

             return CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.black,);
           },
         ),
       ),
     );
   }
   else if(widget.NumModel==3){
     return Scaffold(
       body: SingleChildScrollView(
         child: Container(
           margin: EdgeInsets.only(top: h/20),
           child: FutureBuilder(
             future:FirebaseFirestore.instance.collection(DataTybeCollection).where('IdMarket',isEqualTo: FirebaseAuth.instance.currentUser!.uid).
             where('Count_requests',isGreaterThan: 10).orderBy('Count_requests')
                 .get(),
             builder:
                 (BuildContext context, AsyncSnapshot snapshot) {

               if (snapshot.hasError) {
                 return Text("Something went wrong");
               }

               if (snapshot.connectionState == ConnectionState.done) {
                 return SizedBox(
                   child: ListView.builder(
                     physics: NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                     itemCount: snapshot.data!.size,
                     itemBuilder: (context, index) =>
                         Container(
                           padding: EdgeInsets.symmetric(horizontal: w*0.03),
                           height: h/7,
                           width: w*0.9,
                           decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2),borderRadius: BorderRadius.circular(15)),
                           margin: EdgeInsets.all(10),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text('الصنف :'+snapshot.data.docs[index]['Name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/20),),
                                   Text('عدد مرات الطلب :'+'${snapshot.data.docs[index]['Count_requests']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/20),)
                                 ],
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text('الخصم :'+'${snapshot.data.docs[index]['Discount']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/20),),
                                   Text('السعر :'+'${snapshot.data.docs[index]['Prise']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/20),)
                                 ],
                               ),
                             ],
                           ),
                         ),
                   ),
                 );
               }

               return CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.black,);
             },
           ),
         ),
       ),
     );
   }
   else if(widget.NumModel==4){
     return Scaffold(
       body: SingleChildScrollView(
         child: Container(
           margin: EdgeInsets.only(top: h/20),
           child: FutureBuilder<DocumentSnapshot>(
             future:FirebaseFirestore.instance.collection(DataTybeCollection).
             doc(FirebaseAuth.instance.currentUser!.uid).
             collection('Raiting').doc('0').get(),
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
                   children: [
                     ListView.builder(
                       physics: NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       itemCount: data['Rating'].length,
                       itemBuilder: (context, index) =>
                           Container(
                             height: h/7,
                             padding: EdgeInsets.symmetric(horizontal: w*0.03),
                             margin: EdgeInsets.only(top: h/30,left: w/20,right: w/20),
                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.black,width: 1)),
                             child: Column(
                               children: [
                                 Align(alignment: Alignment.topRight,child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: List.generate(data['Rating'][index]['RateStars'], (index) {
                                         return Icon(Icons.star,color: Colors.orange,);
                                       }),
                                     ),
                                     Text(data['Rating'][index]['Name'],style: TextStyle(
                                       fontSize: w/20
                                     ),),
                                   ],
                                 )),
                                 Align(
                                   alignment: Alignment.centerRight,
                                   child: Text(
                                   data['Rating'][index]['Comment']
                                 ),),
                                 Align(
                                   alignment: Alignment.bottomLeft,
                                   child:Text(DateFormat.yMd().add_jm().format(data['Rating'][index]['Date'].toDate()).toString(),
                                     style: TextStyle(fontSize: w/30,color: Colors.black,fontWeight: FontWeight.w300),),
                                 ),
                                 Align(
                                   alignment: Alignment.centerRight,
                                   child: Text('رقم الطلب :'+'${data['Rating'][index]['IdOrdar'].toString()}'),),
                               ],
                             ),
                           ),),
                   ],
                 );;
               }

               return Text("loading");
             },
           ),
         ),
       ),
     );
   }
   else {return Container(color: Colors.red,);}
  }
}
