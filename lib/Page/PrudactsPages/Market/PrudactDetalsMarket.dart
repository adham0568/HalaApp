import 'dart:io';
import 'package:adminhala/models/SnackBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' show basename, url;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../models/FireBaseStatemant.dart';
import 'PrudactCollectionMarket.dart';

class PrudactsDetals_Market extends StatefulWidget {
  Map Prudact;
  int Index;
  List PrudactList;
  PrudactsDetals_Market({Key? key,required this.Prudact,required this.Index,required this.PrudactList}) : super(key: key);

  @override
  State<PrudactsDetals_Market> createState() => _PrudactsDetals_MarketState();
}


class _PrudactsDetals_MarketState extends State<PrudactsDetals_Market> {
  FireBase EditData=FireBase();

  final NewNamePrudact=TextEditingController();
  final Prise=TextEditingController();
  final PrudactDiscount=TextEditingController();
  final detalsPrudact=TextEditingController();
  final Count_Quantity=TextEditingController();

  File? imgPath;
  String? imgName;
  bool Imagedone=false;

  OpenStdyo1() async {
    final pickedImg = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          String random = Uuid().v1();
          imgName = "$random$imgName";
          setState(() {
            Imagedone = true;
          });
        });
      }
      else {
        print('NoImege');
      }
    }
    catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    NewNamePrudact.text=widget.Prudact['Name'];
    Prise.text=widget.Prudact['Prise'].toString();
    PrudactDiscount.text=widget.Prudact['Discount'].toString();
    detalsPrudact.text=widget.Prudact['PrudactsDetals'];
    Count_Quantity.text=widget.Prudact['Count_Quantity'].toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    setState(() {});
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Transform.translate(
              offset: Offset(0,50),
              child:widget.Prudact['Opitions'].length >=1 ? Column(
                children: [
                  Text('لا يمكن تعديل هذا المنتج بامكانك ازالته واضافة منتج اخر'),
                  InkWell(onTap: () {
                    showDialog(context: context, builder: (context) =>
                        AlertDialog(content: Container(
                          height: 150,
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('هل انت متأكد من ازالة هذا المنتج؟'),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      splashColor: Colors.red,
                                      hoverColor: Colors.red,
                                      focusColor: Colors.red,
                                      onTap: () async {
                                        FireBase().DeleteProduct(IdMainCollection:widget.Prudact['IdMainCollection'] ,Index: widget.Index,IdProduct: widget.Prudact['IdPrudact']);
                                        showSnackBar(context: context, text: 'تم ازالة المنتج', colors: Colors.red);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        child: Center(child: Text('نعم',style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,

                                        ),)),
                                        width:70,height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            gradient: LinearGradient(begin: Alignment.topRight,end: Alignment.bottomLeft,
                                                colors: [
                                                  Colors.teal.withOpacity(0.3),
                                                  Colors.tealAccent.withOpacity(0.2),
                                                ]
                                            )
                                        ),
                                      )),
                                  InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      splashColor: Colors.red,
                                      hoverColor: Colors.red,
                                      focusColor: Colors.red,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        child: Center(child: Text('لا',style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),)),
                                        width:70,height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            gradient: LinearGradient(begin: Alignment.topRight,end: Alignment.bottomLeft,
                                                colors: [
                                                  Colors.green.withOpacity(0.3),
                                                  Colors.tealAccent.withOpacity(0.2),
                                                ]
                                            )
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        )),);
                  },child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors:[
                                Colors.red.withOpacity(0.2),
                                Colors.pinkAccent.withOpacity(0.2),
                              ]
                          )
                      ),
                      child: Icon(Icons.delete,color: Colors.red,),
                      height: 50,width: 50))
                ],
              ):
              InkWell(
                onTap: (){
                  showDialog(context: context, builder: (context) =>
                      AlertDialog(content: Container(
                        height: h*0.9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Edit Prudact',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ElevatedButton(style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),onPressed: (){
                              OpenStdyo1();
                            }, child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('Add New Image'),Icon(Icons.camera)],)),
                            TextFormField(
                              controller: Prise,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Edit Prudact Prise'
                              ),
                            ),
                            TextFormField(
                              controller: PrudactDiscount,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Edit Prudact Discount'
                              ),
                            ),
                            TextFormField(
                              controller: NewNamePrudact,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Edit Prudact Name'
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: Count_Quantity,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  hintText: 'الكمية'
                              ),
                            ),
                            TextField(
                              controller:detalsPrudact,
                              maxLines: 8,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Prudact New Discrebtion'
                              ),
                            ),//discreption

                            Container(
                              margin: EdgeInsets.symmetric(horizontal: w/10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(onPressed: (){
                                    FireBase().UpdatePrudactsMarket(
                                      Index: widget.Index,
                                      IdMainCollection: widget.Prudact['IdMainCollection'],
                                      IdMarket: widget.Prudact['IdMarket'],
                                      Discount: double.parse(PrudactDiscount.text),
                                      Prise: double.parse(Prise.text),
                                      Name:NewNamePrudact.text,
                                      DetalsPrudact:detalsPrudact.text,
                                      Count_Quantity: int.parse(Count_Quantity.text),
                                      Count_requests: widget.Prudact['Count_requests'],
                                      Opitions: widget.Prudact['Opitions'],
                                      TybePrudact:widget.Prudact['TybePrudact'],
                                      IdPrudacts: widget.Prudact['IdPrudact'],
                                      imgName: imgName!,
                                      imgPath: imgPath!,
                                    );
                                    Navigator.pop(context);
                                    },
                                    child: Text('تعديل'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange)),),
                                  ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('الغاء'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange)),),
                                ],
                              ),
                            ),
                            ElevatedButton(onPressed: (){Navigator.pop(context);
                            showDialog(context: context, builder: (context) =>
                                AlertDialog(
                                  content: Container(
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('are you sure?'),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(onPressed: () async {
                                              FireBase().DeleteProduct(IdMainCollection:widget.Prudact['IdMainCollection'] ,Index: widget.Index,IdProduct: widget.Prudact['IdPrudact']);
                                              Navigator.pop(context);
                                            }, child: Text('Yes'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),
                                            ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('No'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),),
                                          ],
                                        ),
                                      ],
                                    ),),
                                ),);
                            }, child: Text('Remove Prudact'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),//Remove Collection


                          ],
                        ),
                      ))
                    ,);
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey),
                  child: Icon(Icons.settings,size: 60,color: Colors.white,),
                ),

              ),
            ),//add Prudacts
            Container(height: 150,),//Add Prudct Or Remove Collection
            Column(
              children: [
                InkWell(
                  onTap: (){},
                  child: Container(
                    height: 400,
                    width: 400,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl:widget.Prudact['ImageUrl'],
                      placeholder: (context, url) => CircularProgressIndicator(color: Colors.red),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(widget.Prudact['Name'],style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                Text(widget.Prudact['Prise'].toString()),
                Text(widget.Prudact['PrudactsDetals'])
              ],
            )
          ],
        ),
      ),
    );;
  }
}
