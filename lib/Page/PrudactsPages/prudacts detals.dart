import 'dart:io';
import 'package:adminhala/models/SnackBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' show basename, url;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../models/FireBaseStatemant.dart';

class PrudactsDetals extends StatefulWidget {
  Map DataFromeCollection;
  Map PrudactData;
  Map DataMainCollection;
  int Index;
  List PrudactList;
  PrudactsDetals({Key? key,required this.PrudactData,required this.DataMainCollection,required this.DataFromeCollection,required this.Index,required this.PrudactList}) : super(key: key);

  @override
  State<PrudactsDetals> createState() => _PrudactsDetalsState();
}



class _PrudactsDetalsState extends State<PrudactsDetals> {
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
          String random = const Uuid().v1();
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
    NewNamePrudact.text=widget.PrudactData['Name'];
    Prise.text=widget.PrudactData['Prise'].toString();
    PrudactDiscount.text=widget.PrudactData['Discount'].toString();
    detalsPrudact.text=widget.PrudactData['PrudactsDetals'];
    Count_Quantity.text=widget.PrudactData['Count_Quantity'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Transform.translate(
              offset: const Offset(0,50),
              child:widget.PrudactData['Opitions'].length >=1 ? Column(
                children: [
                  const Text('لا يمكن تعديل هذا المنتج بامكانك ازالته واضافة منتج اخر'),
                  InkWell(onTap: () {
                    showDialog(context: context, builder: (context) =>
                      AlertDialog(content: SizedBox(
                        height: 150,
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('هل انت متأكد من ازالة هذا المنتج؟'),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(onPressed: () {
                              print(widget.PrudactData['IdPrudact']);
                            }, child: const Text('sssssssssss')),
                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              splashColor: Colors.red,
                                hoverColor: Colors.red,
                                focusColor: Colors.red,
                                onTap: () async {
                                  CollectionReference users =  FirebaseFirestore.instance.collection('Prudacts');
                                  users.doc('${widget.PrudactData['IdPrudact']}').delete();
                                  showSnackBar(context: context, text: 'تم ازالة المنتج', colors: Colors.red);
                                  Navigator.pop(context);
                                },
                                child: Container(
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
                                  child: const Center(child: Text('نعم',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,

                                  ),)),
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
                                  child: const Center(child: Text('لا',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),)),
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
                    height: 50,width: 50,
                    child: const Icon(Icons.delete,color: Colors.red,)))
                ],
              ):
              InkWell(
                onTap: (){
                  showDialog(context: context, builder: (context) =>
                      AlertDialog(content: SizedBox(height: 650,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Edit Prudact',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ElevatedButton(style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),onPressed: (){
                              OpenStdyo1();
                            }, child: const Row(mainAxisAlignment: MainAxisAlignment.center,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(onPressed: (){
                                  EditData.UpdatePrudactsHala(
                                      PrudactList:widget.PrudactList ,
                                      Index: widget.Index,
                                      Count_requests:widget.PrudactData['Count_requests'] ,
                                      Count_Quantity:int.parse(Count_Quantity.text) ,
                                      Opitions: [],
                                      TybePrudact: 0,
                                      Discount:double.parse(PrudactDiscount.text),
                                      IdMainCollection:widget.DataMainCollection['IdPrudactMainCollection'],
                                      Name: NewNamePrudact.text,
                                      IdPrudacts: widget.PrudactData['IdPrudact'],
                                      DetalsPrudact: detalsPrudact.text,
                                      imgPath: imgPath!,
                                      imgName: imgName!,
                                      IdCollection: widget.PrudactData['IdCollection'],
                                      Data: widget.DataFromeCollection,
                                      Prise:double.parse(Prise.text),
                                      DataMainCollection: widget.DataMainCollection,
                                      IdMarket:FirebaseAuth.instance.currentUser!.uid,
                                  );
                                  Navigator.pop(context);
                                },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)), child: const Text('Edit'),),
                                ElevatedButton(onPressed: (){Navigator.pop(context);},style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange)), child: const Text('Cancel'),),
                              ],
                            ),
                            ElevatedButton(onPressed: (){Navigator.pop(context);
                            showDialog(context: context, builder: (context) =>
                                AlertDialog(
                                  content: SizedBox(
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text('are you sure?'),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(onPressed: () async {
                                              FireBase().DeleteProductHala(
                                                  IdMainCollection:widget.PrudactData['IdMainCollection'] ,
                                                  Prudact:widget.PrudactList ,
                                                  Index:widget.Index ,
                                                  IdProduct:widget.PrudactData['IdPrudact'],
                                                  CollectionId:widget.PrudactData['IdCollection']);
                                              Navigator.pop(context);
                                            },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)), child: const Text('Yes'),),
                                            ElevatedButton(onPressed: (){Navigator.pop(context);},style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)), child: const Text('No'),),
                                          ],
                                        ),
                                      ],
                                    ),),
                                ),);
                            },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)), child: const Text('Remove Prudact'),),//Remove Collection


                          ],
                        ),
                      ))
                    ,);
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey),
                  child: const Icon(Icons.settings,size: 60,color: Colors.white,),
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
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl:widget.PrudactData['ImageUrl'],
                      placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
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
                Text(widget.PrudactData['Name'],style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                Text(widget.PrudactData['Prise'].toString()),
                Text(widget.PrudactData['PrudactsDetals'])
              ],
            )
          ],
        ),
      ),
    );
  }
}
